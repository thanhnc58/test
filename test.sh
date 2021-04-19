#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Mon, 19 Apr 2021 15:24:15 -0000"
export GIT_COMMITTER_DATE="Mon, 19 Apr 2021 15:24:15 -0000"
git add .
git commit -m "update readme 50"
exit 0