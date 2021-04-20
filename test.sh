#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Tue, 20 Apr 2021 12:04:15 -0000"
export GIT_COMMITTER_DATE="Tue, 20 Apr 2021 12:04:15 -0000"
git add .
git commit -m "update readme 422"
exit 0