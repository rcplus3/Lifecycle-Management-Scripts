# Check the instructions here on how to use it https://github.com/rcplus3/IDM-Activation-Script/wiki
## USAGE irm https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/LMS.ps1 | iex
$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/TEST.cmd'
$DownloadURL2 = 'https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/SA.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\LM_$rand.cmd" } else { "$env:TEMP\LM_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\LM*.cmd", "$env:SystemRoot\Temp\LM*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
