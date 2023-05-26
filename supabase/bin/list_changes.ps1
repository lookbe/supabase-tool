$gitRoot = git rev-parse --show-toplevel

$FolderName = "..\temp"
if (Test-Path $FolderName) 
{
    # Write-Host "Folder Exists"
    # Perform Delete file from folder operation
}
else
{
    #PowerShell Create directory if not exists
    New-Item $FolderName -ItemType Directory
    # Write-Host "Folder Created successfully"
}

cd ..\database
git ls-files --others --full-name | Out-File ..\temp\changes.txt
cd ..\bin

$fileList = Get-Content -Path "..\temp\changes.txt"
foreach ($filename in $fileList)
{
	$filepath = Join-Path -Path $gitRoot -ChildPath $filename
	.\create_migrations.ps1 $filepath
}