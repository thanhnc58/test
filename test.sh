#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Fri, 23 Apr 2021 12:34:15 -0000"
export GIT_COMMITTER_DATE="Fri, 23 Apr 2021 12:34:15 -0000"
git add .
git commit -m "update readme 1727"
exit 0