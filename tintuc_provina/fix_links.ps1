# Script để xóa phần web.archive.org khỏi các link provina.vn
# Tác giả: AI Assistant
# Ngày tạo: $(Get-Date)

Write-Host "Bắt đầu xử lý thay thế các link web.archive.org..." -ForegroundColor Green

# Đường dẫn thư mục hiện tại
$currentDir = Get-Location

# Tìm tất cả các file HTML trong thư mục và các thư mục con
$htmlFiles = Get-ChildItem -Path $currentDir -Filter "*.html" -Recurse

Write-Host "Tìm thấy $($htmlFiles.Count) file HTML cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $htmlFiles) {
    Write-Host "Đang xử lý: $($file.FullName)" -ForegroundColor Cyan
    
    # Đọc nội dung file
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Đếm số lượng link cần thay thế trong file này
    $pattern = 'https://web\.archive\.org/web/\d+/https://provina\.vn'
    $matches = [regex]::Matches($content, $pattern)
    
    if ($matches.Count -gt 0) {
        Write-Host "  Tìm thấy $($matches.Count) link cần thay thế" -ForegroundColor Yellow
        
        # Thay thế tất cả các link
        $newContent = $content -replace 'https://web\.archive\.org/web/\d+/https://provina\.vn', 'https://provina.vn'
        
        # Ghi lại file
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        
        $totalReplacements += $matches.Count
        Write-Host "  Đã thay thế $($matches.Count) link" -ForegroundColor Green
    } else {
        Write-Host "  Không có link cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "`nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements link" -ForegroundColor Green
Write-Host "Tất cả các link đã được chuyển từ 'https://web.archive.org/web/YYYYMMDDHHMMSS/https://provina.vn/...' thành 'https://provina.vn/...'" -ForegroundColor Green