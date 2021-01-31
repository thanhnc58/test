#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Sun, 31 Jan 2021 14:55:56 -0000"
export GIT_COMMITTER_DATE="Sun, 31 Jan 2021 14:55:56 -0000"
git add .
git commit -m "update readme 160"
exit 0