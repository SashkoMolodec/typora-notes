npm update -g typora-parser
find . -type f -name "*.md" -exec sh -c 'path_md="{}"; path_html="${path_md%.md}.html"; typora-export -g ./src/style.txt -o "$path_html" "$path_md" ' \;