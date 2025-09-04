STRUCTURE_CHANGED_TREE_REF="${STRUCTURE_CHANGED_TREE_REF:=cf9c6990b62a4bb6aad80efd6fd75fe45c00e0bc}"
UPSTREAM_REMOTE_NAME="${UPSTREAM_REMOTE_NAME:=origin}"
UPSTREAM_BRANCH="${UPSTREAM_BRANCH:=main}"
git fetch $UPSTREAM_REMOTE_NAME
TEMP_BRANCH_FOR_COMPARISON=$(echo "$UPSTREAM_BRANCH"-temp1)

# Get the exploit_iq_common package addition' commit.  
git checkout $STRUCTURE_CHANGED_TREE_REF
EXPLOIT_IQ_COMMONS_COMMIT=$(git log --follow --diff-filter=A --oneline   src/exploit_iq_commons/ | awk '{print $1}')

# checkout to create the comparison branch
git checkout $UPSTREAM_REMOTE_NAME/$UPSTREAM_BRANCH -b $TEMP_BRANCH_FOR_COMPARISON

# write to files all renames performed on that commits.
git show $EXPLOIT_IQ_COMMONS_COMMIT --name-status | grep -E '^R' > lines.txt

# Read the file line by line to revert renames
while IFS= read -r line; do
    MOVE_COMMAND=$(echo "$line" |  awk '{print "mv " $2 " " $3}')
    FILE_TO_INDEX=$(echo "$line" | awk '{print $3}')
    CONTAINING_DIR_NAME=$(dirname $FILE_TO_INDEX)
#   make the dirs in rename' target path , in case it doesn't exists ( otherwise renaming will fail)
    eval "mkdir -p $CONTAINING_DIR_NAME"
#   make the renaming again, the opposite way
    eval $MOVE_COMMAND
#   add file to index
    git add $FILE_TO_INDEX
done < lines.txt

# Add deleted files to index, so it will recognize it as a rename
git add -u . 
# create a commit of the renaming
git commit -sm "completed transforming repository dir structure in upstream to something comparable to downstream"

git checkout $STRUCTURE_CHANGED_TREE_REF
git merge $TEMP_BRANCH_FOR_COMPARISON
