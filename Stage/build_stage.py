"""Bouw bewerkbare Typst-bronnen tot invulbare PDF's, zonder LaTeX.

python -m pip install -r Stage/requirements.txt
python Stage/build_stage.py
"""
from __future__ import annotations

import argparse
import io
import json
from pathlib import Path
import re

import typst
from pypdf import PdfReader, PdfWriter
from pypdf.generic import (
    ArrayObject, BooleanObject, DecodedStreamObject, DictionaryObject,
    FloatObject, NameObject, NumberObject, TextStringObject,
)

ROOT = Path(__file__).resolve().parent
PREFIX = 'https://typst-form.invalid/'


def dictionary(**kwargs):
    return DictionaryObject({NameObject('/'+key): value for key, value in kwargs.items()})


def action(script):
    return dictionary(S=NameObject('/JavaScript'), JS=TextStringObject(script))


def appearance(writer, width, height, checked=False):
    stream = DecodedStreamObject()
    if checked:
        # Vector cross: no dependency on checkbox fonts in the PDF reader.
        data = f'q 0 G 1 w 2 2 m {width-2} {height-2} l S 2 {height-2} m {width-2} 2 l S Q'
    else:
        data = 'q Q'
    stream.set_data(data.encode('ascii'))
    stream.update(dictionary(Type=NameObject('/XObject'), Subtype=NameObject('/Form'),
        BBox=ArrayObject([FloatObject(v) for v in (0, 0, width, height)]),
        Resources=DictionaryObject()))
    return writer._add_object(stream)


def groups_from_source(source):
    """Every displayed score row is a group; repeated overview rows share names."""
    groups = {}
    for match in re.finditer(r'#scores\(\((.*?)\)', source, re.S):
        names = re.findall(r'"([^"]+)"', match[1])
        for name in names:
            groups[name] = names
    # The interview uses E2..NVT6 on both detailed and overview pages.
    for i in range(2, 7):
        names = [f'{prefix}{i}' for prefix in ('E', 'G', 'V', 'M', 'O', 'NVT')]
        if any(name in groups for name in names):
            groups.update({name: names for name in names})
    return groups


