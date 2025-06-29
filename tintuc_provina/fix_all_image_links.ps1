# Script để thay thế tất cả các link ảnh media.loveitopcdn.com
# Tác giả: AI Assistant

Write-Host "Bắt đầu xử lý thay thế các link ảnh..." -ForegroundColor Green

$currentDir = Get-Location
$htmlFiles = Get-ChildItem -Path $currentDir -Filter "*.html" -Recurse

Write-Host "Tìm thấy $($htmlFiles.Count) file HTML cần xử lý" -ForegroundColor Yellow

$totalReplacements = 0

foreach ($file in $htmlFiles) {
    Write-Host "Đang xử lý: $($file.Name)" -ForegroundColor Cyan
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Thay thế tất cả các pattern có chứa media.loveitopcdn.com
    $originalContent = $content
    
    # Pattern 1: ../../../../20250123234905im_/https_/media.loveitopcdn.com/
    $content = $content -replace '\.\./\.\./\.\./\.\./\d+im_/https_/media\.loveitopcdn\.com/', 'https://media.loveitopcdn.com/'
    
    # Pattern 2: https://web.archive.org/web/20250515133910/https://media.loveitopcdn.com/
    $content = $content -replace 'https://web\.archive\.org/web/\d+/https://media\.loveitopcdn\.com/', 'https://media.loveitopcdn.com/'
    
    # Đếm số thay đổi
    $changes = ($originalContent.Length - $content.Length) / 50  # Ước tính
    if ($changes -gt 0) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $totalReplacements += $changes
        Write-Host "  Đã thay thế khoảng $changes link" -ForegroundColor Green
    }
}

Write-Host "`nHoàn thành! Tổng cộng đã thay thế khoảng $totalReplacements link ảnh" -ForegroundColor Green