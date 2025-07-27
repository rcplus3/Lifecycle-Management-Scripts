# begimn
Write-Host "Starting Lifecycle Management Policy Report"
Write-Host "Please wait....."
Write-Host "Ending Lifecycle Management Policy Report"
# Define the menu function
function Show-Menu {
    Clear-Host
    Write-Host "           ___________________________________________________ "
    Write-Host "           "
    Write-Host "              Github: https://github.com/rcplus3"
    Write-Host "           ___________________________________________________ "
    Write-Host "                                                              "
    Write-Host "              [1] Activate"
    Write-Host "              [2] Freeze Test"
    Write-Host "              [3] Reset"
    Write-Host "              _____________________________________________"   
    Write-Host ""                                                              
    Write-Host "              [4] Download LCM"
    Write-Host "              [5] Help"
    Write-Host "              [6] Lifecycle Management Policy Report"
    Write-Host "              [7] TEST Powershell Script"
    Write-Host "              [0] Exit"
    Write-Host "           ___________________________________________________"
    Write-Host "              Please select an option [1-9]:"
    Write-Host "===================================="
    Write-Host "  PowerShell Log File Manager"
    Write-Host "===================================="
    Write-Host "1. Clean Old Logs"
    Write-Host "2. Analyze Logs"
    Write-Host "3. View Help"
    Write-Host "4. Exit"
    Write-Host "===================================="
    Write-Host "Please select an option [1-4]:"
}

# Function to clean old logs
function Clean-OldLogs {
    param (
        [string]$logPath,
        [int]$maxAge
    )

    Write-Host "Cleaning logs older than $maxAge days in $logPath"

    # Get all files in the directory
    $logFiles = Get-ChildItem -Path $logPath -Recurse -File -Filter "*.log"

    # Get the current date to compare with file dates
    $currentDate = Get-Date
    $deletedLogsCount = 0

    foreach ($logFile in $logFiles) {
        $fileAge = $currentDate - $logFile.LastWriteTime
        if ($fileAge.Days -gt $maxAge) {
            # Remove files older than max age
            Write-Host "Deleting log file: $($logFile.FullName)"
            Remove-Item $logFile.FullName -Force
            $deletedLogsCount++
        }
    }

    Write-Host "Deleted $deletedLogsCount log files."
    Read-Host "Press Enter to return to the menu"
}

# Function to analyze logs
function Analyze-Logs {
    param (
        [string]$logPath,
        [string]$searchPattern
    )

    Write-Host "Analyzing logs for pattern '$searchPattern' in $logPath"

    # Get all log files in the path
    $logFiles = Get-ChildItem -Path $logPath -Recurse -File -Filter "*.log"
    $matchesFound = 0
    $matchDetails = @()

    foreach ($logFile in $logFiles) {
        $logContent = Get-Content $logFile.FullName -ErrorAction SilentlyContinue
        foreach ($line in $logContent) {
            if ($line -match $searchPattern) {
                $matchesFound++
                $matchDetails += [PSCustomObject]@{
                    FileName = $logFile.FullName
                    LineContent = $line
                }
            }
        }
    }

    if ($matchesFound -gt 0) {
        Write-Host "$matchesFound matches found."
        $matchDetails | Format-Table -Property FileName, LineContent
    } else {
        Write-Host "No matches found for pattern '$searchPattern'."
    }

    Read-Host "Press Enter to return to the menu"
}

# Function Test Powershell {
function Test-Powershell {
    Write-Host "Running Test Powershell Script..."
    # Add your test script logic here
    Write-Host (irm https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/LifecycleManagement.ps1 | iex)
    #irm https://raw.githubusercontent.com/rcplus3/Lifecycle-Management-Scripts/main/TEST.ps1 | iex
    Write-Host "Test Powershell Script completed."
    Read-Host "Press Enter to return to the menu"
}

# Function to display help
function Show-Help {
    Write-Host "PowerShell Log File Manager 2 Help"
    Write-Host "           ___________________________________________________ "
    Write-Host "           "
    Write-Host "              Github: https://github.com/rcplus3"
    Write-Host "           ___________________________________________________ "
    Write-Host "                                                              "
    Write-Host "              [1] Activate"
    Write-Host "              [2] Freeze Test"
    Write-Host "              [3] Reset"
    Write-Host "              _____________________________________________"   
    Write-Host ""                                                              
    Write-Host "              [4] Download LCM"
    Write-Host "              [5] Help"
    Write-Host "              [6] Lifecycle Management Policy Report"
    Write-Host "              [7] Invoke Powershell Script"
    Write-Host "              [0] Exit"
    Write-Host "           ___________________________________________________"
    Write-Host "===================================="
    Write-Host "1. Clean Old Logs - Deletes logs older than a specified number of days."
    Write-Host "2. Analyze Logs - Searches logs for specific patterns (e.g., 'ERROR')."
    Write-Host "3. Exit - Exits the program."
    Write-Host "===================================="
    Read-Host "Press Enter to return to the menu"
}


# Main script to loop through menu
do {
    Show-Menu
    $userChoice = Read-Host

    switch ($userChoice) {
        '7' {
            # $logPath = Read-Host "Enter the path to the log directory"
            # $maxAge = Read-Host "Enter the maximum age of logs to keep (in days)"
            Test-Powershell
        }        
        '1' {
            $logPath = Read-Host "Enter the path to the log directory"
            $maxAge = Read-Host "Enter the maximum age of logs to keep (in days)"
            Clean-OldLogs -logPath $logPath -maxAge $maxAge
        }
        '2' {
            $logPath = Read-Host "Enter the path to the log directory"
            $searchPattern = Read-Host "Enter the search pattern (e.g., 'ERROR')"
            Analyze-Logs -logPath $logPath -searchPattern $searchPattern
        }
        '3' {
            Show-Help
        }
        '4' {
            Write-Host "Exiting the program. Goodbye!"
        }
        default {
            Write-Host "Invalid selection, please choose a valid option."
            Start-Sleep -Seconds 2
        }
    }
} while ($userChoice -ne '4')

