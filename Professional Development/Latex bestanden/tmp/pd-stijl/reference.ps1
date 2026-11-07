$ErrorActionPreference='Stop'
$a=New-Object -ComObject PowerPoint.Application
$root=(Get-Location).Path
$dir=Join-Path $root 'tmp/pd-stijl/ref-full';New-Item -ItemType Directory -Force $dir | Out-Null
$p=$a.Presentations.Open((Join-Path $root 'Nieuw_format_2026-2027/Bijeenkomst 2/Startbijeenkomst_PD_20262027.pptx'),$true,$false,$false)
$p.Export($dir,'PNG',1280,720)
$info=@();foreach($s in $p.Slides){foreach($sh in $s.Shapes){if($sh.HasTextFrame -eq -1 -and $sh.TextFrame.HasText -eq -1){$tr=$sh.TextFrame.TextRange;$info+=[PSCustomObject]@{Slide=$s.SlideIndex;Id=$sh.Id;Left=$sh.Left;Top=$sh.Top;Width=$sh.Width;Height=$sh.Height;Text=$tr.Text;Font=$tr.Font.Name;Size=$tr.Font.Size;Color=$tr.Font.Color.RGB;Bold=$tr.Font.Bold}}}}
$info | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $dir 'styles.json') -Encoding UTF8
$p.Close();Write-Output 'Reference exported'
