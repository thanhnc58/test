#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Tue, 20 Apr 2021 10:50:55 -0000"
export GIT_COMMITTER_DATE="Tue, 20 Apr 2021 10:50:55 -0000"
git add .
git commit -m "update readme 400"
exit 0