#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Mon, 19 Apr 2021 14:04:15 -0000"
export GIT_COMMITTER_DATE="Mon, 19 Apr 2021 14:04:15 -0000"
git add .
git commit -m "update readme 26"
exit 0