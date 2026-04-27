with open('.kilo/worktrees/rigorous-scabiosa/blog-post-2.html') as f:
    c = f.read()
print('Back to Top Button Check:')
print('HTML:', '<button id="backToTop">' in c or 'id="backToTop"' in c)
print('Arrow:', chr(8593) in c)
print('CSS:', '#backToTop {' in c)
print('Fixed pos:', 'position: fixed' in c)
print('JS getElementById:', 'getElementById' in c and 'backToTop' in c)
print('Scroll:', 'scrollTo' in c)
print('')
all_ok = ('id="backToTop"' in c and '#backToTop {' in c and 'getElementById' in c and 'scrollTo' in c)
print('All OK:', all_ok)
if not all_ok:
    print('Missing parts!')   
else:
    print('Button fully functional')
