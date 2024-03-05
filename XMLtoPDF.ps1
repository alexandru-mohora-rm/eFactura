Write-Output "Converting XML to PDF..."

# Path: xml-to-pdf.ps1
$DOWNLOAD_PATH   = "C:\eFactura\"
$OUTPUT_XML      = "C:\eFactura-output\XML"
$OUTPUT_PDF      = "C:\eFactura-output\PDF"
$OUTPUT_ZIP      = "C:\eFactura-output\ZIP"
$ANAF_ENDPOINT   = "https://webservicesp.anaf.ro/prod/FCTEL/rest/transformare/FACT1"

# cream directoarele necesare
If(!(Test-Path -PathType container $DOWNLOAD_PATH))
{
      New-Item -ItemType Directory -Path $DOWNLOAD_PATH -Force
}
If(!(Test-Path -PathType container $OUTPUT_XML))
{
      New-Item -ItemType Directory -Path $OUTPUT_XML -Force
}
If(!(Test-Path -PathType container $OUTPUT_PDF))
{
      New-Item -ItemType Directory -Path $OUTPUT_PDF -Force
}
If(!(Test-Path -PathType container $OUTPUT_ZIP))
{
      New-Item -ItemType Directory -Path $OUTPUT_ZIP -Force
}


$time = (Get-Date)
Write-Output "Starting at $time"

# dezarhivam toate fisierele zip din ziua curenta
Get-ChildItem $DOWNLOAD_PATH *.zip | Where-Object {$_.LastWriteTime.Date -eq (Get-Date).Date} | ForEach-Object {
    $zipFile = $_.FullName
    $destinationPath = Join-Path $DOWNLOAD_PATH $_.BaseName
    Expand-Archive -Path $zipFile -DestinationPath $destinationPath
    Get-ChildItem -Path $destinationPath -Filter "semnatura_*.xml" -Recurse | Remove-Item -Force
    $xml = Get-ChildItem -Path $destinationPath -Filter "*.xml" -Recurse
    $xml | ForEach-Object {
        curl.exe --location $ANAF_ENDPOINT --header 'Content-Type: text/plain' --data @$destinationPath\$xml -o $OUTPUT_PDF\$xml.pdf
    }
    Write-Output "Backing up .xml files..."
    Move-Item -Path $destinationPath -Filter "*.xml" -Destination $OUTPUT_XML
    Write-Output "Backing up $zipFile..."
    Move-Item -Path $zipFile -Destination $OUTPUT_ZIP
}

$time = (Get-Date)
Write-Output "Am terminat treaba la $time"
Write-Host -NoNewLine 'Press any key to continue...'
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

