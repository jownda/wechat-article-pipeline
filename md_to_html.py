#!/usr/bin/env python3
"""
Markdown 转微信公众号 HTML
"""

import sys
import re

def md_to_html(md_file, html_file):
    with open(md_file, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # 简单转换
    html = md_content
    
    # 标题
    html = re.sub(r'^# (.+)$', r'<h1 style="font-size:22px;font-weight:bold;text-align:center;margin:20px 0;">\1</h1>', html, flags=re.MULTILINE)
    html = re.sub(r'^## (.+)$', r'<h2 style="font-size:18px;font-weight:bold;margin:24px 0 12px 0;padding-bottom:8px;border-bottom:2px solid #c9a227;">\1</h2>', html, flags=re.MULTILINE)
    
    # 加粗
    html = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', html)
    
    # 段落
    paragraphs = html.split('\n\n')
    new_paragraphs = []
    for p in paragraphs:
        p = p.strip()
        if p and not p.startswith('<h') and not p.startswith('<img'):
            p = f'<p style="font-size:16px;line-height:1.8;margin:12px 0;text-align:justify;">{p}</p>'
        new_paragraphs.append(p)
    html = '\n\n'.join(new_paragraphs)
    
    # 图片占位符
    html = html.replace('src="cover.jpg"', 'src="COVER_URL"')
    html = html.replace('src="body1.jpg"', 'src="BODY1_URL"')
    html = html.replace('src="body2.jpg"', 'src="BODY2_URL"')
    html = html.replace('src="body3.jpg"', 'src="BODY3_URL"')
    html = html.replace('src="body4.jpg"', 'src="BODY4_URL"')
    
    # 包装
    html = f'''<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文章</title>
</head>
<body style="padding:20px;line-height:2;font-size:16px;color:#333;">
{html}
</body>
</html>'''
    
    with open(html_file, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"已生成: {html_file}")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("用法: python3 md_to_html.py input.md output.html")
        sys.exit(1)
    
    md_to_html(sys.argv[1], sys.argv[2])
