$ErrorActionPreference='Stop'
$a=New-Object -ComObject PowerPoint.Application
$root=(Get-Location).Path
$report=@()
foreach($f in (Get-ChildItem 'Nieuw_format_2026-2027' -Recurse -Filter '*_v2.pptx')){
 $key=$f.Directory.Name.Replace(' ','')
 $dir=Join-Path $root ('tmp/pd-stijl/v2_'+$key)
 New-Item -ItemType Directory -Force $dir | Out-Null
 $p=$a.Presentations.Open($f.FullName,$true,$false,$false)
 $p.Export($dir,'PNG',1280,720)
 foreach($s in $p.Slides){foreach($sh in $s.Shapes){
  if($sh.HasTextFrame -eq -1 -and $sh.TextFrame.HasText -eq -1){
   $tf=$sh.TextFrame2;$tr=$tf.TextRange
   $report+=[PSCustomObject]@{File=$key;Slide=$s.SlideIndex;Id=$sh.Id;Text=$tr.Text;X=$sh.Left;Y=$sh.Top;W=$sh.Width;H=$sh.Height;BoundH=$tr.BoundHeight;BoundW=$tr.BoundWidth;Font=$tr.Font.Name;Size=$tr.Font.Size}
  }
 }}
 $p.Close();Write-Output $key
}
$report|ConvertTo-Json -Depth 5|Set-Content 'tmp/pd-stijl/v2-geometry.json' -Encoding UTF8
