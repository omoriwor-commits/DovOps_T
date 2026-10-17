# Oracle Database Engineering Knowledge Base

This is a cross-repository index of technical references, procedures, incidents, and engineering records. The [main README](README.md) is the public portfolio; the [Platform Automation roadmap](Oracle-Database-Platform-Automation/README.md) describes ongoing integrated work.

## GoldenGate
- [Six deployment methodologies](GoldenGate/six-deployment-methodologies.md): process placement patterns, selection criteria and the selected migration topology.
- [Oracle 19c to 26ai migration](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate): remote Integrated Extract and target apply.
- [Microservices troubleshooting](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/goldengate/troubleshooting/goldengate-26ai-oggca-daemon-registration-troubleshooting.md).
- [Heterogeneous CDC checkpoints](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/tree/main/docs/checkpoints): dated build checkpoints for Migration 3 (VPN/BGP, Extract, trails, Replicat preparation). End-to-end apply was completed afterward; target-side logs will be published after the rerun.

## RAC, ASM and Grid Infrastructure
- [Two-node RAC runbook](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/runbooks/oracle-rac/oracle19c-2node-rac-build-and-troubleshooting.md).
- [October 2026 node2 investigation](Oracle-Database-Platform-Automation/incident-reports/2026-10-rac-node2-startup-investigation.md): OS access restored; full cluster verification outstanding.
- [RAC health-check Python script](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/scripts/oracle-rac/rac_health_check.py).

## Data Guard, RMAN and Oracle DBA
- [Data Guard health-check script](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/scripts/dataguard/dataguard_health_check.sh).
- [Oracle DBA references](Oracle-DBA/README.md).
- [Migration path and RMAN](README.md#migration-path): my three GoldenGate 26ai migrations and RMAN recovery work.

## OCI, Azure, AWS and migration architecture
- [Enterprise multi-cloud engineering lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab).
- [Architecture plan](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/architecture/multicloud-migration-replication-plan.md).
- Topic guides: [OCI](OCI/README.md), [Azure](Azure/README.md), [AWS](AWS/README.md).

## DevOps and automation
- [Platform Automation roadmap](Oracle-Database-Platform-Automation/ROADMAP.md).
- [Git and SSH references](DevOps/README.md).
- [NGINX Docker / Kubernetes CI project](https://github.com/omoriwor-commits/nginx-devops-project).

## Documentation standard

Original execution records remain in their project repositories and are linked from this index to avoid conflicting copies.
