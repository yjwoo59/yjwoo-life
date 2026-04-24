param(
    [string]$InboxPath = "C:\Claude\YJWOO Life\📥 Inbox\conversations"
)

Write-Host ""
Write-Host "=== Inbox ZIP Extractor ===" -ForegroundColor Cyan
Write-Host "Path: $InboxPath" -ForegroundColor Gray
Write-Host ""

$zips = Get-ChildItem -Path $InboxPath -Filter "*.zip" -File

if ($zips.Count -eq 0) {
    Write-Host "No ZIP files found in inbox." -ForegroundColor Yellow
    exit 0
}

foreach ($zip in $zips) {
    $extractFolder = Join-Path $InboxPath ($zip.BaseName)
    Write-Host "Extracting: $($zip.Name)" -ForegroundColor Yellow

    try {
        Expand-Archive -Path $zip.FullName -DestinationPath $extractFolder -Force
        Write-Host "  -> Extracted to: $extractFolder" -ForegroundColor Green

        $mdFiles = Get-ChildItem -Path $extractFolder -Filter "*.md" -Recurse
        Write-Host "  -> MD files found: $($mdFiles.Count)" -ForegroundColor Cyan
        foreach ($md in $mdFiles) {
            Write-Host "     - $($md.Name)" -ForegroundColor Gray
        }

        Move-Item -Path $zip.FullName -Destination (Join-Path $InboxPath "processed\$($zip.Name)") -Force
        Write-Host "  -> Original ZIP moved to processed/" -ForegroundColor Gray
        Write-Host ""
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
    }
}

Write-Host "Done. Tell Claude Desktop: 'inbox 처리해줘'" -ForegroundColor Green
Write-Host ""
pause
