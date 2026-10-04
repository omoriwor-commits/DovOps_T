# How to Get the GitHub SSH Key Setup Script

The setup script is stored here:

```text
DovOps_T/DevOps/scripts/github-ssh-key-setup.sh
```

## If DovOps_T is already cloned

```bash
cd ~/DovOps_T
git pull origin main
cd DevOps/scripts
ls -l github-ssh-key-setup.sh
cat github-ssh-key-setup.sh
bash github-ssh-key-setup.sh
```

Review the script before running it, especially if you already have GitHub SSH keys.

## If DovOps_T is not cloned yet

```bash
cd ~
git clone git@github.com:omoriwor-commits/DovOps_T.git
cd DovOps_T/DevOps/scripts
ls -l github-ssh-key-setup.sh
cat github-ssh-key-setup.sh
bash github-ssh-key-setup.sh
```

## GitHub website method

1. Open the `DovOps_T` repository.
2. Open `DevOps/scripts`.
3. Open `github-ssh-key-setup.sh`.
4. Review the file before copying or running it.

## Key rule

```text
git clone = first-time copy of the repository
git pull  = update an already-cloned repository
git push  = send your committed changes back to GitHub
```
