# Oracle GoldenGate Training Archive — Sessions 1–17

**Source archive:** [Original Word documents in Google Drive](https://drive.google.com/drive/folders/1fyt1EcAJWA-Q4UFKDzesz4nqDc6e1wl5) (access controlled by the Drive owner).

These notes are an **index and independent synthesis**, not a reproduction of the instructor's original handouts. The Drive folder retains the original Word documents and a separate VirtualBox lab setup guide. The material discusses GoldenGate 23ai and 26ai in different sessions; validate version-specific features and supported syntax before use.

## Session map

| Day | Topic | Engineering takeaway |
|---|---|---|
| 01 | Classic vs Microservices | GGSCI, deployment model and REST management concepts |
| 02 | Microservices components | Service Manager, Administration, Distribution, Receiver, metrics |
| 03 | Installation planning | Home directories, permissions, storage, GUI and silent installation |
| 04 | OGGCA deployment | Service Manager, credentials, deployments and daemon registration |
| 05 | Silent install | Installer and OGGCA response-file driven configuration |
| 06 | Deployment patterns | Local/remote Extract and Replicat; dedicated hub topologies |
| 07 | Database preparation | Database-level settings, logging, GoldenGate privileges and credential aliases |
| 08 | Supplemental logging | Database/table logging, log-group views, row identification |
| 09 | Data flow setup | Extract, trails, Distribution Path, Receiver, Replicat, DML checks |
| 10 | Troubleshooting | Process health, lag, checkpoints, sequence gaps, reports |
| 11 | Parameter files | GLOBALS, scoped process parameters, change-control procedure |
| 12 | Collision handling | Conflict behavior, restarts, lifecycle caution |
| 13 | GoldenGate hub and initial load | Remote file initial-load examples and mapping |
| 14 | Migration cutover | SCN/CSN concepts, instantiation boundaries, cutover |
| 15 | Admin Client and interoperability | Admin Client, Classic–MSA transport patterns |
| 16 | Filtering and transformation | WHERE, FILTER, GoldenGate expressions |
| 17 | Column mapping and onboarding | COLMAP, USEDEFAULTS, adding a replicated table |

## Navigation

- [Technical reference and implementation checklist](../manual/README.md)
- [Six deployment methodologies](../six-deployment-methodologies.md)
- [Oracle 19c → 26ai project record](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate)
- [GoldenGate Microservices troubleshooting project record](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/goldengate/troubleshooting/goldengate-26ai-oggca-daemon-registration-troubleshooting.md)

## Provenance and safe reuse

- **Training recap:** a source for concepts and illustrative commands, not evidence that a procedure ran in this portfolio's lab.
- **Historical project evidence:** linked separately; retain its own documented test boundaries.
- **Production runbook:** requires release-specific Oracle compatibility checks, complete inputs, validation and rollback.
- **Security:** do not publish training VM passwords, credential wallets, password-bearing command lines, private links, or proprietary images.
- **Review flags:** avoid blanket DBA grants; do not transplant credential wallets between installations; do not assume collision handling is enabled by default; do not claim a universal checkpoint-lag SLA; validate initial-load/SCN positioning instead of relying on a single SCN query.

The underlying notes are instructor-provided training materials. Public documentation here uses a reorganized technical index and original explanations rather than republishing the training files.
