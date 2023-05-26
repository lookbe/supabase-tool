$changesList = Get-Item $args[0] 

$currentDir = Get-Location
$gitRoot = git rev-parse --show-toplevel
$binPath = Join-Path -Path $gitRoot -ChildPath "supabase\bin"

$fileList = Get-Content -Path $changesList
cd $binPath
foreach ($filename in $fileList)
{
	$filepath = Join-Path -Path $gitRoot -ChildPath $filename
	.\create_migrations_from_file.ps1 $filepath
}
cd $currentDir
