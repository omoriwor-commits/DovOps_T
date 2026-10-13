# Repository ownership and deduplication plan

**Scope:** GitHub account `omoriwor-commits`, repository trees reviewed October 2026. This is an inventory and navigation plan, **not authorization to delete** any project files or Git history.

## Canonical locations

| Topic | Authoritative project/location | Supporting material | Rule |
|---|---|---|---|
| Integrated Oracle platform roadmap | [DovOps_T / Oracle-Database-Platform-Automation](Oracle-Database-Platform-Automation/README.md) and [ROADMAP](Oracle-Database-Platform-Automation/ROADMAP.md) | Main [portfolio overview](README.md) | Keep full roadmap in its original folder; summarize and link from root |
| OCI ↔ Azure Oracle-to-SQL Server CDC | [enterprise-multicloud-database-platform-lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab) | Main portfolio overview and roadmap | Own the detailed network, OGG runtime, troubleshooting and dated checkpoints here |
| Oracle 19c → 26ai migration | [enterprise-data-platform-labs/migrations/oracle-19c-to-26ai-goldengate](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate) | Summary in main portfolio | Keep Oracle-to-Oracle migration separate from heterogeneous SQL Server CDC |
| RAC startup incident | [Oracle-Database-Platform-Automation/incident-reports](Oracle-Database-Platform-Automation/incident-reports/) | RAC runbooks in multi-cloud lab | Incident = dated observations and evidence; runbook = repeatable procedure. Cross-link, don't delete either |
| Data Guard health script | [enterprise-multicloud-database-platform-lab/scripts/dataguard](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/tree/main/scripts/dataguard) | Oracle DBA reference directory | Maintain one runnable source; link instead of copying |
| RAC health script | [enterprise-multicloud-database-platform-lab/scripts/oracle-rac](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/tree/main/scripts/oracle-rac) | RAC incident and platform summary | Maintain one runnable source; link instead of copying |
| NGINX container and CI/CD | [nginx-devops-project](https://github.com/omoriwor-commits/nginx-devops-project) | Portfolio summary | Separate working application from Oracle platform docs |
| Git and SSH reference material | [DevOps/git](DevOps/git/) and [DevOps/scripts](DevOps/scripts/) | Other projects that use SSH/Git | Reuse by links rather than duplicating key-generation instructions |
| Investing material | [Investing](Investing/) — **currently public** | None | Review contents and any sensitive history before moving to a private repository; no deletion yet |

## Overlap classification

- **Not duplicates:** Oracle 19c→26ai Integrated Extract/Replicat migration versus OCI Oracle→Azure SQL Server heterogeneous replication. They share GoldenGate concepts but are different architectures, environments and validation stages.
- **Related, retain separately:** RAC build/troubleshooting runbook versus October 2026 node-startup incident report. Different purposes and evidence.
- **Navigation/documentation overlap:** The root portfolio README, platform README, and roadmap all introduce the same integrated program. Root should be concise; project README should define architecture and current milestones; ROADMAP should retain execution phases and governance.
- **Chronology versus summary:** Multi-cloud README should summarize verified current status; dated checkpoints and project history preserve the original timeline. Do not delete checkpoint records merely because a later summary exists.
- **Exact file copies:** No matching Git blob hashes were observed between the 43 tracked files in the four nonempty repositories scanned. This does **not** rule out near-identical paragraphs, untracked local files, branches, or historical versions.

## Change controls

1. Inventory file paths and content before consolidation; inspect branch and historical evidence separately if a deletion is proposed.
2. Preserve working scripts, YAML, architecture diagrams, dates, incident logs and prior commits.
3. Replace repeated narrative prose with a concise summary and link to the canonical document, **only after reviewing both**.
4. Use topic branches and pull requests; avoid force-push, history rewrite, repository renames or mass moves without explicit approval.
5. Verify relative links and compare Git diffs before merging.
6. Audit public paths for secrets and sensitive details; removing a file from current HEAD does not erase historical exposure.
7. Update README claims only when test outputs support the current milestone.

## Next controlled cleanup candidates

1. Audit the main platform README versus ROADMAP section by section and shorten duplicated *introductory* prose, without losing technical rules.
2. Fix broken relative links and add cross-repo links to canonical scripts and evidence.
3. Preserve the separate GoldenGate projects; align each summary with its own actual test status.
4. Review Investing/ for privacy requirements; plan safe private transfer and history treatment separately.
5. Inspect all Git branches and commit history before claiming a complete duplicate/security audit.
