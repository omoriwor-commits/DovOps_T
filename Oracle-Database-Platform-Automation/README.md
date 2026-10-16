# Oracle Database Platform Automation

> **Canonical project roadmap — one integrated project, not separate Oracle/DevOps/multi-cloud projects.**

## Mission

**Starting point:** Before this project, I took one Oracle workload through three GoldenGate 26ai migrations: (1) Oracle database upgrade and OS migration with replication, (2) on-premises to OCI cloud migration with replication, and (3) cross-cloud heterogeneous Oracle-to-SQL Server migration with replication. This project rebuilds that path as a repeatable, automated platform and publishes the evidence.

Build a repeatable, automated, secure, observable and recoverable enterprise Oracle database platform using the **DevOps syllabus** as the learning and implementation framework.

**Career target:** Database Platform Engineer / Oracle Database Engineer with DevOps and Cloud Automation skills.

**Method:** Learn → Build → Test → Prove → Document → Publish.

## One integrated architecture

```text
OCI: Oracle Database 26ai (source)
       |
       | Site-to-site IPsec VPN / BGP
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

**Status:** The pipeline shown was completed in my earlier lab. Within this project it will be rebuilt with Terraform, Ansible and CI/CD.

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

## Execution Order (controlling)

Phase numbers follow the DevOps syllabus. They are **not** the build order.
This section is the single controlling execution order for both README.md
and ROADMAP.md. Pacing is by competency: a stage is complete only when its
**Done when** criteria are met and evidence is committed.

### Stage 1 — Core Platform v1 (target: ~8 weeks)

| Order | Target week | Work | Phase | Status |
|---|---|---|---|---|
| 1 | 1 | Close Phase 0: rename repo, protect `main`, budget alerts, lab inventory, security rules | 0 | In progress |
| 2 | 1 | Close RAC node 2 incident: re-enable SELinux, verify `crsctl`/`srvctl`, record timestamped output | 10B | In progress |
| 3 | 2 | Oracle health checks (database, listener, tablespace, RMAN), scheduled, ShellCheck-clean; all work via PRs | 1–2 | Planned |
| 4 | 3–4 | Rebuild GoldenGate 26ai pipeline (OCI Oracle → Azure SQL Server): DML, row-count validation, lag, restart | 11 | Planned |
| 5 | 5 | Terraform OCI VCN + compute modules; remote state in Object Storage; clean apply/destroy | 4–5 | Planned |
| 6 | 6 | Ansible configures the fresh server and installs Oracle with no manual steps; idempotent rerun | 6 | Planned |
| 7 | 7 | GitHub Actions: ShellCheck, `terraform validate` + TFLint, ansible-lint on every PR | 3 (partial) | Planned |
| 8 | 8 | Grafana dashboard (availability, tablespace, backup status); 5-minute recorded demo | 9A (partial), 12 (partial) | Planned |

**Stage 1 done when:** a new OCI server can be provisioned, configured and
health-checked from this repository, every PR runs the pipeline, the
GoldenGate pipeline has published evidence, and a recorded demo exists.

### Stage 2 — Platform Operations

1. Database CI/CD with SQLcl Liquibase and an ephemeral Oracle Database Free test database (Phase 3, full)
2. RMAN automated restore testing and recovery reports (Phase 9C)
3. Security hardening and secrets via Vault (Phase 9B)
4. Data Guard automation, switchover and failover tests (Phase 10A)
5. Rerun and document migrations 1 and 2: 19c → 26ai and on-premises → OCI (Phase 11)

### Stage 3 — Containers and Integration

1. Docker: Oracle Database Free container, Trivy scanning (Phase 7)
2. Kubernetes + Helm for supporting services (Phase 8)
3. Integrated capstone: full rebuild from runbooks, final architecture, demo (Phase 12)

### Stage 4 — Extensions (only after Phase 12)

AWS extension, then Phase II advanced platform engineering and agentic AI.

**Certifications:** OCI Architect Associate after Stage 1 week 5;
HashiCorp Terraform Associate after Stage 1.

## Target project directory structure

```text
oracle-db-platform-automation/
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

Stage 1, Order 1 — close Phase 0.
