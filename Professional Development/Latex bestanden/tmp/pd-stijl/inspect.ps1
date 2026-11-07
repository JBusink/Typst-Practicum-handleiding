$ErrorActionPreference='Stop'
$a=New-Object -ComObject PowerPoint.Application
$root=(Get-Location).Path
$files=Get-ChildItem 'Nieuw_format_2026-2027' -Recurse -Filter '*.pptx' | Where-Object {$_.Name -ne 'Startbijeenkomst_PD.pptx'}
foreach($f in $files){
 $key=$f.Directory.Name.Replace(' ','')+'_'+$f.BaseName
 $dir=Join-Path $root ('tmp/pd-stijl/'+$key); New-Item -ItemType Directory -Force $dir | Out-Null
 $p=$a.Presentations.Open($f.FullName,$true,$false,$false)
 if($f.Name -like 'Startbijeenkomst*'){$p.Slides.Item(1).Export((Join-Path $dir '1.png'),'PNG',1280,720)}else{$p.Export($dir,'PNG',1280,720)}
 $info=@();foreach($s in $p.Slides){foreach($sh in $s.Shapes){$txt='';if($sh.HasTextFrame -eq -1){$txt=$sh.TextFrame.TextRange.Text};$info+= [PSCustomObject]@{Slide=$s.SlideIndex;Id=$sh.Id;Name=$sh.Name;Type=$sh.Type;Left=$sh.Left;Top=$sh.Top;Width=$sh.Width;Height=$sh.Height;Text=$txt}}}
 $info | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $dir 'shapes.json') -Encoding UTF8
 $p.Close();Write-Output $key
}
