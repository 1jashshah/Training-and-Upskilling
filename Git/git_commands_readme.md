
Git is a distributed version control system used to track changes in source code.  
This document covers **all essential Git commands** with examples.

---

##  1. Git Setup

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --list
```

---

##  2. Repository Initialization

```bash
git init
git clone https://github.com/user/repo.git
```

---

##  3. Basic Commands

```bash
git status
git add file1.txt
git add .
git commit -m "Added new feature"
git log --oneline
```

---

## 4. Working with Branches

```bash
git branch
git branch feature-1
git checkout feature-1
git checkout -b feature-1
git merge feature-1
git branch -d feature-1
```

---

## 5. Remote Repositories

```bash
git remote add origin https://github.com/user/repo.git
git remote -v
git push origin main
git pull origin main
git fetch origin
```

---

## 6. Undoing Changes

```bash
git reset file.txt
git reset --soft HEAD~1
git reset --hard HEAD~1
git revert <commit_id>
```

---

##  7. Rebase

```bash
git checkout feature-1
git rebase main
git rebase --continue
git rebase --abort
```

---

##  8. Stashing Changes
## git stash is used to temporarily save (stash away) your uncommitted changes without committing them, so that you can work on something else (like switching branches, pulling updates, etc.) and then bring your changes back later 

```bash
git stash
git stash list
git stash apply
git stash drop
```

---

##  9. Viewing Differences

```bash
git diff
git diff --staged
git diff commit1 commit2
```

---

##  10. Tagging

```bash
git tag
git tag v1.0
git tag -a v1.0 -m "Version 1.0"
git push origin --tags
```

---

##  11. Useful Log and History Commands

```bash
git log file.txt
git log --oneline --graph --all
git blame file.txt
```

---

##  12. Clean and Remove Files

```bash
git clean -f
git clean -fd
```

---

##  14. Common Git Workflows

### ➤ Start a new project
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/user/repo.git
git push -u origin main
```

### ➤ Update local repo
```bash
git pull origin main
```

### ➤ Create and merge feature branch
```bash
git checkout -b feature-login
git add .
git commit -m "Added login feature"
git checkout main
git merge feature-login
git push origin main
```

---

## 15. Git Reset vs Revert

| Command | Effect | Use Case |
|:---------|:--------|:----------|
| `git reset --soft` | Moves HEAD, keeps changes staged | Reword or squash commits |
| `git reset --hard` | Discards all changes | Clean start |
| `git revert` | Creates a new commit to undo a previous commit | Safe on shared branches |

---

##  16. Git Rebase vs Merge

git rebase is used to move or reapply commits from one branch onto another branch, creating a clean, linear commit history.
| Feature | `git merge` | `git rebase` |
|:---------|:-------------|:--------------|
| History | Keeps all commits | Linear history |
| Safe for shared branches |  Yes |  No |
| Use When | Want full history | Want clean history |

---

##  17. Visual Examples
```bash
git checkout main
git merge feature-branch

git checkout feature-branch
git rebase main
```

---

##  Summary Table

| Command | Description |
|:---------|:-------------|
| `git init` | Initialize a new repo |
| `git clone` | Clone from remote |
| `git add` | Stage changes |
| `git commit` | Commit staged changes |
| `git status` | Show status |
| `git log` | Show commit logs |
| `git diff` | Compare changes |
| `git branch` | Manage branches |
| `git checkout` | Switch branches |
| `git merge` | Merge branches |
| `git pull` | Fetch + merge |
| `git push` | Push to remote |
| `git reset` | Undo commits |
| `git revert` | Undo a commit safely |
| `git rebase` | Reapply commits |
| `git stash` | Save temporary work |
| `git tag` | Create tags |

---

git stash — Example Scenario
Goal:
## You’re working on a new feature, but suddenly your team lead asks you to fix a critical bug on another branch.
## However, you have uncommitted changes that you don’t want to lose or commit yet. 

Apply your saved work back
git stash apply
---------------------------------------------------------------------------------------------------------------------
git rebase — Example Scenario
## You’re working on a feature branch. While you’re coding, new commits are added to the main branch.
## You want your branch to be up-to-date with main, but you don’t want messy merge commits.

```bash
git checkout feature
git fetch origin
git rebase origin/main
(if want to cancel)
git rebase --abort
```

-----------------------
**Author:** Jash Shah  
**Last Updated:** October 2025
