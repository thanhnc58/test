#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Sat, 24 Apr 2021 15:04:15 -0000"
export GIT_COMMITTER_DATE="Sat, 24 Apr 2021 15:04:15 -0000"
git add .
git commit -m "update readme 2204"
exit 0