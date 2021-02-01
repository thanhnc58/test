#!/bin/sh
echo "start git"
export GIT_AUTHOR_DATE="Mon, 01 Feb 2021 04:45:56 -0000"
export GIT_COMMITTER_DATE="Mon, 01 Feb 2021 04:45:56 -0000"
git add .
git commit -m "update readme 243"
exit 0