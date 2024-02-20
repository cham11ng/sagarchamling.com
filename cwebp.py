#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
"""Module: Covert .png to .webp"""

import os
import sys

def convert_webp(path = 'content'):
    """Converts .png to .webp using cwebp, the path of the directory as an argument"""
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith('.png'):
                fullpath = os.path.join(root, file)
                os.system('cwebp -q 80 ' + fullpath + ' -o ' + fullpath[:-4] + '.webp')
                os.system('rm ' + fullpath)

if __name__ == '__main__':
    # Get the directory path from the CLI
    if len(sys.argv) > 1:
        path = sys.argv[1]
        convert_webp(path)
    else:
        convert_webp()

# Sample Input in CLI:
# python3 cwebp.py content/blogs/training/modern-devops/img
