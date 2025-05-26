param (
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputFile
)

# Get the absolute paths
$InputFilePath = Resolve-Path $InputFile
$OutputFilePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputFile)

# Create Word application
$Word = New-Object -ComObject Word.Application
$Word.Visible = $false

try {
    # Read the markdown content
    $markdownContent = Get-Content -Path $InputFilePath -Raw
    
    # Create a temporary docx file
    $tempDocxPath = [System.IO.Path]::ChangeExtension($OutputFilePath, "docx")
    
    # Create a new document
    $Doc = $Word.Documents.Add()
    
    # Insert the markdown content
    $Doc.Content.Text = $markdownContent
    
    # Save as docx first
    $Doc.SaveAs([ref]$tempDocxPath, [ref]0)
    
    # Save as PDF
    $Doc.SaveAs([ref]$OutputFilePath, [ref]17) # 17 = wdFormatPDF
    
    Write-Host "Successfully converted $InputFilePath to $OutputFilePath"
}
catch {
    Write-Error "An error occurred: $_"
}
finally {
    # Close document and quit Word
    if ($Doc) {
        $Doc.Close()
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Doc) | Out-Null
    }
    $Word.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Word) | Out-Null
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    
    # Remove temporary docx file if it exists
    if (Test-Path $tempDocxPath) {
        Remove-Item $tempDocxPath -Force
    }
}
