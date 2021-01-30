#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Sat, 30 Jan 2021 12:45:56 -0000"
export GIT_COMMITTER_DATE="Sat, 30 Jan 2021 12:45:56 -0000"
git add .
git commit -m "update readme 3"
exit 0