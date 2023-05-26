$inputFile = Get-Item $args[0] 

$gitRoot = git rev-parse --show-toplevel
$migrationsPath = Join-Path -Path $gitRoot -ChildPath "supabase\migrations"

supabase migration new $inputFile.Basename

$latestFile = Get-ChildItem $migrationsPath -File | Sort-Object -Descending -Property LastWriteTime | select -First 1
#Write-Output $latestFile
$content = Get-Content -Path $args[0]
Set-Content -Path $latestFile.Fullname -Value $content