def add_forms(pdf, source):
    writer = PdfWriter()
    writer.clone_document_from_reader(PdfReader(io.BytesIO(pdf)))
    helvetica = writer._add_object(dictionary(Type=NameObject('/Font'),
        Subtype=NameObject('/Type1'), BaseFont=NameObject('/Helvetica'),
        Encoding=NameObject('/WinAnsiEncoding')))
    fields = {}; field_kinds = {}; calc_order = ArrayObject()
    groups = groups_from_source(source)
    widgets = 0
    for page in writer.pages:
        page[NameObject('/Tabs')] = NameObject('/S')
        for ref in page.get('/Annots', []):
            annotation = ref.get_object()
            uri = str(annotation.get('/A', {}).get('/URI', ''))
            if not uri.startswith(PREFIX):
                continue
            pieces = uri[len(PREFIX):].split('/')
            kind, name = pieces[0], pieces[-1]
            if kind not in ('text', 'multi', 'check', 'score'):
                raise ValueError(f'Onbekend veldtype: {uri}')
            rect = annotation['/Rect']
            width, height = float(rect[2])-float(rect[0]), float(rect[3])-float(rect[1])
            if name not in fields:
                field = dictionary(T=TextStringObject(name), TU=TextStringObject(name),
                    FT=NameObject('/Btn' if kind=='check' else '/Tx'),
                    Ff=NumberObject(4096 if kind=='multi' else 1 if kind=='score' else 0),
                    V=NameObject('/Off') if kind=='check' else TextStringObject(''),
                    Kids=ArrayObject())
                if kind != 'check':
                    field[NameObject('/DA')] = TextStringObject('/Helv 10.5 Tf 0 g')
                if kind == 'score':
                    start, end = map(int, pieces[1].split('-'))
                    field[NameObject('/Q')] = NumberObject(1)
                    field[NameObject('/AA')] = dictionary(C=action(f'event.value = stageScore(this, {start}, {end});'))
                fields[name] = writer._add_object(field)
                field_kinds[name] = kind
                if kind == 'score': calc_order.append(fields[name])
            elif field_kinds[name] != kind:
                raise ValueError(f'Typeconflict voor veld {name}')
            annotation.clear()
            annotation.update(dictionary(Type=NameObject('/Annot'), Subtype=NameObject('/Widget'),
                Rect=rect, Parent=fields[name], P=page.indirect_reference,
                F=NumberObject(4), BS=dictionary(W=NumberObject(0))))
            off = appearance(writer, width, height)
            if kind == 'check':
                annotation[NameObject('/AS')] = NameObject('/Off')
                annotation[NameObject('/AP')] = dictionary(N=dictionary(
                    Off=off, On=appearance(writer, width, height, True)))
                if name in groups:
                    script = f'stageKies(this, {json.dumps(name)}, {json.dumps(groups[name])});'
                    annotation[NameObject('/AA')] = dictionary(U=action(script))
            else:
                annotation[NameObject('/AP')] = dictionary(N=off)
            fields[name].get_object()['/Kids'].append(ref)
            widgets += 1
    if fields:
        form = dictionary(Fields=ArrayObject(list(fields.values())),
            NeedAppearances=BooleanObject(False),
            DA=TextStringObject('/Helv 10.5 Tf 0 g'),
            DR=dictionary(Font=dictionary(Helv=helvetica)))
        if calc_order:
            form[NameObject('/CO')] = calc_order
        writer.root_object[NameObject('/AcroForm')] = writer._add_object(form)
        scripts = writer.root_object.get('/Names')
        if scripts is None:
            scripts = DictionaryObject()
            writer.root_object[NameObject('/Names')] = scripts
        else:
            scripts = scripts.get_object()
        scripts[NameObject('/JavaScript')] = dictionary(Names=ArrayObject([
            TextStringObject('StageFormulier'),
            writer._add_object(action((ROOT/'beoordeling.js').read_text(encoding='utf-8'))),
        ]))
    result = io.BytesIO()
    writer.write(result)
    return result.getvalue(), len(fields), widgets


def validate(pdf, expected_fields, expected_widgets):
    reader = PdfReader(io.BytesIO(pdf))
    fields = reader.get_fields() or {}
    assert len(fields)==expected_fields, (len(fields), expected_fields)
    count = 0
    for page in reader.pages:
        for ref in page.get('/Annots', []):
            a=ref.get_object()
            assert not str(a.get('/A', {}).get('/URI','')).startswith(PREFIX)
            if a.get('/Subtype') != '/Widget': continue
            count += 1
            parent = a['/Parent']
            assert parent['/T'] in fields
            assert ref in parent['/Kids']
            assert a.get('/AP', {}).get('/N') is not None
            if parent['/FT']=='/Btn':
                assert str(a['/AS']) == str(parent['/V'])
    assert count==expected_widgets
    return len(reader.pages)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT/'PDF')
    parser.add_argument('documents', nargs='*', help='Optionele documentnamen zonder extensie')
    args=parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    paths=[ROOT/(name+'.typ') for name in args.documents] if args.documents else sorted(
        path for path in ROOT.glob('*.typ') if path.stem!='formulier')
    report={}
    for path in paths:
        source=path.read_text(encoding='utf-8')
        compiled=typst.compile(str(path), root=str(ROOT), font_paths=[str(ROOT/'Fonts')])
        pdf, fields, widgets=add_forms(compiled,source)
        pages=validate(pdf,fields,widgets)
        destination=args.output/(path.stem+'.pdf')
        destination.write_bytes(pdf)
        report[path.stem]={'pages':pages,'fields':fields,'widgets':widgets}
        print(f'{destination.name}: {pages} pagina\'s, {fields} velden, {widgets} widgets')
    (args.output/'bouwcontrole.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')


if __name__=='__main__':
    main()
