#!/usr/bin/env bash

curl -O https://gitlab.com/CoreDockWorker/coredockworker.tools.public/raw/master/tools.gitpush.sh
chmod +x tools.gitpush.sh

# This directory path
DIR="$(cd "$(dirname "$0")" && pwd -P)"
# Full path of this script
THIS="${DIR}/$(basename "$0")"

git pull origin master
git add --all
git commit --author="$(whoami) <$(whoami)@$HOSTNAME>" -am "$(whoami)@$HOSTNAME $(TZ="Europe/Paris" date +'%Y-%m-%d %H:%M %Z %A')"
git push origin master
git pull origin master

curl -O https://gitlab.com/CoreDockWorker/coredockworker.tools.public/raw/master/tools.log.git.sh
chmod +x tools.log.git.sh
./tools.log.git.sh

# install and update crontab atv_cron
commandsearch="#${THIS}"
command="cd $DIR ; ./$(basename $THIS) #${THIS}"
job="0 */8 * * * $command"
cat <(fgrep -i -v "$commandsearch" <(crontab -l)) <(echo "$job") | crontab -
