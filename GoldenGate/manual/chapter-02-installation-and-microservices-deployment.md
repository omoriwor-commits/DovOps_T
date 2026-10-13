# Chapter 2 — Oracle GoldenGate 26ai Installation and Microservices Deployment

> **Evidence status:** Vendor-referenced teaching chapter; no fresh installation executed. Based on instructor recaps Days 3–5 plus Oracle's 26ai documentation. Example paths are illustrative, not verified historical paths.

## Learning objectives

Understand software versus deployment installation; plan binary and writable homes; gather an OS baseline; distinguish GUI and silent software installs; configure Service Manager and deployments with OGGCA; verify security, service lifecycle and installation evidence; troubleshoot orphaned services responsibly.

## 1. GoldenGate software is not a GoldenGate deployment

GoldenGate software installation creates an executable home (OGG_HOME). Afterward, Oracle GoldenGate Configuration Assistant (OGGCA) creates the Service Manager and one or more replication deployments. A Service Manager can manage several local deployments. It can run manually, as an operating-system daemon, or under supported XAG management.

```text
Oracle Linux host
  /u01/app/ogg/ogg26ai      example software home: bin/oggca.sh, bin/adminclient
  /u02/ogg/srvmgr           example Service Manager runtime home
  /u02/ogg/DEP1             example replication deployment home (configuration/logs/trails)
```

The paths above are a *design illustration*. The actual installed and deployment locations are selected during setup. Keep binaries, service configuration, logs and trail storage appropriately separated, and design for ownership, capacity, retention, backup and software upgrade.

## 2. Read-only Linux prerequisite inspection

**Run on:** prospective GoldenGate Linux host. **User:** approved administrative or installation account. **Risk:** read-only, but outputs may contain private infrastructure information.

```bash
hostnamectl         # host and OS identity
cat /etc/os-release # OS distribution and release
uname -r            # running kernel
id                  # current user/group identity
groups              # supplementary group membership
df -hT              # filesystem availability and type
lsblk -f            # disks and mounts
free -h             # physical/available memory
ip -br addr         # host addresses
ss -lnt             # listening TCP sockets / port collisions
```

Before installing, complete a baseline: **host, release, exact GoldenGate 26ai build, source/target Oracle versions, Oracle multitenant connection/service, supported-platform matrix, software user/group, storage plan, service ports, TLS certificate plan, TNS_ADMIN, rollback and restart ownership**.

Check Oracle's exact release documentation and entitlement before changing anything. The original instructor's training VM is not evidence that a particular installer procedure was executed.

## 3. Installation account and filesystem layout

An OS installation account, a database GoldenGate user and a GoldenGate service administrator are **different identities** with different privileges. Do not equate them. Day 3 introduces the choice between Oracle OS user and a dedicated GoldenGate installation OS account; select by site policy and Oracle guidance.

```bash
# EXAMPLE ONLY — requires approved user/group and change control; do not paste verbatim.
# sudo install -d -o <gg_os_user> -g <gg_os_group> -m 0750 /u02/ogg/srvmgr
# sudo install -d -o <gg_os_user> -g <gg_os_group> -m 0750 /u02/ogg/DEP1
```

Do not commit passwords, copied training VM credentials, wallet material or filled response files to public GitHub.

## 4. Software installation methods

Training Days 3–5 describe Oracle Universal Installer (GUI and silent modes). The following is **training-derived illustrative syntax**, contingent on the chosen software package actually providing this installer and an appropriate response-file format:

```bash
./runInstaller -silent -responseFile /secure/path/installer.rsp
```

**Required evidence:** software package and checksum; compatible platform version; actual installer command; installation log; installed build and filesystem ownership. The instructor's recaps **do not contain the full OUI response file**, so this chapter does not invent one.

## 5. OGGCA interactive configuration

**Where:** installed GoldenGate host. **Account:** approved GoldenGate install/configuration user. **Impact:** creates or changes Service Manager, deployments, administrative access and service configuration.

```bash
cd "$OGG_HOME/bin"
./oggca.sh
```

Record wizard choices: **new versus existing Service Manager, Service Manager host/port, manual versus daemon versus XAG mode, strong passwords and TLS, deployment name and directories, Administration/Distribution/Receiver/Performance Metrics services, Oracle Net environment including TNS_ADMIN, and any generated response file**.

The OGGCA wizard can save response-file settings after interactive configuration. Keep actual secrets in a protected location and redact them before archiving. Reference: [Oracle 26ai deployment guide](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy.html).

## 6. OGGCA silent configuration — verified vendor syntax

Oracle's documented 26ai invocation is:

```bash
"$OGG_HOME/bin/oggca.sh" -silent -responseFile /secure/path/oggdeploy.rsp
```

**Correction to Day 5 instructor recap:** Oracle documents the capital F spelling, `-responseFile`. Use a complete, version-appropriate [official sample response-file template](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/reference-oggca-sample-file-silent-deployment.html). The recaps do not supply the filled response-file parameters, so this command is *not* independently runnable as given.

Document the exact configuration option, deployment identities and paths, Service Manager mode, TLS/password policy and admin secret handling before executing in a throwaway lab. Reference: [Add deployment in silent mode](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy-silent-deployment.html).

