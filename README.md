# Oracle Database Platform Engineering

Oracle database engineering portfolio covering **migration, replication, backup and recovery, high availability, troubleshooting, and automation** across Oracle Cloud Infrastructure (OCI), Azure, and local VirtualBox environments.

These are independent hands-on lab projects. The current goal is to bring the strongest existing Oracle DBA work into one repeatable, version-controlled **Oracle Database Platform Automation** platform using DevOps practices.

## Featured project — Oracle Database Platform Automation

[Architecture, phases, and engineering roadmap](Oracle-Database-Platform-Automation/README.md)

```text
Git / GitHub
     |
     v
Bash / Python -> GitHub Actions -> Terraform / Ansible (planned integration)
     |
     +-- Oracle 19c / 23ai / 26ai databases
     +-- GoldenGate capture and replication
     +-- RAC / ASM and Data Guard
     +-- RMAN backup, restore and recovery
     |
     v
Monitoring, validation, runbooks, and recovery testing
```

**Current platform:** Local VirtualBox hosts with Oracle 19c, Oracle 23/26ai, and GoldenGate 26ai available for further testing. Historical OCI and Azure labs are documented separately because free-tier access has expired.

## Engineering projects

### Oracle 19c → OCI migration — completed historical lab

Migration exercises using **RMAN, Oracle Data Pump, and GoldenGate** with OCI Base Database Service. The implementation is part of the prior hands-on work being reconstructed for publication; original execution artifacts and final validation outputs are being collected before detailed claims are made.

### RMAN backup and recovery — completed historical lab exercises

Full and incremental backup, restore, and point-in-time recovery scenarios. The next documentation milestone is to publish sanitized RMAN scripts, relevant logs, and recovery validation from preserved lab records or repeatable local tests.

### Oracle 19c → Oracle AI Database 26ai — GoldenGate migration

[Migration architecture and implementation notes](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate)

```text
Oracle 19c / PRODBHR (Oracle Linux 7.9)
   -> Remote Integrated Extract EXT19C
   -> GoldenGate trail
   -> Integrated Replicat REP26AI
   -> Oracle AI Database 26ai / PDB23AI (Oracle Linux 9.8)
```

**Engineering decision:** Run GoldenGate off-box on the newer Oracle Linux environment rather than install GoldenGate 26ai on the older source OS. The lab work includes reported DML and DDL replication testing; the linked repository currently contains the architecture and will be expanded with sanitized configuration and execution evidence.

### OCI → Azure heterogeneous CDC — captured and tested; target apply in progress when lab ended

[Enterprise Multi-Cloud Database Platform Lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab)

```text
OCI Oracle 26ai
   -> IPsec/IKEv2 VPN + BGP
   -> Azure GoldenGate hub: Extract EXTORA / trail ea
   -> SQL Server Replicat REPSQL
   -> Azure SQL Server 2022
```

The documented lab validated VPN/BGP connectivity, the Oracle GoldenGate Extract and trail, SQL Server access, and target-side Replicat preparation. **End-to-end SQL Server apply was not completed in the published record.** The cloud environment is no longer active.

### Oracle RAC / ASM — two-node local lab

[October 2026 node startup investigation](Oracle-Database-Platform-Automation/incident-reports/2026-10-rac-node2-startup-investigation.md)

Cluster and operating-system troubleshooting across VirtualBox, Oracle Linux, Clusterware, and ASM. Node OS availability was restored; database and cluster-wide recovery checks are part of the next validation pass.

## DevOps integration roadmap

| Capability | Position |
|---|---|
| Git / GitHub project history and documentation | Implemented across existing repositories |
| Local Oracle 19c, 23/26ai and GoldenGate labs | Available for continued validation |
| Historical Oracle migration and RMAN exercises | Completed lab work; evidence consolidation underway |
| OCI–Azure VPN, Extract, and SQL connectivity | Validated in historical lab |
| SQL Server Replicat end-to-end apply | Incomplete in historical lab |
| Automated Oracle health checks and RMAN controls | Next implementation phase |
| Terraform / Ansible infrastructure automation | Planned |
| Database CI/CD with GitHub Actions | Planned |
| Prometheus / Grafana monitoring | Planned |

The roadmap tracks DevOps integration of prior Oracle skills, not a requirement to repeat every historical exercise.

## Repository guide

| Location | Material |
|---|---|
| [Oracle Database Platform Automation](Oracle-Database-Platform-Automation/) | Integrated architecture, roadmap, and incident reports |
| [Oracle DBA](Oracle-DBA/) | Database administration and recovery references |
| [GoldenGate](GoldenGate/) | Replication references |
| [OCI](OCI/) / [Azure](Azure/) / [AWS](AWS/) | Cloud engineering references |
| [DevOps](DevOps/) | Git, SSH, and reusable shell tooling |

### Related project repositories

- [Enterprise Multi-Cloud Database Platform Lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab) — OCI–Azure GoldenGate and SQL Server integration.
- [Enterprise Data Platform Labs](https://github.com/omoriwor-commits/enterprise-data-platform-labs) — Oracle 19c–26ai migration.
- [NGINX DevOps Project](https://github.com/omoriwor-commits/nginx-devops-project) — Docker, Kubernetes, Docker Hub, and GitHub Actions CI/CD.

## Publication practice

Code, configuration examples, logs, and screenshots are sanitized before publication. Sensitive credentials, private keys, wallet files, and confidential data must not be committed.
