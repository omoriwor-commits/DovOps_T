# Step-by-Step: Create a GitHub SSH Key on OCI Oracle Linux

This guide explains this command:

```bash
ssh-keygen -t ed25519 -C "github-oci-oracle" -f ~/.ssh/id_ed25519_github
```

## What the command does

```text
ssh-keygen
```

Creates a new SSH key pair.

```text
-t ed25519
```

Uses the ED25519 key type.

```text
-C "github-oci-oracle"
```

Adds a label/comment so you can recognize that this key belongs to the OCI Oracle Linux server.

```text
-f ~/.ssh/id_ed25519_github
```

Saves the key using this filename:

```text
~/.ssh/id_ed25519_github
```

The command creates two files:

```text
~/.ssh/id_ed25519_github
~/.ssh/id_ed25519_github.pub
```

The first file is the PRIVATE key. Never share or upload it.

The second file is the PUBLIC key. This is the one you add to GitHub.

---

## Step 1 — Log in as the correct Linux user

For the Oracle server:

```bash
su - oracle
```

Verify:

```bash
whoami
```

Expected:

```text
oracle
```

Then verify the home directory:

```bash
pwd
```

Expected:

```text
/home/oracle
```

---

## Step 2 — Check the existing SSH directory

Run:

```bash
ls -la ~/.ssh
```

Do not overwrite existing SSH keys.

If `id_ed25519_github` already exists, stop and review it before creating another key.

---

## Step 3 — Create the GitHub SSH key

Run:

```bash
ssh-keygen -t ed25519 -C "github-oci-oracle" -f ~/.ssh/id_ed25519_github
```

You will be asked:

```text
Enter passphrase (empty for no passphrase):
```

If you do not want a passphrase, press Enter twice.

Do not enter your GitHub password or Linux password here.

---

## Step 4 — Verify that both key files were created

```bash
ls -l ~/.ssh/id_ed25519_github*
```

You should see:

```text
id_ed25519_github
id_ed25519_github.pub
```

---

## Step 5 — Display the public key

```bash
cat ~/.ssh/id_ed25519_github.pub
```

The output should start with:

```text
ssh-ed25519
```

Copy the entire line. Do not copy the private key file.

---

## Step 6 — Add the public key to GitHub

In GitHub:

1. Open **Settings**.
2. Open **SSH and GPG keys**.
3. Click **New SSH key**.
4. Use a clear title such as `OCI-Oracle-Linux`.
5. Select **Authentication Key**.
6. Paste the full public key.
7. Click **Add SSH key**.

---

## Step 7 — Test the key directly

```bash
ssh -T -i ~/.ssh/id_ed25519_github -o IdentitiesOnly=yes git@github.com
```

A successful result should look like:

```text
Hi omoriwor-commits! You've successfully authenticated, but GitHub does not provide shell access.
```

The message about not providing shell access is normal.

---

## Step 8 — Configure SSH to use the key automatically

Open or create:

```bash
vi ~/.ssh/config
```

Add:

```text
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
```

Then set permissions:

```bash
chmod 600 ~/.ssh/config
```

---

## Step 9 — Test without specifying the key

```bash
ssh -T git@github.com
```

---

## Step 10 — Clone a GitHub repository

Example:

```bash
cd /home/oracle
git clone git@github.com:omoriwor-commits/enterprise-multicloud-database-platform-lab.git
cd enterprise-multicloud-database-platform-lab
git status
```

## Security rules

Never share or commit:

```text
~/.ssh/id_ed25519_github
```

Only this public key is safe to copy:

```text
~/.ssh/id_ed25519_github.pub
```

Also preserve existing SSH keys used for OCI, Azure, GoldenGate, or other servers. Do not overwrite them.
