#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script để thay đổi các link YouTube embed từ web.archive.org thành link trực tiếp
"""

import os
import re
import glob
from pathlib import Path

def fix_youtube_links_in_file(file_path):
    """Thay đổi link YouTube embed trong một file HTML"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Pattern để tìm link YouTube embed có dạng web.archive.org/web/...if_/https://www.youtube.com/embed/...
        pattern = r'https://web\.archive\.org/web/\d+if_/https://www\.youtube\.com/embed/[^"\s]+'
        
        def replace_youtube_link(match):
            full_url = match.group(0)
            # Trích xuất phần YouTube embed URL
            youtube_url = full_url.split('if_/')[1]
            return youtube_url
        
        # Thay thế các link YouTube embed
        content = re.sub(pattern, replace_youtube_link, content)
        
        # Nếu có thay đổi, ghi lại file
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Đã sửa: {file_path}")
            return True
        else:
            print(f"Không có thay đổi: {file_path}")
            return False
            
    except Exception as e:
        print(f"Lỗi khi xử lý file {file_path}: {e}")
        return False

def main():
    """Hàm chính"""
    # Tìm tất cả file HTML trong thư mục web.archive.org, trừ index.html
    html_files = []
    
    # Tìm tất cả file .html trong thư mục web.archive.org
    for root, dirs, files in os.walk('web.archive.org'):
        for file in files:
            if file.endswith('.html') and file != 'index.html':
                file_path = os.path.join(root, file)
                html_files.append(file_path)
    
    print(f"Tìm thấy {len(html_files)} file HTML để xử lý")
    
    # Xử lý từng file
    fixed_count = 0
    for file_path in html_files:
        if fix_youtube_links_in_file(file_path):
            fixed_count += 1
    
    print(f"\nHoàn thành! Đã sửa {fixed_count} file")

if __name__ == "__main__":
    main() 