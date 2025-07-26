# Check the instructions here on how to use it https://github.com/rcplus3/Lifecycle-Management-Scripts/wiki

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/Sa.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\SA_$rand.cmd" } else { "$env:TEMP\SA_$rand.cmd" }

Write-Host "starting download" -NoNewline
try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}
Write-Host "download successful " -NoNewline
$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\SA*.cmd", "$env:SystemRoot\Temp\SA*.cmd")
Write-Host "FilePath=$FilePaths successful " 
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
Write-Host "Script execution completed successfully." -ForegroundColor Green