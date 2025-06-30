#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script để thay đổi src của thẻ <img> từ base64 placeholder thành URL thực từ thuộc tính data-isrc
"""

import os
import re
import glob
from pathlib import Path

def fix_image_src_in_file(file_path):
    """Thay đổi src của thẻ img trong một file HTML"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Pattern để tìm thẻ img có src là base64 và có data-isrc
        pattern = r'<img([^>]*?)src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="([^>]*?)data-isrc="([^"]*)"([^>]*?)>'
        
        def replace_img_src(match):
            before_src = match.group(1)
            after_src = match.group(2)
            data_isrc = match.group(3)
            after_data_isrc = match.group(4)
            
            # Thay thế src bằng URL thực từ data-isrc
            return f'<img{before_src}src="{data_isrc}"{after_src}{after_data_isrc}>'
        
        # Thay thế các thẻ img có base64 src
        content = re.sub(pattern, replace_img_src, content)
        
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
        if fix_image_src_in_file(file_path):
            fixed_count += 1
    
    print(f"\nHoàn thành! Đã sửa {fixed_count} file")

if __name__ == "__main__":
    main() 