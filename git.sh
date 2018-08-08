# -----------------------------
# GIT ALIAS HELPERS
# https://github.com/polakowski
# -----------------------------

# utils
alias diff='git diff --color-words'
alias all="git add . --all && git status"
alias none="git reset && git status"

# rebase & merge
alias contrebase='git rebase --continue'
alias abortrebase='git rebase --abort'
alias skiprebase='git rebase --skip'
alias contmerge='git merge --continue'
alias abortmerge='git merge --abort'
alias skipmerge='git merge --skip'

# management
alias ggpushforce='git push origin $(current_branch) --force-with-lease'
alias ggpullrebase='git pull --rebase origin $(current_branch)'
alias amendcommit='git commit --amend --no-edit'
alias fetch='echo "Fetching branches..."; git fetch --quiet && echo "Done!"'

commit() {
  git commit -m $@ && echo '[Commit] Committed plain message.'
}

tcommit() {
  task_id=$(git symbolic-ref --short HEAD | cut -d '_' -f 1)
  git commit -m "$task_id $@" && echo '[Commit] Committed with task number.'
}

ggpullremote() {
  if [ "$#" == "1" ]
  then
    echo "Pulling remote branch \"$@\"..."
    git fetch --quiet
    git branch --track "$@" "origin/$@"
    git checkout "$@"
    git pull --rebase --autostash origin "$@"
    echo 'Done!'
  else
    echo 'Please pass branch name.'
  fi
}
