import os
from bs4 import BeautifulSoup

def fix_alt_in_html(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        soup = BeautifulSoup(f, 'html.parser')

    images = soup.find_all('img')
    for img in images:
        src = img.get('src', '')
        alt = img.get('alt', '').strip()

        if not alt or len(alt) < 10:
            filename = os.path.basename(src).lower()
            if 'before' in filename or 'after' in filename:
                alt = "Before and after jewelry retouching - professional enhancement"
            elif 'diamond' in filename or 'solitaire' in filename:
                alt = "Diamond ring after professional retouching - enhanced fire and clarity"
            elif 'gold' in filename or 'metal' in filename:
                alt = "Luxury gold jewelry - metal polishing and reflection control"
            elif 'watch' in filename:
                alt = "Luxury watch photography - glass depth and metal enhancement"
            elif 'sample' in filename:
                alt = "Professional jewelry retouching sample by Aymen Badr"
            elif 'logo' in filename or 'Logo' in src:
                alt = "Partner brand logo - trusted by Aymen Badr clients"
            elif 'profile' in filename or 'aymen' in filename:
                alt = "Aymen Badr - Professional Jewelry Retoucher since 2012"
            else:
                alt = "High-end jewelry photo retouching by Aymen Badr"
            img['alt'] = alt

        if 'hero' not in src.lower() and 'logo' not in src.lower():
            img['loading'] = 'lazy'

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(str(soup))
    print(f"✅ Fixed: {file_path}")

for root, dirs, files in os.walk('.'):
    for file in files:
        if file.endswith('.html'):
            fix_alt_in_html(os.path.join(root, file))

print("\n✅ Done. All HTML files updated.")