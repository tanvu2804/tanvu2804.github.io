import requests
from bs4 import BeautifulSoup
import os
from urllib.parse import urlparse
import time

def crawl_wayback_to_local(url, save_directory="crawled_pages"):
    """
    Crawl HTML từ Wayback Machine và lưu về local
    
    Args:
        url: URL từ web.archive.org
        save_directory: Thư mục lưu file
    """
    try:
        # Tạo thư mục nếu chưa tồn tại
        if not os.path.exists(save_directory):
            os.makedirs(save_directory)
        
        # Headers để tránh bị chặn
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'vi-VN,vi;q=0.9,en;q=0.8',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
        }
        
        print(f"Đang crawl: {url}")
        
        # Gửi request
        response = requests.get(url, headers=headers, timeout=30)
        
        if response.status_code == 200:
            # Parse HTML
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Tạo tên file từ URL gốc
            original_url = url.split('/')[-1]
            if not original_url.endswith('.html'):
                original_url += '.html'
            
            # Tạo tên file an toàn
            safe_filename = "".join(c for c in original_url if c.isalnum() or c in ('_', '-', '.'))
            if not safe_filename:
                safe_filename = f"page_{int(time.time())}.html"
            
            # Đường dẫn file đầy đủ
            filepath = os.path.join(save_directory, safe_filename)
            
            # Lưu HTML
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(response.text)
            
            print(f"✓ Đã lưu thành công: {filepath}")
            print(f"  - Kích thước: {len(response.text):,} bytes")
            
            return filepath
            
        else:
            print(f"✗ Lỗi HTTP: {response.status_code}")
            return None
            
    except requests.exceptions.Timeout:
        print("✗ Lỗi: Timeout - Quá thời gian chờ")
        return None
    except requests.exceptions.ConnectionError:
        print("✗ Lỗi: Không thể kết nối")
        return None
    except Exception as e:
        print(f"✗ Lỗi: {str(e)}")
        return None

def crawl_multiple_wayback_urls(urls, save_directory="crawled_pages"):
    """
    Crawl nhiều URLs cùng lúc
    
    Args:
        urls: Danh sách URLs
        save_directory: Thư mục lưu
    """
    successful = 0
    failed = 0
    
    print(f"Bắt đầu crawl {len(urls)} URLs...")
    print("-" * 50)
    
    for i, url in enumerate(urls, 1):
        print(f"\n[{i}/{len(urls)}]")
        
        result = crawl_wayback_to_local(url, save_directory)
        
        if result:
            successful += 1
        else:
            failed += 1
        
        # Delay để tránh bị block
        if i < len(urls):
            print("Đợi 2 giây...")
            time.sleep(2)
    
    print("\n" + "=" * 50)
    print(f"Hoàn thành!")
    print(f"- Thành công: {successful}")
    print(f"- Thất bại: {failed}")
    print(f"- Tổng cộng: {len(urls)}")

# Sử dụng cho 1 URL
if __name__ == "__main__":
    # URL cần crawl
    url = "https://web.archive.org/web/20250515123353/https://provina.vn/blog/day-cau-vong.html"
    
    # Crawl và lưu
    crawl_wayback_to_local(url)
