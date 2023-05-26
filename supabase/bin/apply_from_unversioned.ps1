$currentDir = Get-Location
$gitRoot = git rev-parse --show-toplevel
$databasePath = Join-Path -Path $gitRoot -ChildPath "supabase\database"
$binPath = Join-Path -Path $gitRoot -ChildPath "supabase\bin"
$tempPath = Join-Path -Path $gitRoot -ChildPath "supabase\temp"

$changesList = Join-Path -Path $gitRoot -ChildPath "supabase\temp\unversioned.txt"

if (Test-Path $tempPath) 
{
    # Write-Host "Folder Exists"
    # Perform Delete file from folder operation
}
else
{
    #PowerShell Create directory if not exists
    New-Item $tempPath -ItemType Directory
    # Write-Host "Folder Created successfully"
}

cd $databasePath
git ls-files --others --full-name | Out-File $changesList
cd $currentDir

cd $binPath
.\create_migrations_from_list.ps1 $changesList
cd $currentDir
