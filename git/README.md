## Git
Aliases and functions to speed up your git workflow.

### Installation
```sh
mkdir -p ~/p_utils
curl 'https://raw.githubusercontent.com/polakowski/tools_and_utils/master/git/git.sh' -o ~/p_utils/git.sh
echo 'source ~/p_utils/git.sh' >> ~/.bashrc
```

### Aliases
| Alias | Description | Raw command |
|-------|-------------|-------------|
| `diff`            | Displays the diff :-) | `git diff --color-words` |
| `all`             | Stages all files and displays status | `git add . --all && git status` |
| `none`            | Unstages all files and displays status | `git reset && git status` |
| `contrebase`      | Continues rebase | `git rebase --continue` |
| `abortrebase`     | Aborts rebase | `git rebase --abort` |
| `skiprebase`      | Skips rebase commit | `git rebase --skip` |
| `abortmerge`      | Aborts merge | `git merge --abort` |
| `ggpushforce`     | Pushes to origin/$(current_branch) with force (fast-forward only, i.e. prevents from overwriting someone's commits) | `git push origin $(current_branch) --force-with-lease` |
| `ggpullrebase`    | Pulls from origin/$(current_branch) using rebase and autostash (requires git 2.6+) | `git pull --rebase --autostash origin $(current_branch)` |
| `amendcommit`     | Amends stages changes to previous commit with previous message | `git commit --amend --no-edit` |
| `fetch`           | Fetches remote branches without verbose output | `git fetch --quiet` |

### Functions
| Function | Description |
|----------|-------------|
| `commit(s)`       | Commits given message |
| `tcommit(s)`      | Commits given message, but prepends ticket number from branch name (separated by underscore). Usage: when on `XYZ-123_the_best_feature` branch, using `tcommit 'foo bar' will commit with message: "XYZ-123 foo bar"` |
| `ggpullremote(s)` | Pulls single remote branch and sets its local remote counterpart (usage: `ggpullremote the_feature_branch`) |