## 7. Start and stop Service Manager safely

First determine which lifecycle model the configured Service Manager actually uses.

**Daemon/systemd mode — read-only inspection:**

```bash
systemctl status OracleGoldenGate
systemctl is-enabled OracleGoldenGate
systemctl cat OracleGoldenGate
journalctl -u OracleGoldenGate -n 80 --no-pager
```

**Daemon/systemd mode — change-controlled operations:**

```bash
sudo systemctl start OracleGoldenGate
sudo systemctl stop OracleGoldenGate
```

Confirm the service unit's actual name and whether there is active replication before operating on it.

**Manual mode** uses scripts in the configured Service Manager directory:

```bash
"$OGG_SRVMGR_DIRECTORY/bin/startSM.sh"
"$OGG_SRVMGR_DIRECTORY/bin/stopSM.sh"
```

Manual mode requires the correct Oracle GoldenGate deployment environment variables. These scripts are *not* generated for daemon mode. If XAG manages GoldenGate, use the approved Grid Infrastructure/XAG controls. [Oracle: Start and Stop Service Manager](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy-start-stop-sm.html).

## 8. Deployment security and post-install verification

Prefer HTTPS with certificate validation and restricted UI/API access. Use scoped service and database credentials. Never publish credentials, wallets, or populated password-containing response files.

| Check | Evidence required |
|---|---|
| Software | Exact 26ai build, successful installer report, expected binaries |
| Service Manager | Confirmed lifecycle mode and healthy process/unit |
| Deployment | Correct deployment name, homes and component services |
| Security | Trusted TLS, restricted listeners, authenticated administrative access |
| Database connectivity | Correct source/target service and environment configuration |
| Runtime storage | Writable directories, trail and log capacity, ownership and retention |
| Restart | Authorized restart successfully recovers required services |
| End-to-end | Deferred until Extract/transport/Replicat configuration; verify target DML, not just service status |

Do not claim complete replication from successful OGGCA alone.

## 9. Troubleshooting case — OGGCA registration versus leftover services

The separately recorded GoldenGate lab reported an OGGCA registration issue where DEP1 service processes stayed alive after Service Manager was stopped. This is historical project evidence, **not newly reproduced by this chapter**.

```bash
# Read-only diagnostic examples
systemctl status OracleGoldenGate --no-pager
ss -lntp
ps -ef | grep -E 'adminsrvr|distsrvr|recvsrvr|pmsrvr|ServiceManager' | grep -v grep
```

**Reasoning:** confirm active ports, ownership, process ancestry, correct deployment and logs. Do not blindly `kill -9` process groups, wipe deployments, copy credential wallets from a dummy install, or rerun OGGCA against occupied directories. Preserve reports and use supported stop/cleanup methods in a maintenance window.

Related record: [OGGCA troubleshooting](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/goldengate/troubleshooting/goldengate-26ai-oggca-daemon-registration-troubleshooting.md).

## 10. Hands-on teaching exercise

**Part A (safe planning):** gather read-only Linux data, draw software/Service Manager/DEP1 paths, choose ports, identify security controls and expected capacity. Explain why an OS account differs from a database credential.

**Part B (isolated lab only):** obtain correct licensed software and an official response-file template, execute interactive OGGCA, save and redact its generated configuration, reproduce deployment silently in a *new* lab, then record actual status, logs, service endpoints and restart results.

**Part C (troubleshooting):** a Service Manager unit reports stopped but a deployment port remains occupied. Explain how to prove which child owns the port and why a blanket kill/reinstall is unsafe.

## Instructor's knowledge check

1. What does installing OGG_HOME create that OGGCA does not?
2. Why separate Service Manager and deployment runtime directories?
3. Which command inventories current listener ports without making changes?
4. Why does a successful OGGCA run not prove that Replicat is applying?
5. What is the exact Oracle-documented option for specifying an OGGCA silent response file?
6. What must be checked before applying a systemctl stop command?

**Answers:** software binaries/inventory; lifecycle, storage and upgrade separation; `ss -lnt`; capture/transport/apply not yet configured or reconciled; `-responseFile`; actual service mode, active processes, maintenance window and downstream impact.

## Evidence classification and chapter status

- **Vendor-confirmed:** 26ai OGGCA workflow, `-responseFile` invocation, and manual/systemd lifecycle documented by Oracle.
- **Training-derived:** OUI silent installer illustration, Day 3 directory and OS account discussion, example deployment naming.
- **Historical lab:** DEP1 registration problem, separately documented; no claim of fresh verification.
- **Pending:** actual installation response file, OGGCA file, executed installation transcript, verified TLS and restart test, replication correctness.

## Official references

- [Oracle GoldenGate 26ai Microservices documentation](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/index.html)
- [Deployment and OGGCA](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy.html)
- [Silent OGGCA deployment](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy-silent-deployment.html)
- [OGGCA response template](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/reference-oggca-sample-file-silent-deployment.html)
- [Service Manager lifecycle](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/deploy-start-stop-sm.html)

**Next: Chapter 3 — Oracle database preparation, multitenant privileges, supplemental logging and verification.**