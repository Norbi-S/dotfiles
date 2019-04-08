#!/usr/bin/env python3

import argparse
from paths import paths
from pathlib import Path
from shutil import copy


def download(paths):
    dest = Path('./config')
    for key, path in paths.items():
        src = Path(path)
        if src.exists():
            copy(src, dest)

def upload(paths):
    config_dir = './config/'
    for key, path in paths.items():
        src = Path(config_dir + key)
        dest = Path(path)
        if not dest.parent.exists():
            dest.parent.mkdir(parents=True)
        if src.exists():
            copy(src, dest)
            

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--upload', action='store_true')
    args = parser.parse_args()

    if args.upload:
        upload(paths)
    else:
        download(paths)

