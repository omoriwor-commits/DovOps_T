# OCI Engineering Field Guide

Operational references for OCI networking and secure Compute administration.

## Engineering references

- [01 — VCN, Public/Private Subnets, Internet and NAT Gateways](01-vcn-public-private-subnets-internet-nat-gateways.md) — tenancy and compartment checks, subnet design, route tables, NSGs, bastion access, NAT egress and failure isolation.
- [02 — Windows SSH Key Management and OCI Compute Access](02-windows-ssh-key-and-oci-instance-access.md) — key management, Linux Compute access, PuTTY, restricted SSH ingress and diagnostics.

## Related implementation projects

- [Oracle 19c to OCI migration and GoldenGate replication](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate) — an independently documented Oracle 19c→26ai replication/migration lab with reported DML/DDL results. The currently published material is not a complete command-and-output record.
- [Enterprise multicloud database platform](https://github.com/omoriwor-commits/enterprise-multicloud-database-platform-lab) — OCI–Azure network integration, GoldenGate troubleshooting and other database engineering artifacts. Source capture/trail milestones are documented; SQL Server target apply is not yet evidenced end-to-end.

## Operational evidence standard

Add only actual, sanitized host inventory, route/NSG states, commands, checkpoints, SQL results and incident reports. These references are not substitutes for project-specific test results.

## Vendor documentation

- [OCI VCNs and Subnets](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingVCNs.htm)
- [Network security](https://docs.oracle.com/en-us/iaas/Content/Security/Reference/networking_security.htm)
- [NAT Gateway](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/nat-create.htm)
