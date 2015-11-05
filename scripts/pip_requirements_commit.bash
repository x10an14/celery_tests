# Check if requirements.txt was updated
git pull | tee -a freeze_log.txt;
if [ ! -z $(git diff requirements.txt) ]; then
    # If so, add file to current commit
    git add requirements.txt | tee -a freeze_log.txt;
 fi;

