# Oracle Database Engineering Knowledge Base

This is a cross-repository index of technical references, procedures, incidents, and historical engineering records. The [main README](README.md) is the public portfolio; the [Platform Automation roadmap](Oracle-Database-Platform-Automation/README.md) describes ongoing integrated work.

## GoldenGate
- [Six deployment methodologies](GoldenGate/six-deployment-methodologies.md): process placement patterns, selection criteria and the selected migration topology.
- [Oracle 19c to 26ai migration](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate): remote Integrated Extract and target apply.
- [Microservices troubleshooting](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/goldengate/troubleshooting/goldengate-26ai-oggca-daemon-registration-troubleshooting.md).
- [Heterogeneous CDC checkpoints](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/tree/main/docs/checkpoints): source capture validated; SQL Server target apply not yet verified.

## RAC, ASM and Grid Infrastructure
- [Two-node RAC runbook](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/runbooks/oracle-rac/oracle19c-2node-rac-build-and-troubleshooting.md).
- [October 2026 node2 investigation](Oracle-Database-Platform-Automation/incident-reports/2026-10-rac-node2-startup-investigation.md): OS access restored; full cluster verification outstanding.
- [RAC health-check Python script](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/scripts/oracle-rac/rac_health_fixed.py).

## Data Guard, RMAN and Oracle DBA
- [Data Guard health-check script](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/scripts/dataguard/dataguard_health_check.sh).
- [Oracle DBA references](Oracle-DBA/README.md).
- [Historical RMAN and OCI migration overview](README.md#engineering-projects): historical migration and recovery scenarios; supporting technical records are being organized.

## OCI, Azure, AWS and migration architecture
- [Enterprise multi-cloud engineering lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab).
- [Architecture plan](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab/blob/main/docs/architecture/multicloud-migration-replication-plan.md).
- Topic guides: [OCI](OCI/README.md), [Azure](Azure/README.md), [AWS](AWS/README.md).

## DevOps and automation
- [Platform Automation roadmap](Oracle-Database-Platform-Automation/ROADMAP.md).
- [Git and SSH references](DevOps/README.md).
- [NGINX Docker / Kubernetes CI project](https://github.com/omoriwor-commits/nginx-devops-project).

## Documentation standard

New technical material is documented through the [technical record template](docs/TECHNICAL-RECORD-TEMPLATE.md). Original execution records remain in their project repositories and are linked from this index to avoid conflicting copies.
