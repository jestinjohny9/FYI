# Count rows within CSV files, in a specified directory.
Write-Host ""
Get-ChildItem "D:\Location\of\your\Files\" -re -in "*_sample_format.csv" |

Foreach-Object { 
    $fileStats = Get-Content $_.FullName | Measure-Object -line
    $linesInFile = $fileStats.Lines -1
    Write-Host $_.BaseName".csv"
    Write-Host "$linesInFile" 
}
