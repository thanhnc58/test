#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Mon, 01 Feb 2021 19:45:56 -0000"
export GIT_COMMITTER_DATE="Mon, 01 Feb 2021 19:45:56 -0000"
git add .
git commit -m "update readme 333"
exit 0