# Oracle Database Platform Automation

> **Canonical project roadmap — one integrated project, not separate Oracle/DevOps/multi-cloud projects.**

## Mission

Build a repeatable, automated, secure, observable and recoverable enterprise Oracle database platform using the **DevOps syllabus** as the learning and implementation framework.

**Career target:** Database Platform Engineer / Oracle Database Engineer with DevOps and Cloud Automation skills.

**Method:** Learn → Build → Test → Prove → Document → Publish.

## One integrated architecture

```text
OCI: Oracle Database 26ai (source)
       |
       | Planned site-to-site VPN / BGP
       | One-way heterogeneous CDC
       v
Azure: GoldenGate 26ai services
       |
       | Replicat / apply and validation
       v
Azure: SQL Server 2022 (target)

Cross-cutting: GitHub Actions | Terraform | Ansible | Security
               Prometheus/Grafana | Backup/Recovery | Runbooks

Local supporting lab: Oracle RAC / ASM
Future extensions: AWS, then advanced AI automation
```

**Important:** The arrow shows the intended *logical* one-way data flow. Do not infer that the VPN, BGP, or end-to-end Replicat has been validated until evidence is recorded.

## DevOps syllabus mapped to project deliverables

| Phase | Subject | Working evidence / deliverable |
| --- | --- | --- |
| 0 | Foundation | Goals, architecture, scope, security baseline, cost controls |
| 1 | Linux and Bash | Oracle health checks and operational scripts |
| 2 | Git and GitHub | Version control, branches, pull requests, documentation |
| 3 | Database CI/CD | SQLcl/Liquibase, GitHub Actions, dev→test→prod, tfsec/Trivy and secret hygiene |
| 4 | OCI | IAM, VCN/networking, compute, storage and database infrastructure |
| 5 | Terraform | Modules, provisioning, protected remote state |
| 6 | Ansible | Oracle Linux/database configuration, Vault for secrets |
| 7 | Docker | Oracle Database Free container and tools |
| 8 | Kubernetes | Helm, StatefulSets, persistent volumes; learning/lab scope |
| 9 | Observability | Prometheus/Grafana; availability, CDC lag, backup success SLOs |
| 10A | Data Guard | Standby automation, switchover/failover testing |
| 10B | RAC / ASM | Local cluster/storage lab, node-failure and recovery tests |
| 11 | GoldenGate | Oracle 26ai → SQL Server 2022 one-way heterogeneous CDC, validated |
| 12 | Integrated platform | Demonstration, runbooks, architecture, tests and portfolio evidence |
| Extension | AWS | VPC, IAM, EC2, Oracle/RDS evaluation, CloudWatch, Terraform |
| Advanced | Agentic AI | Guardrailed diagnostics and operational automation |

**Phase numbers describe the syllabus, not a rigid execution order.**

## Execution order by career impact

1. **GoldenGate first:** finish and validate Replicat apply; prove INSERT/UPDATE/DELETE propagation, latency and reconciliation. Preserve working source deployment `DEP1`; verify target deployment details before making changes.
2. **Terraform + Ansible:** build a repeatable Oracle Linux/database environment with infrastructure-as-code and configuration management.
3. **Database CI/CD:** version SQL/PLSQL and automate controlled schema deployments through GitHub Actions.
4. **Platform operations:** security, observability, RMAN, Data Guard, RAC/ASM and failure/recovery testing.
5. **Integrated demonstration:** document the full pipeline; add AWS/Kubernetes/AI only when the core is demonstrably working.

## Target project directory structure

```text
DovOps_T/
└── Oracle-Database-Platform-Automation/
    ├── README.md                  # this authoritative roadmap
    ├── docs/
    │   ├── architecture/
    │   ├── roadmap/
    │   ├── runbooks/
    │   └── evidence/
    ├── phase-00-foundation/
    ├── phase-01-linux-bash/
    ├── phase-02-git-github/
    ├── phase-03-database-cicd/
    ├── phase-04-oci/
    ├── phase-05-terraform/
    ├── phase-06-ansible/
    ├── phase-07-docker/
    ├── phase-08-kubernetes/
    ├── phase-09-observability/
    ├── phase-10a-data-guard/
    ├── phase-10b-rac-asm/
    ├── phase-11-goldengate/
    ├── phase-12-integrated-platform/
    └── extensions/
        ├── aws/
        └── ai-automation/
```

The directories above are **planned** and should be created as deliverables are added. Git does not track empty directories.

## Completion standard

Every phase must include:
- A reproducible implementation (commands, IaC, scripts or configuration).
- Successful tests with dated outputs and explicit acceptance criteria.
- Troubleshooting notes, security checks, and a rollback/recovery approach where relevant.
- A README/runbook and sanitized evidence committed to GitHub.
- Resume/LinkedIn claims **only after verification**.

Status legend: **Done** = verified evidence; **In progress** = actively implemented, not yet fully verified; **Planned** = not yet validated. Historical experience is not proof that this repository contains the evidence.

## Project governance

- **One project identity:** Oracle Database Platform Automation.
- **One master roadmap:** this document.
- **One learning framework:** DevOps syllabus applied to Oracle database platform engineering.
- **One primary data pipeline:** OCI Oracle → Azure GoldenGate → Azure SQL Server (one-way CDC).
- Oracle DBA, GoldenGate, RAC, Data Guard, RMAN, DevOps, cloud, and automation are **workstreams/phases within this project**, not competing project identities.
- Existing repositories and technical reference folders can continue to hold reusable notes or prior lab artifacts; link verified evidence rather than claiming it has moved.
- Never commit credentials, SSH private keys, connection secrets, production data, or unredacted screenshots.

## Next checkpoint

**Priority:** complete GoldenGate target Replicat and capture repeatable end-to-end CDC test evidence. Then begin Terraform/Ansible provisioning automation.
