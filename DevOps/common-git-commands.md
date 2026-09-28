# Common Git Commands

This reference covers the Git commands used most often for day-to-day lab and repository work.

| Command | Purpose |
|---|---|
| `git status` | Show changed, staged, and untracked files |
| `git clone <repo>` | Copy a GitHub repository to your machine |
| `git pull` | Get the latest changes from GitHub |
| `git add <file>` | Stage one file |
| `git add .` | Stage all current changes |
| `git commit -m "message"` | Save staged changes locally |
| `git push` | Send local commits to GitHub |
| `git log --oneline` | Show commit history in short form |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git branch` | Show local branches |
| `git switch <branch>` | Move to another branch |
| `git switch -c <branch>` | Create and switch to a new branch |
| `git remote -v` | Show remote repository URLs |
| `git mv old new` | Move or rename a tracked file |
| `git rm <file>` | Remove a tracked file |
| `git restore <file>` | Discard unstaged changes to a file |
| `git restore --staged <file>` | Unstage a file |
| `git config --global --list` | Show global Git configuration |

## Normal workflow

```bash
git pull
git status
git add .
git commit -m "Describe the change"
git push
```

## Safer documentation workflow

```bash
git pull
vi README.md
git status
git diff
git add README.md
git commit -m "Update lab documentation"
git push
```

## Three commands to remember

```bash
git status
git pull
git push
```

## Core save workflow

```bash
git add .
git commit -m "message"
git push
```

## Key distinction

```text
git clone = first-time copy
git pull  = update an existing copy
git push  = send your commits to GitHub
```

## Safety note

Do not use `git add .` blindly in a production-style repository.

Always check:

```bash
git status
```

first, because `git add .` can accidentally stage:

- passwords or credentials
- private SSH keys
- database dumps
- logs
- temporary files
- cloud configuration files
- `.env` files containing secrets

Use a suitable `.gitignore` and stage specific files when appropriate.
