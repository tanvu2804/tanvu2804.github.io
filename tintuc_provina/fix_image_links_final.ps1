# Script để xóa tất cả phần prefix khỏi link ảnh media.loveitopcdn.com
# Tác giả: AI Assistant
# Ngày tạo: $(Get-Date)

Write-Host "Bắt đầu xử lý thay thế các link ảnh media.loveitopcdn.com..." -ForegroundColor Green

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
    
    # Pattern 1: ../../../../20250123234905im_/https_/media.loveitopcdn.com/ -> https://media.loveitopcdn.com/
    $pattern1 = '\.\./\.\./\.\./\.\./\d+im_/https_/media\.loveitopcdn\.com/'
    $matches1 = [regex]::Matches($content, $pattern1)
    
    # Pattern 2: ../../../../20250123234847im_/https_/media.loveitopcdn.com/ -> https://media.loveitopcdn.com/
    $pattern2 = '\.\./\.\./\.\./\.\./\d+im_/https_/media\.loveitopcdn\.com/'
    $matches2 = [regex]::Matches($content, $pattern2)
    
    # Pattern 3: https://web.archive.org/web/20250515133910/https://media.loveitopcdn.com/ -> https://media.loveitopcdn.com/
    $pattern3 = 'https://web\.archive\.org/web/\d+/https://media\.loveitopcdn\.com/'
    $matches3 = [regex]::Matches($content, $pattern3)
    
    # Pattern 4: ../../../../20250124000459im_/https_/media.loveitopcdn.com/ -> https://media.loveitopcdn.com/
    $pattern4 = '\.\./\.\./\.\./\.\./\d+im_/https_/media\.loveitopcdn\.com/'
    $matches4 = [regex]::Matches($content, $pattern4)
    
    # Pattern 5: ../../../../20250123234909im_/https_/media.loveitopcdn.com/ -> https://media.loveitopcdn.com/
    $pattern5 = '\.\./\.\./\.\./\.\./\d+im_/https_/media\.loveitopcdn\.com/'
    $matches5 = [regex]::Matches($content, $pattern5)
    
    $totalMatches = $matches1.Count + $matches2.Count + $matches3.Count + $matches4.Count + $matches5.Count
    
    if ($totalMatches -gt 0) {
        Write-Host "  Tìm thấy $totalMatches link ảnh cần thay thế" -ForegroundColor Yellow
        
        # Thay thế tất cả các pattern
        $newContent = $content -replace $pattern1, 'https://media.loveitopcdn.com/'
        $newContent = $newContent -replace $pattern2, 'https://media.loveitopcdn.com/'
        $newContent = $newContent -replace $pattern3, 'https://media.loveitopcdn.com/'
        $newContent = $newContent -replace $pattern4, 'https://media.loveitopcdn.com/'
        $newContent = $newContent -replace $pattern5, 'https://media.loveitopcdn.com/'
        
        # Ghi lại file
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        
        $totalReplacements += $totalMatches
        Write-Host "  Đã thay thế $totalMatches link ảnh" -ForegroundColor Green
    } else {
        Write-Host "  Không có link ảnh cần thay thế" -ForegroundColor Gray
    }
}

Write-Host "`nHoàn thành!" -ForegroundColor Green
Write-Host "Tổng cộng đã thay thế $totalReplacements link ảnh" -ForegroundColor Green
Write-Host "Tất cả các link ảnh đã được chuyển thành 'https://media.loveitopcdn.com/...'" -ForegroundColor Green