param (
    [string]$MarkdownFile,
    [string]$OutputPDFFile
)

# Check if the markdown file exists
if (-not (Test-Path $MarkdownFile)) {
    Write-Error "Markdown file not found: $MarkdownFile"
    exit 1
}

# First convert Markdown to HTML using PowerShell's built-in capabilities
$markdownContent = Get-Content -Path $MarkdownFile -Raw
$tempHtmlFile = [System.IO.Path]::ChangeExtension($MarkdownFile, "html")

# Simple markdown to HTML conversion for basic formatting
$htmlContent = $markdownContent -replace '# (.*)', '<h1>$1</h1>'
$htmlContent = $htmlContent -replace '## (.*)', '<h2>$1</h2>'
$htmlContent = $htmlContent -replace '### (.*)', '<h3>$1</h3>'
$htmlContent = $htmlContent -replace '#### (.*)', '<h4>$1</h4>'
$htmlContent = $htmlContent -replace '\*\*(.*?)\*\*', '<strong>$1</strong>'
$htmlContent = $htmlContent -replace '\*(.*?)\*', '<em>$1</em>'
$htmlContent = $htmlContent -replace '`(.*?)`', '<code>$1</code>'
$htmlContent = $htmlContent -replace '```(.*?)```', '<pre><code>$1</code></pre>'
$htmlContent = $htmlContent -replace '\[(.*?)\]\((.*?)\)', '<a href="$2">$1</a>'

# Process lists
$htmlContent = $htmlContent -replace '- (.*)', '<li>$1</li>'

# Wrap the HTML content in proper HTML structure
$fullHtmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AegisWhistle Technical Documentation</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; margin: 40px; }
        h1 { color: #333366; }
        h2 { color: #336699; border-bottom: 1px solid #eee; padding-bottom: 5px; }
        h3 { color: #0099cc; }
        code { background-color: #f5f5f5; padding: 2px 4px; border-radius: 4px; }
        pre { background-color: #f5f5f5; padding: 10px; border-radius: 4px; overflow-x: auto; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
    </style>
</head>
<body>
$htmlContent
</body>
</html>
"@

# Save the HTML content to a temporary file
$fullHtmlContent | Out-File -FilePath $tempHtmlFile -Encoding UTF8

# Now use Word to convert HTML to PDF
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    
    # Open the HTML file
    $doc = $word.Documents.Open($tempHtmlFile)
    
    # Save as PDF
    $doc.SaveAs([ref] $OutputPDFFile, [ref] 17) # 17 = wdFormatPDF
    
    # Close the document and Word
    $doc.Close()
    $word.Quit()
    
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    
    Write-Host "PDF created successfully: $OutputPDFFile"
} catch {
    Write-Error "Error converting to PDF: $_"
} finally {
    # Clean up the temporary HTML file
    if (Test-Path $tempHtmlFile) {
        Remove-Item $tempHtmlFile
    }
}
