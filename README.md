# Oracle Database Platform Engineering

Hands-on Oracle database engineering across **Oracle Cloud Infrastructure (OCI), Azure, and local Oracle RAC labs**, focused on database migration, change data capture (CDC), high availability, backup and recovery, incident investigation, and automation.

This portfolio links implementation runbooks, configuration examples, scripts, and test records from independent lab work. **Status refers to documented lab milestones, not production deployments.** Where validation evidence is not yet published, the limitation is identified.

## Featured engineering work

### 1. OCI → Azure heterogeneous replication — implementation in progress

[Explore the multi-cloud database platform lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab)

```text
OCI: Oracle Database 26ai
    |
    | Private cross-cloud connectivity: IPsec/IKEv2 VPN + BGP
    v
Azure: Oracle GoldenGate hub
    | Oracle Extract EXTORA → trail ea
    | SQL Server Replicat REPSQL (apply validation pending)
    v
Azure: SQL Server 2022
```

**Documented milestones:** site-to-site network connectivity; Oracle source preparation; GoldenGate Oracle and SQL Server runtimes; Oracle Extract and trail capture; target SQL Server connectivity and checkpoint-table preparation.

**Outstanding validation:** start and verify Replicat, reconcile target DML, prove restart/checkpoint behavior, and test recovery/cutover. Do not interpret successful Extract capture as completed end-to-end replication.

[Architecture, checkpoints, and troubleshooting](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/tree/main/docs)

### 2. Oracle Database 19c → Oracle AI Database 26ai — cross-version CDC lab

[Explore the migration project](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate)

```text
Oracle 19c / PRODBHR (Oracle Linux 7.9)
    → Remote Integrated Extract EXT19C
    → GoldenGate trail
    → Integrated Replicat REP26AI
    → Oracle AI Database 26ai / PDB23AI (Oracle Linux 9.8)
```

**Design:** off-box remote capture to avoid installing GoldenGate 26ai on the older source operating system; existing Oracle 19c Data Guard remains separate from the CDC path.

The lab project description reports successful INSERT/UPDATE/DELETE and CREATE TABLE replication testing. **The linked repository currently publishes the architecture and planned validation, not the corresponding execution logs or sanitized parameter files.** Validation artifacts will be linked when available.

### 3. Oracle RAC / ASM — availability and incident investigation

[Read the October 2026 node-startup investigation](Oracle-Database-Platform-Automation/incident-reports/2026-10-rac-node2-startup-investigation.md)

A two-node Oracle RAC lab incident was investigated across virtualization, operating-system services, security settings, and the Oracle cluster stack. Host availability was restored, but cluster-wide resource recovery and definitive root cause remain unverified in the available record. The report separates observed symptoms, hypotheses, workarounds, and outstanding validation.

### 4. Oracle Database Platform Automation — integrated workstream

[Platform architecture and technical roadmap](Oracle-Database-Platform-Automation/README.md)

A phased project bringing together Oracle operations, GoldenGate, RMAN/Data Guard/RAC, shell automation, cloud infrastructure, CI/CD, and observability. The roadmap describes intended capabilities; it is **not** a claim that all phases are implemented.

## Work status

| Workstream | Current evidence / boundary | Status |
|---|---|---|
| OCI ↔ Azure network | VPN/BGP and private database connectivity described in project records | Documented lab validation |
| Oracle 26ai Extract | Extract, trail capture, and SQL Server connectivity documented | Documented lab validation |
| Oracle → SQL Server Replicat | Configuration/checkpoint preparation; end-to-end apply not yet demonstrated | In progress |
| Oracle 19c → 26ai GoldenGate | Migration architecture published; execution evidence still to be added | Evidence publication pending |
| Oracle RAC / ASM | Node-startup troubleshooting documented; full cluster recovery unverified | Investigation ongoing |
| RMAN / Data Guard | Supporting lab work referenced; publish specific recovery and HA verification outputs | Evidence pending |
| Terraform / Ansible | Repeatable cloud/database provisioning | Planned |
| Database CI/CD | Version-controlled database deployments | Planned |
| Prometheus / Grafana | Health, backup, and CDC observability | Planned |

## Repository navigation

| Directory | Focus |
|---|---|
| [Oracle-Database-Platform-Automation](Oracle-Database-Platform-Automation/) | Architecture, project phases, incident investigations, and roadmap |
| [Oracle-DBA](Oracle-DBA/) | Oracle administration and recovery reference materials |
| [GoldenGate](GoldenGate/) | CDC configuration and replication references |
| [OCI](OCI/) | OCI infrastructure and database platform notes |
| [Azure](Azure/) | Azure connectivity and target platform notes |
| [AWS](AWS/) | AWS database and infrastructure references |
| [DevOps](DevOps/) | Git workflows, reusable scripts, and SSH setup documentation |

Published scripts and working evidence vary by area; directory presence alone does not imply completed implementation.

## Other portfolio repositories

- [NGINX DevOps Project](https://github.com/omoriwor-commits/nginx-devops-project) — NGINX, Docker, Docker Hub, Kubernetes, and GitHub Actions lab.
- [Enterprise Multi-Cloud Database Platform Lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab) — OCI ↔ Azure networking, GoldenGate, SQL Server, and troubleshooting.
- [Enterprise Data Platform Labs](https://github.com/omoriwor-commits/enterprise-data-platform-labs) — Oracle 19c-to-26ai migration architecture.

## Engineering and evidence approach

For each substantive change, aim to publish the **configuration or script**, a reproducible procedure, sanitized **dated command/test output**, and an explicit success/failure criterion. Operational incidents should distinguish confirmed root cause from hypotheses and temporary workarounds.

## Security

Public examples should use test data and sanitized connection details. Review commands, logs, images, and Git history for secrets, private keys, wallet material, access tokens, credentials, and sensitive infrastructure identifiers before publication. This README does **not** assert that the repository's entire history has been audited.
