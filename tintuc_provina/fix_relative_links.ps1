# Script để xóa phần ../../../../20250427001144/https_/ và ../../../../20250427001144/https// thành https://
# Tác giả: AI Assistant
# Ngày tạo: $(Get-Date)

Write-Host "Bắt đầu xử lý thay thế các link relative path..." -ForegroundColor Green

# Đường dẫn thư mục hiện tại
$currentDir = Get-Location

# Lấy tất cả file văn bản (html, css, js, txt, json, xml, ...)
$textFiles = Get-ChildItem -Path $currentDir -Recurse -Include *.html,*.css,*.js,*.json,*.xml,*.txt,*.md,*.csv,*.ts,*.scss,*.less,*.yml,*.yaml,*.php,*.py,*.rb,*.ini,*.conf,*.htm

Write-Host "Tìm thấy $($textFiles.Count) file văn bản cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $textFiles) {
    Write-Host "Đang xử lý: $($file.Name)" -ForegroundColor Cyan
    
    # Đọc nội dung file
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Pattern 1: ../../../../20250427001144/https_/ -> https://
    $pattern1 = '\.\./\.\./\.\./\.\./\d+/https_/'
    $matches1 = [regex]::Matches($content, $pattern1)
    
    # Pattern 2: ../../../../20250427001144/https// -> https://
    $pattern2 = '\.\./\.\./\.\./\.\./\d+/https//'
    $matches2 = [regex]::Matches($content, $pattern2)
    
    $totalMatches = $matches1.Count + $matches2.Count
    
    if ($totalMatches -gt 0) {
        Write-Host "  Tìm thấy $totalMatches link cần thay thế" -ForegroundColor Yellow
        
        # Thay thế pattern 1
        $newContent = $content -replace $pattern1, 'https://'
        
        # Thay thế pattern 2
        $newContent = $newContent -replace $pattern2, 'https://'
        
        # Ghi lại file
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        
        $totalReplacements += $totalMatches
        Write-Host "  Đã thay thế $totalMatches link" -ForegroundColor Green
    } else {
        Write-Host "  Không có link cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "`nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements link" -ForegroundColor Green
Write-Host "Tất cả các link đã được chuyển từ '../../../../20250427001144/https_/' và '../../../../20250427001144/https//' thành 'https://'" -ForegroundColor Green