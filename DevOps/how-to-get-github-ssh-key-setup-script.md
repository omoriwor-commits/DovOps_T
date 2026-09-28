# How to Get the GitHub SSH Key Setup Script

The setup script is stored here:

```text
DovOps_T/DevOps/github-ssh-key-setup.sh
```

Use one of the methods below.

## Method 1 — If DovOps_T is already cloned on the machine

1. Open Git Bash or Linux terminal.
2. Go to the repository:

```bash
cd ~/DovOps_T
```

3. Get the latest changes from GitHub:

```bash
git pull origin main
```

4. Go to the DevOps folder:

```bash
cd DevOps
```

5. Confirm the script is present:

```bash
ls -l github-ssh-key-setup.sh
```

6. View the script:

```bash
cat github-ssh-key-setup.sh
```

7. If you want to run it:

```bash
bash github-ssh-key-setup.sh
```

Do not run the script if you already have a GitHub SSH key you want to keep without first reviewing the file.

---

## Method 2 — If DovOps_T is NOT cloned yet

1. Open Git Bash or Linux terminal.
2. Go to your home directory:

```bash
cd ~
```

3. Clone the repository:

```bash
git clone git@github.com:omoriwor-commits/DovOps_T.git
```

4. Enter the repository:

```bash
cd DovOps_T
```

5. Enter the DevOps folder:

```bash
cd DevOps
```

6. Confirm the script is present:

```bash
ls -l github-ssh-key-setup.sh
```

7. View it:

```bash
cat github-ssh-key-setup.sh
```

8. Run it only after reviewing it:

```bash
bash github-ssh-key-setup.sh
```

---

## Method 3 — Download from the GitHub website

1. Open the `DovOps_T` repository in GitHub.
2. Open the `DevOps` folder.
3. Open `github-ssh-key-setup.sh`.
4. Click `Raw`.
5. Save the page as:

```text
github-ssh-key-setup.sh
```

6. Open Git Bash in the folder where you saved it.
7. Review it:

```bash
cat github-ssh-key-setup.sh
```

8. Run it only if the content is correct:

```bash
bash github-ssh-key-setup.sh
```

## Key rule

- `git clone` = first-time copy of the repository to a machine.
- `git pull` = update an already-cloned repository.
- `git push` = send your committed changes back to GitHub.
