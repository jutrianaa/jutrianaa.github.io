#!/bin/bash
set -e

THEME_REPO_URL="https://github.com/zerostaticthemes/jekyll-serif-theme.git"
THEME_ZIP_URL="https://github.com/zerostaticthemes/jekyll-serif-theme/archive/refs/heads/master.zip"
TEMP_DIR="tmp_theme_import"

echo "Downloading theme zip..."
curl -L -o theme.zip "$THEME_ZIP_URL"

echo "Unzipping theme..."
rm -rf "$TEMP_DIR"
unzip -q theme.zip -d "$TEMP_DIR"

echo "Copying theme files into current directory (excluding .git)..."
cd "$TEMP_DIR/jekyll-serif-theme-master"

# Remove .git if present
rm -rf .git

# Copy everything (including hidden files except .git) into original repo root
shopt -s dotglob
cp -r * .[^.]* ../../
shopt -u dotglob

cd ../..
rm -rf "$TEMP_DIR"
rm -f theme.zip

echo "All files and folders copied."
echo "Run 'git status' to review changes, then 'git add .', 'git commit -m \"Import jekyll-serif-theme\"', and 'git push' to finalize."