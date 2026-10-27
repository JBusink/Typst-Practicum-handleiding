"""Controleer veldstructuur, opslaan/heropenen en PDF JavaScript.

python -m unittest discover -s Stage -p test_stage.py
Voor de JavaScript-test moet node op PATH staan, of stel STAGE_NODE in.
"""
import io
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import unittest
import unicodedata

from pypdf import PdfReader, PdfWriter

ROOT=Path(__file__).resolve().parent
EXPECTED={
    'Criterium_Gericht_Interview': (43,76),
    'Das_Competenties': (0,0),
    'Feedback_NLD_week15': (51,51),
    'Feedback_NLD_week5': (99,99),
    'Zelfreflectie_NLD_week15': (74,74),
}


class StageForms(unittest.TestCase):
    def test_all_original_indicators_present(self):
        def normalize(text):
            return re.sub(r'[^\w]','',unicodedata.normalize('NFKC',text)).lower()
        originals=sorted((ROOT/'Archief').glob('*.tex'))
        self.assertEqual(len(originals),len(EXPECTED))
        for path in originals:
            source='\n'.join(re.split(r'(?<!\\)%',line)[0] for line in path.read_text(encoding='utf-8').splitlines())
            source=source.split('\\begin{document}',1)[1]
            text=' '.join(page.extract_text() for page in PdfReader(ROOT/'PDF'/(path.stem+'.pdf')).pages)
            for indicator in re.findall(r'\\item\s*(.*?)(?=\\item|\\end\{itemize\})',source,re.S):
                indicator=indicator.replace('\\&','&').replace('\\textcolor{black}{','')
                with self.subTest(document=path.stem,indicator=indicator[:60]):
                    self.assertIn(normalize(indicator),normalize(text))
            if path.stem=='Das_Competenties':
                self.assertEqual(len(re.findall(r'\bX\b',text)),source.count('\\XX'))

    def test_structure_and_roundtrip(self):
        for stem,(field_count,widget_count) in EXPECTED.items():
            with self.subTest(document=stem):
                reader=PdfReader(ROOT/'PDF'/(stem+'.pdf'))
                fields=reader.get_fields() or {}
                self.assertEqual(len(fields),field_count)
                widgets=[a.get_object() for page in reader.pages for a in page.get('/Annots',[])
                         if a.get_object().get('/Subtype')=='/Widget']
                self.assertEqual(len(widgets),widget_count)
                if not fields: continue
                writer=PdfWriter(); writer.clone_document_from_reader(reader)
                values={name: '/On' if field['/FT']=='/Btn' else '7.5' if name.startswith('score')
                        else 'Teststudent é' if not field.get('/Ff',0)&4096 else 'Eerste regel\nTweede regel'
                        for name,field in fields.items()}
                writer.update_page_form_field_values(None,values,auto_regenerate=False)
                stream=io.BytesIO(); writer.write(stream); stream.seek(0)
                reopened=PdfReader(stream)
                for name,field in reopened.get_fields().items():
                    self.assertEqual(str(field['/V']),values[name])
                for page in reopened.pages:
                    for ref in page.get('/Annots',[]):
                        widget=ref.get_object()
                        if widget.get('/Subtype')!='/Widget': continue
                        parent=widget['/Parent']; name=parent['/T']
                        self.assertEqual(str(parent['/V']),values[name])
                        self.assertIn(ref,parent['/Kids'])
                        if parent['/FT']=='/Btn': self.assertEqual(widget['/AS'],'/On')
                        self.assertTrue(widget['/AP']['/N'])

    def test_no_unintentional_duplicate_fields(self):
        for stem in ('Feedback_NLD_week15','Zelfreflectie_NLD_week15'):
            fields=PdfReader(ROOT/'PDF'/(stem+'.pdf')).get_fields()
            self.assertIn('F1pp',fields)
            self.assertIn('REF1pp',fields)
            self.assertEqual(len(fields['F1pp']['/Kids']),1)
            self.assertEqual(len(fields['REF1pp']['/Kids']),1)

    def test_synchronized_interview_fields(self):
        reader=PdfReader(ROOT/'PDF/Criterium_Gericht_Interview.pdf')
        fields=reader.get_fields()
        for i in range(2,7):
            for prefix in ('E','G','V','M','O','NVT'):
                self.assertEqual(len(fields[f'{prefix}{i}']['/Kids']),2)
        for name in ('namefield0','namefield3','namefield4'):
            self.assertEqual(len(fields[name]['/Kids']),2)
        self.assertEqual(len(reader.trailer['/Root']['/AcroForm']['/CO']),4)
        for name in ('scoreinhoud','score_onderzoek','score_project','score_data'):
            self.assertEqual(fields[name]['/Ff'] & 1,1)
            self.assertIn('/C',fields[name]['/AA'])

    def test_javascript_from_built_pdf(self):
        node=os.environ.get('STAGE_NODE') or shutil.which('node')
        if not node: self.skipTest('Node ontbreekt; stel STAGE_NODE in voor de JavaScript-test')
        reader=PdfReader(ROOT/'PDF/Criterium_Gericht_Interview.pdf')
        names=reader.trailer['/Root']['/Names']['/JavaScript']['/Names']
        script=str(names[1].get_object()['/JS'])
        fields=reader.get_fields()
        calculations={name:str(field['/AA']['/C']['/JS']) for name,field in fields.items() if name.startswith('score')}
        mouse_script=str(fields['G2']['/Kids'][0].get_object()['/AA']['/U']['/JS'])
        harness='''
const assert = require('node:assert/strict');
const fields = {};
for (let i=2;i<=6;i++) for (const c of ['E','G','V','M','O','NVT'])
    fields[c+i]={value:'Off',isBoxChecked(){ return this.value !== 'Off'; }};
let recalculations=0;
const doc={getField(n){return fields[n] || null;},calculateNow(){recalculations++;}};
function clear(){ for (const f of Object.values(fields)) f.value='Off'; }
function calculate(name){const event={value:null}; Function('event',calculations[name]).call(doc,event);return event.value;}
assert.equal(calculate('scoreinhoud'),'0.0');
for(let i=2;i<=6;i++) fields['E'+i].value='On';
assert.equal(calculate('scoreinhoud'),'10.0');
clear(); fields.E2.value='On'; fields.G3.value='On'; fields.V4.value='On'; fields.M5.value='On'; fields.O6.value='On';
assert.equal(calculate('scoreinhoud'),'5.5');
assert.equal(calculate('score_onderzoek'),'8.8');
assert.equal(calculate('score_project'),'4.5');
assert.equal(calculate('score_data'),'1.0');
clear(); fields.E2.value='On'; for(let i=3;i<=6;i++) fields['NVT'+i].value='On';
assert.equal(calculate('scoreinhoud'),'10.0');
fields.E2.value='Off';fields.NVT2.value='On';
assert.equal(calculate('scoreinhoud'),'');
fields.E2.value='On';fields.G2.value='On';
Function(mouseScript).call(doc);
assert.equal(fields.E2.value,'Off');assert.equal(fields.NVT2.value,'Off');assert.equal(fields.G2.value,'On');
assert.equal(recalculations,1);
fields.G2.value='Off';Function(mouseScript).call(doc);
assert.equal(fields.G2.value,'Off');assert.equal(recalculations,2);
'''
        # Function bodies resolve the actual embedded document functions globally.
        javascript='globalThis.eval('+json.dumps(script)+');\nconst calculations='+json.dumps(calculations)+';\nconst mouseScript='+json.dumps(mouse_script)+';\n'+harness
        result=subprocess.run([node,'-e',javascript],capture_output=True,text=True)
        self.assertEqual(result.returncode,0,result.stdout+result.stderr)


if __name__=='__main__': unittest.main()
