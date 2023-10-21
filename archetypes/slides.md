---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
description: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: '{{ dateFormat "2006-01-02" .Date }}'
showtoc: false
showDate: false
showWordCount: false
showReadingTime: false
cover:
  image: 'img/slides/cover.webp'
  alt: 'Cover'
  hidden: false
tags: []
draft: true
---

## Presentation

{{< slides src="" >}}
