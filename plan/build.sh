#!/bin/sh
# app.html(본문)을 GitHub Pages용 완전한 문서 index.html로 감싼다.
cd "$(dirname "$0")"
{ printf '<!doctype html>\n<html lang="ko">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  cat app.html
  printf '\n</html>\n'; } > index.html
