---
geometry: margin=1in
fontfamily: times
fontsize: 12pt
---

### Contents



### Pandoc

Run in `doc` directory, PDFs in output directory:

    pandoc 1-preliminaries.md -o ../output/1-preliminaries.pdf
    pandoc 2-getting-started.md -o ../output/2-getting-started.pdf
    pandoc 3-loading-data.md -o ../output/3-loading-data.pdf
    pandoc 4-writing-functions.md -o ../output/4-writing-functions.pdf
    pandoc 5-data-types.md -o ../output/5-data-types.pdf
    pandoc 6-repeating-things.md -o ../output/6-repeating-things.pdf
    pandoc 7-missing-data.md -o ../output/7-missing-data.pdf

HTML

    pandoc -s -S -c github.css 1-preliminaries.md -o ../output/1-preliminaries.html
    pandoc -s -S -c github.css 2-getting-started.md -o ../output/2-getting-started.html
    pandoc -s -S -c github.css 3-loading-data.md -o ../output/3-loading-data.html
    pandoc -s -S -c github.css 4-writing-functions.md -o ../output/4-writing-functions.html
    pandoc -s -S -c github.css 5-data-types.md -o ../output/5-data-types.html
    pandoc -s -S -c github.css 6-repeating-things.md -o ../output/6-repeating-things.html
    pandoc -s -S -c github.css 7-missing-data.md -o ../output/7-missing-data.html

Other?

    pandoc -s -S -c github.css 201410_fieldnotes.md -o 201410_fieldnotes.html
    pandoc -s -S 201410_fieldnotes.md -o 201410_fieldnotes.html
    pandoc -s -S 201410_fieldnotes.md -o 201410_fieldnotes.docx
