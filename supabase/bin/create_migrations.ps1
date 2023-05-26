$inputFile = Get-Item $args[0] 
supabase migration new $inputFile.Basename
$latestFile = Get-ChildItem ..\migrations -File | Sort-Object -Property -CreationTime | Select-Object -First 1
$content = Get-Content -Path $args[0]
Set-Content -Path $latestFile.Fullname -Value $content