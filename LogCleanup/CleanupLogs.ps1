# Set execution policy if not set
$ExecutionPolicy = Get-ExecutionPolicy
if ($ExecutionPolicy -ne "RemoteSigned") {
    Set-ExecutionPolicy RemoteSigned -Force
}

# Cleanup logs older than the set of days in numbers
$days = 14

# Path of the logs that you like to cleanup
$IISLogPath = "D:\LogManagement\u_ex210322\"

# Clean the logs
Function CleanLogfiles($TargetFolder) {
    Write-Host -Debug -ForegroundColor Yellow -BackgroundColor Cyan $TargetFolder

    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
        $Files = Get-ChildItem $TargetFolder -Recurse | Where-Object { $_.Name -like "*.log"} | Where-Object { $_.lastWriteTime -le "$lastwrite" } | Select-Object FullName  
        foreach ($File in $Files) {
            $FullFileName = $File.FullName  
            Write-Host "Deleting file $FullFileName" -ForegroundColor "yellow"; 
            Remove-Item $FullFileName -ErrorAction SilentlyContinue | out-null
        }
    }
    Else {
        Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}
CleanLogfiles($IISLogPath)
