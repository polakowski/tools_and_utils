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
alias abortmerge='git merge --abort'

# management
alias ggpushforce='git push origin $(current_branch) --force-with-lease'
alias ggpullrebase='git pull --rebase --autostash origin $(current_branch)'
alias amendcommit='git commit --amend --no-edit'
alias fetch='echo "Fetching branches..."; git fetch --quiet && echo "Done!"'

commit() {
  _raw_commit "$@"
}

tcommit() {
  task_id=$(git symbolic-ref --short HEAD | cut -d '_' -f 1)
  msg="$task_id $@"

  _raw_commit "$msg"
}

fcommit() {
  task_id=$(git symbolic-ref --short HEAD | cut -d '_' -f 1 | grep -Eo '\d+')
  msg="$task_id $@"

  _raw_commit "$msg"
}

commithf() {
  if [ "$#" -eq 0 ]; then
    commit '[hotfix]'
  else
    commit "[hotfix] $@"
  fi
}

ggpullremote() {
  if [ -z $1 ]; then
    echo 'Please pass branch name (example: "ggpullremote feature-branch")'
    return
  fi

  echo "Pulling remote branch \"$@\"..."
  git fetch --quiet
  git branch --track "$@" "origin/$@"
  git checkout "$@"
  git pull --rebase --autostash origin "$@"
  echo 'Done!'
}

ggrebase() {
  if [ -z $1 ]; then
    echo 'Please pass branch name (example: "ggrebase master")'
    return
  fi

  base_branch=$@
  feature_branch=$(git_current_branch)

  # checkout and pull base branch
  echo "Pulling remote branch \"$base_branch\"..."
  git checkout "$base_branch" --quiet
  git pull --quiet --rebase --autostash origin "$base_branch"
  git checkout "$feature_branch" --quiet

  # checkout and rebase feature branch
  echo "Rebasing onto \"$base_branch\"..."
  git rebase "$base_branch" >/dev/null
  n_conflicts=$(git diff --name-only --diff-filter=U | wc -l | tr -d '[:space:]')

  # handle conflicts
  if [ "$n_conflicts" == "0" ]; then
    echo 'Successfully rebased.'
  else
    echo "$n_conflicts conflicted files found."
  fi
}

ggresolve() {
  text_editor=$P_EDITOR_NAME
  n_conflicts=$(git diff --name-only --diff-filter=U | wc -l | tr -d '[:space:]')

  if [ "$n_conflicts" == "0" ]; then
    echo 'No conflicts found.'
    return
  fi

  if [ ! -z $1 ]; then
    text_editor=$1
  fi

  if [ -z $text_editor ]; then
    echo 'Please pass text editor name (example: "ggresolve vim")'
    echo 'TIP: Editor name defaults to `P_EDITOR_NAME` variable.'
    return
  fi

  git diff --name-only --diff-filter=U | while read file
    do eval "$text_editor $file"
  done
}

gcoo() {
  git checkout $(git branch | awk '/^[^\*]/ { print $1 }' | fzf)
}

# UTILS -----------------------------------------------------------------------

COLOR_RED='1'
COLOR_YELLOW='3'
COLOR_BLUE='4'

_raw_commit() {
  _check_len "$@" 50 && git commit --quiet -m "$@" && _commit_echo "$@"
}

_check_len() {
  str=$1
  max_length=$2

  str_length=${#str}

  if [[ "$str_length" -gt "$max_length" ]]; then
    _error_echo "Error: Commit message too long (max: $max_length characters)"
    return 1
  fi
}

_echo_color() {
  tput setaf $COLOR_BLUE
  echo -ne 'commit '
  tput setaf "$1"
  echo "$2"
  tput sgr0
}

_commit_echo() {
  _echo_color $COLOR_YELLOW "$@"
}

_error_echo() {
  _echo_color $COLOR_RED "$@"
}
