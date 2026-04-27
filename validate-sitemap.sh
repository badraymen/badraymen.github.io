#!/bin/bash
# Sitemap Validation Script
# Checks sitemap.xml for common issues

SITEMAP="sitemap.xml"
BASE_URL="https://badraymen.github.io"

echo "=========================================="
echo "  Sitemap Validation Report"
echo "  $(date)"
echo "=========================================="
echo ""

# Check if sitemap exists
if [ ! -f "$SITEMAP" ]; then
    echo "❌ ERROR: sitemap.xml not found!"
    exit 1
fi
echo "✅ sitemap.xml found"

# Check XML declaration
if grep -q '<?xml version="1.0"' "$SITEMAP"; then
    echo "✅ XML declaration present"
else
    echo "❌ WARNING: XML declaration missing"
fi

# Check namespace
if grep -q 'xmlns="http://www.sitemaps.org' "$SITEMAP"; then
    echo "✅ Correct namespace declared"
else
    echo "❌ ERROR: Incorrect or missing namespace"
fi

# Count URLs
URL_COUNT=$(grep -c '<loc>' "$SITEMAP")
echo "✅ Total URLs in sitemap: $URL_COUNT"

# Check for absolute URLs
ABSOLUTE_URLS=$(grep -c "^.*<loc>https://" "$SITEMAP")
if [ "$URL_COUNT" -eq "$ABSOLUTE_URLS" ]; then
    echo "✅ All URLs are absolute"
else
    echo "❌ WARNING: Some URLs are not absolute"
fi

# Check for lastmod tags
LASTMOD_COUNT=$(grep -c '<lastmod>' "$SITEMAP")
echo "✅ URLs with lastmod: $LASTMOD_COUNT/$URL_COUNT"

# Check for priority tags
PRIORITY_COUNT=$(grep -c '<priority>' "$SITEMAP")
echo "✅ URLs with priority: $PRIORITY_COUNT/$URL_COUNT"

# Check robots.txt reference
if [ -f "robots.txt" ]; then
    if grep -q "sitemap.xml" "robots.txt"; then
        echo "✅ Sitemap referenced in robots.txt"
    else
        echo "❌ WARNING: Sitemap not in robots.txt"
    fi
else
    echo "❌ WARNING: robots.txt not found"
fi

# List all URLs
echo ""
echo "=========================================="
echo "  URLs in Sitemap"
echo "=========================================="
grep '<loc>' "$SITEMAP" | sed 's/.*<loc>\(.*\)<\/loc>.*/  - \1/'

# Check for common issues
echo ""
echo "=========================================="
echo "  Validation Checks"
echo "=========================================="

# Check for duplicate URLs
DUPLICATES=$(grep '<loc>' "$SITEMAP" | sort | uniq -d)
if [ -z "$DUPLICATES" ]; then
    echo "✅ No duplicate URLs"
else
    echo "❌ ERROR: Duplicate URLs found:"
    echo "$DUPLICATES"
fi

# Check URL format
INVALID_URLS=$(grep '<loc>' "$SITEMAP" | grep -v 'https://' | grep -v 'http://')
if [ -z "$INVALID_URLS" ]; then
    echo "✅ All URLs use HTTPS/HTTP"
else
    echo "❌ WARNING: Invalid URL format found"
fi

# Check for localhost or test URLs
if grep -q 'localhost\|127.0.0.1\|example.com' "$SITEMAP"; then
    echo "❌ ERROR: Test/localhost URLs found"
else
    echo "✅ No test URLs found"
fi

# Check date format
BAD_DATES=$(grep '<lastmod>' "$SITEMAP" | grep -v '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
if [ -z "$BAD_DATES" ]; then
    echo "✅ All dates in YYYY-MM-DD format"
else
    echo "❌ WARNING: Invalid date format found"
fi

# Check priority range
BAD_PRIORITY=$(grep '<priority>' "$SITEMAP" | grep -v '0\.[0-9]\|1\.0' | grep -v '0\.0\|0\.[1-9]')
if [ -z "$BAD_PRIORITY" ]; then
    echo "✅ All priorities in valid range (0.0-1.0)"
else
    echo "❌ WARNING: Invalid priority values found"
fi

echo ""
echo "=========================================="
echo "  Summary"
echo "=========================================="
echo "Total URLs: $URL_COUNT"
echo "With lastmod: $LASTMOD_COUNT"
echo "With priority: $PRIORITY_COUNT"
echo ""
echo "Next steps:"
echo "1. Submit to Google Search Console"
echo "2. Submit to Bing Webmaster Tools"
echo "3. Monitor indexing status"
echo "=========================================="
