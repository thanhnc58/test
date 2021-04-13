import time;
from datetime import date
from email.utils import formatdate
import subprocess

f = open('readme.md', 'a')


for i in range(0, 1500):
    print(f'start {i}')
    f.write(f'test {i} \n')
    curTime = formatdate(1618317455 + i * 300)
    f2 = open('test.sh', 'w')
    f2.write(f'#!/bin/sh\n')
    f2.write(f'echo \"start git\"\n')
    f2.write(f'export GIT_AUTHOR_DATE=\"{curTime}\"\n')
    f2.write(f'export GIT_COMMITTER_DATE=\"{curTime}\"\n')
    f2.write(f'git add .\n')
    f2.write(f'git commit -m \"update readme {i}\"\n')
    f2.write(f'exit 0')
    f2.close()

    process = subprocess.Popen(['sh', './test.sh'])
    process.wait()
