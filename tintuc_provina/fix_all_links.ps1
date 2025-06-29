# Script để xóa phần đầu web.archive.org khỏi mọi link, giữ lại phần link phía sau
# Tác giả: AI Assistant
# Ngày tạo: $(Get-Date)

Write-Host "Bắt đầu xử lý thay thế các link web.archive.org..." -ForegroundColor Green

# Đường dẫn thư mục hiện tại
$currentDir = Get-Location

# Lấy tất cả file văn bản (html, css, js, txt, json, xml, ...)
$textFiles = Get-ChildItem -Path $currentDir -Recurse -Include *.html,*.css,*.js,*.json,*.xml,*.txt,*.md,*.csv,*.ts,*.scss,*.less,*.yml,*.yaml,*.php,*.py,*.rb,*.ini,*.conf,*.htm

Write-Host "Tìm thấy $($textFiles.Count) file văn bản cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $textFiles) {
    Write-Host "Đang xử lý: $($file.FullName)" -ForegroundColor Cyan
    
    # Đọc nội dung file
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Pattern: xóa phần đầu web.archive.org, giữ lại phần sau dấu '/' cuối cùng
    $pattern = 'https://web\.archive\.org/web/\d+(im_)?/(https?://[^"'"'\s]+)'
    $matches = [regex]::Matches($content, $pattern)
    
    if ($matches.Count -gt 0) {
        Write-Host "  Tìm thấy $($matches.Count) link cần thay thế" -ForegroundColor Yellow
        # Thay thế bằng phần link phía sau
        $newContent = [regex]::Replace($content, $pattern, '$2')
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        $totalReplacements += $matches.Count
        Write-Host "  Đã thay thế $($matches.Count) link" -ForegroundColor Green
    } else {
        Write-Host "  Không có link cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "\nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements link" -ForegroundColor Green
Write-Host "Tất cả các link đã được chuyển về link gốc phía sau web.archive.org" -ForegroundColor Green
