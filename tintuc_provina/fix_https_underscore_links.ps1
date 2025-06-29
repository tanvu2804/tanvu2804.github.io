# Script để xóa phần trước https_/ và thay https_/ thành https://
# Tác giả: AI Assistant

Write-Host "Bắt đầu xử lý thay thế các link https_/..." -ForegroundColor Green

$currentDir = Get-Location
$textFiles = Get-ChildItem -Path $currentDir -Recurse -Include *.html,*.css,*.js,*.json,*.xml,*.txt,*.md,*.csv,*.ts,*.scss,*.less,*.yml,*.yaml,*.php,*.py,*.rb,*.ini,*.conf,*.htm

Write-Host "Tìm thấy $($textFiles.Count) file văn bản cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $textFiles) {
    Write-Host "Đang xử lý: $($file.Name)" -ForegroundColor Cyan
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Pattern: xóa phần trước https_/ và thay https_/ thành https://
    $pattern = '.*?https_/'
    $matches = [regex]::Matches($content, $pattern)
    $totalMatches = $matches.Count
    if ($totalMatches -gt 0) {
        Write-Host "  Tìm thấy $totalMatches link cần thay thế" -ForegroundColor Yellow
        # Thay thế: xóa phần trước và đổi https_/ thành https://
        $content = $content -replace '.*?https_/', 'https://'
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $totalReplacements += $totalMatches
        Write-Host "  Đã thay thế $totalMatches link" -ForegroundColor Green
    } else {
        Write-Host "  Không có link cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "\nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements link" -ForegroundColor Green
Write-Host "Tất cả các link đã được chuyển thành https://..." -ForegroundColor Green 