# Script để thay thế src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" bằng giá trị của data-isrc
# Tác giả: AI Assistant

Write-Host "Bắt đầu xử lý thay thế data:image/gif;base64 thành link ảnh thực tế..." -ForegroundColor Green

$currentDir = Get-Location
$htmlFiles = Get-ChildItem -Path $currentDir -Filter "*.html" -Recurse

Write-Host "Tìm thấy $($htmlFiles.Count) file HTML cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $htmlFiles) {
    Write-Host "Đang xử lý: $($file.Name)" -ForegroundColor Cyan
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Pattern để tìm img có src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" và data-isrc
    $pattern = 'src="data:image/gif;base64,R0lGODlhAQABAAAAACwAAAAAAQABAAA=" data-isrc="([^"]+)"'
    $matches = [regex]::Matches($content, $pattern)
    
    if ($matches.Count -gt 0) {
        Write-Host "  Tìm thấy $($matches.Count) ảnh cần thay thế" -ForegroundColor Yellow
        
        # Thay thế từng match
        foreach ($match in $matches) {
            $dataIsrc = $match.Groups[1].Value
            $oldSrc = $match.Value
            $newSrc = "src=`"$dataIsrc`""
            
            $content = $content -replace [regex]::Escape($oldSrc), $newSrc
            $totalReplacements++
        }
        
        # Ghi lại file
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "  Đã thay thế $($matches.Count) ảnh" -ForegroundColor Green
    } else {
        Write-Host "  Không có ảnh cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "`nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements ảnh" -ForegroundColor Green
Write-Host "Tất cả các src='data:image/gif;base64,...' đã được thay thế bằng link ảnh thực tế từ data-isrc" -ForegroundColor Green 