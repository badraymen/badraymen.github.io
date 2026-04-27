import re

with open('faq.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace og:url line with full set
old = '''    <meta property="og:url" content="https://badraymen.github.io/faq.html">
    <meta property="og:type" content="website">'''

new = '''    <meta property="og:url" content="https://badraymen.github.io/faq.html">
    <meta property="og:image" content="https://badraymen.github.io/image/Sample2.webp">
    <meta property="og:type" content="website">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="FAQ — Jewelry Retouching Questions | Aymen Badr">
    <meta name="twitter:description" content="Everything you need to know about jewelry retouching: pricing, process, turnaround, file formats, and how to get started.">
    <meta name="twitter:image" content="https://badraymen.github.io/image/Sample2.webp">'''

if old in content:
    content = content.replace(old, new)
    with open('faq.html', 'w', encoding='utf-8') as f:
        f.write(content)
    print('Successfully updated faq.html')
else:
    print('Pattern not found!')
    # Show what we found
    import sys
    idx = content.find('og:url')
    print('Context:', repr(content[idx-50:idx+200]))