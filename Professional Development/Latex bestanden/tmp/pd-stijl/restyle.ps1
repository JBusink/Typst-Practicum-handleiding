$ErrorActionPreference='Stop'
$a=New-Object -ComObject PowerPoint.Application
$root=(Get-Location).Path
$ref=(Resolve-Path 'Nieuw_format_2026-2027/Bijeenkomst 2/Startbijeenkomst_PD_20262027.pptx').Path
$files=Get-ChildItem 'Nieuw_format_2026-2027' -Recurse -Filter '*.pptx' | Where-Object {$_.Name -notlike 'Startbijeenkomst*' -and $_.Name -notlike '*_2026-2027.pptx'}
foreach($f in $files){
 $key=$f.Directory.Name.Replace(' ','')+'_'+$f.BaseName
 $p=$a.Presentations.Open($f.FullName,$false,$false,$false)
 $cover=$p.Slides.Item(1).Shapes.Item(1).TextFrame.TextRange.Text
 $lines=$cover -split '[\r\n\v]'
 $subject=($lines | Where-Object {$_ -and $_ -notmatch 'Professional Development|Technische Stage|Woensdag'}) -join ' '
 $date=($lines | Where-Object {$_ -match 'Woensdag'}) -join ''
 $oldNotes=$p.Slides.Item(1).NotesPage.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text
 [void]$p.Slides.InsertFromFile($ref,0,1,1)
 $p.Slides.Item(2).Delete()
 $s=$p.Slides.Item(1)
 foreach($sh in $s.Shapes){if($sh.HasTextFrame -eq -1){
  $t=$sh.TextFrame.TextRange.Text
  if($t -match '^Woensdag'){$sh.TextFrame.TextRange.Text=$date}
  if($t -match 'Technische Stage - Startbijeenkomst'){
   $sh.TextFrame.TextRange.Text="Technische Stage`v$subject"
   $sh.Left=60;$sh.Top=145;$sh.Width=430;$sh.Height=58
   $sh.TextFrame.TextRange.Font.Size=18
   $sh.TextFrame.TextRange.ParagraphFormat.Alignment=2
   $sh.TextFrame.AutoSize=0
  }
 }}
 $s.NotesPage.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text=$oldNotes
 foreach($s in $p.Slides){
  if($s.SlideIndex -eq 1){continue}
  $s.DisplayMasterShapes=0;$s.FollowMasterBackground=0
  $s.Background.Fill.Solid();$s.Background.Fill.ForeColor.RGB=16777215
  for($j=$s.Shapes.Count;$j -ge 1;$j--){
   $sh=$s.Shapes.Item($j)
   if($sh.Type -eq 14){
    $pt=$sh.PlaceholderFormat.Type
    if($pt -eq 13 -or ($sh.Left -gt 480 -and $sh.Top -lt 2 -and $sh.Width -gt 220 -and $sh.Height -lt 50)){$sh.Delete();continue}
   }
   if($sh.HasTextFrame -eq -1 -and $sh.TextFrame.HasText -eq -1){
    $tr=$sh.TextFrame.TextRange
    if($sh.Type -eq 14 -and ($sh.PlaceholderFormat.Type -eq 1 -or $sh.PlaceholderFormat.Type -eq 3)){
     $isEnd=$tr.Text.Trim() -eq 'Vragen?'
     if($isEnd){$sh.Left=140;$sh.Top=155;$sh.Width=440;$sh.Height=70;$tr.Font.Size=33;$tr.ParagraphFormat.Alignment=2}
     else{$sh.Left=35.1;$sh.Top=18.9;$sh.Width=650;$sh.Height=65;$tr.Font.Size=21;$tr.ParagraphFormat.Alignment=1}
     $tr.Font.Name='Calibri';$tr.Font.Bold=-1;$tr.Font.Color.RGB=3810846
     $sh.TextFrame.AutoSize=0;$sh.TextFrame.WordWrap=-1
    }
   }
  }
 }
 $out=Join-Path $f.Directory.FullName ($f.BaseName+'_2026-2027.pptx')
 if(Test-Path $out){throw "Output exists: $out"}
 $p.SaveAs($out,24)
 $dir=Join-Path $root ('tmp/pd-stijl/final_'+$key);New-Item -ItemType Directory -Force $dir | Out-Null
 $p.Export($dir,'PNG',1280,720)
 $p.Close();Write-Output $out
}
