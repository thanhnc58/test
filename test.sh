#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Tue, 20 Apr 2021 00:00:55 -0000"
export GIT_COMMITTER_DATE="Tue, 20 Apr 2021 00:00:55 -0000"
git add .
git commit -m "update readme 205"
exit 0