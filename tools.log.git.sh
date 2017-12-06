#!/usr/bin/env bash

# curl -O https://gitlab.com/CoreDockWorker/coredockworker.tools.public/raw/master/tools.log.git.sh
# chmod +x tools.log.git.sh

# This directory path
DIR="$(cd "$(dirname "$0")" && pwd -P)"
# Full path of this script
THIS="${DIR}/$(basename "$0")"
AUTHOR="$(whoami) <$(whoami)@$HOSTNAME>"
DATEHOUR="$(TZ="Europe/Paris" date +'%Y-%m-%d %H-%M %Z %A')"
LOGDIR="${HOSTNAME}/$(whoami)"

echo $AUTHOR
echo $DATEHOUR
echo $LOGDIR
echo $THIS

mkdir -p /tmp/ && cd /tmp/
git clone git@gitlab.com:environnements/tools.log.git.sh.git
cd tools.log.git.sh && mkdir -p $LOGDIR
LOGFILE="/tmp/tools.log.git.sh/${LOGDIR}/${DATEHOUR}.log"


    echo "$(crontab -l)" >> "${LOGFILE}"
    echo "" >> "${LOGFILE}"
    echo "===================================" >> "${LOGFILE}"
    echo "" >> "${LOGFILE}"
    
for dir in $(find $DIR -name ".git")
do cd ${dir%/*}
    echo $PWD
    echo $PWD >> "${LOGFILE}"
    echo "$(git status)" >> "${LOGFILE}"
    echo "" >> "${LOGFILE}"
    echo "===================================" >> "${LOGFILE}"
    echo "" >> "${LOGFILE}"
done

cd "/tmp/tools.log.git.sh"
git add --all
git commit  --author="$AUTHOR" -am "$(whoami)@$HOSTNAME $(TZ="Europe/Paris" date +'%Y-%m-%d %H:%M %Z %A')"
git push origin master
echo "test"
rm -rf "/tmp/tools.log.git.sh"
echo "test"

# install and update crontab atv_cron
commandsearch="#${THIS}"
command="cd $DIR ; ./$(basename $THIS) #${THIS}"
job="0 */8 * * * $command"
cat <(fgrep -i -v "$commandsearch" <(crontab -l)) <(echo "$job") | crontab -
