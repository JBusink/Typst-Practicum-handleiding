$ErrorActionPreference='Stop'
$a=New-Object -ComObject PowerPoint.Application
$root=(Get-Location).Path
foreach($f in (Get-ChildItem 'Nieuw_format_2026-2027' -Recurse -Filter '*_2026-2027.pptx')){
 $key=$f.Directory.Name.Replace(' ','')+'_'+$f.BaseName.Replace('_2026-2027','')
 $dir=Join-Path $root ('tmp/pd-stijl/final_'+$key)
 $p=$a.Presentations.Open($f.FullName,$true,$false,$false)
 $p.Export($dir,'PNG',1280,720)
 $p.Close();Write-Output $key
}
