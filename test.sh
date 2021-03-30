#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Tue, 30 Mar 2021 12:34:59 -0000"
export GIT_COMMITTER_DATE="Tue, 30 Mar 2021 12:34:59 -0000"
git add .
git commit -m "update readme 0"
exit 0