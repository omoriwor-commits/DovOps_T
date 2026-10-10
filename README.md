# DevOps Technical Lab

A structured learning and reference repository for DevOps, cloud, Oracle DBA, and GoldenGate study materials.

This repository began as an early Git/GitHub practice workspace. It has now been reorganized so each technical area has a clear purpose and navigation path.


## Master Engineering Project

- [Oracle Database Platform Automation](Oracle-Database-Platform-Automation/README.md) — the **single authoritative roadmap** applying the DevOps syllabus to Oracle DBA, OCI/Azure, GoldenGate one-way CDC, infrastructure automation, CI/CD, high availability and observability. This is one integrated project, not separate competing projects.

## Technical Tracks

| Area | Purpose |
|---|---|
| [DevOps](DevOps/) | Git, GitHub, SSH, automation, and DevOps workflow references |
| [OCI](OCI/) | Oracle Cloud Infrastructure study and lab notes |
| [Oracle DBA](Oracle-DBA/) | Oracle Database administration study and lab notes |
| [GoldenGate](GoldenGate/) | Oracle GoldenGate replication study and lab notes |
| [Azure](Azure/) | Microsoft Azure cloud study and lab notes |
| [AWS](AWS/) | Amazon Web Services study and lab notes |

## Repository Structure

```text
DovOps_T/
├── README.md
├── DevOps/
│   ├── README.md
│   ├── git/
│   │   ├── common-git-commands.md
│   │   ├── how-to-create-github-ssh-key-oci-oracle.md
│   │   └── how-to-get-github-ssh-key-setup-script.md
│   └── scripts/
│       └── github-ssh-key-setup.sh
├── OCI/
│   └── README.md
├── Oracle-DBA/
│   └── README.md
├── GoldenGate/
│   └── README.md
├── Azure/
│   └── README.md
├── AWS/
│   └── README.md
└── Investing/
    ├── Investment-Glossary.md
    └── Long-Term-Investing-Learning-Plan.md
```

## How This Repository Is Used

This is primarily a **technical learning/reference workspace**. Larger portfolio-grade projects are maintained separately so they can be reviewed independently.

Current portfolio repositories include:

- [Nginx DevOps Assignment](https://github.com/omoriwor-commits/nginx-devops-assignment)
- [Enterprise Multi-Cloud Database Platform Lab](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab)
- [Enterprise Data Platform Labs](https://github.com/omoriwor-commits/enterprise-data-platform-labs)

## Organization Standard

New material should be placed under the technical area it belongs to rather than in the repository root.

Examples:

```text
Git/GitHub reference     -> DevOps/git/
Reusable shell script    -> DevOps/scripts/
Oracle DBA notes         -> Oracle-DBA/
OCI notes                -> OCI/
GoldenGate notes         -> GoldenGate/
Azure notes              -> Azure/
AWS notes                -> AWS/
```

## Security

Do not commit:

- SSH private keys
- passwords
- API tokens
- cloud credentials
- database credentials
- wallet files containing secrets
- `.env` files with secrets
- production database dumps

This repository is a learning workspace; secrets and live credentials must remain outside Git.
