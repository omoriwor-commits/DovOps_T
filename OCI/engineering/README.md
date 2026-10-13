# OCI Engineering Field Guide

**Scope:** OCI tenancy baseline, Windows SSH access, public/private VCN networking and controlled Internet connectivity. These pages are independently authored operational references based on uploaded lab material and current Oracle documentation. They do not claim that new OCI resources were provisioned or tested as part of writing the guides.

## Engineering topics

1. [01 — OCI Free Tier Account and Tenancy Baseline](01-oci-free-tier-account-and-tenancy-baseline.md) — account signup, identity/tenancy baseline, cost controls and resource eligibility.
2. [02 — Windows SSH Key Management and Compute Access](02-windows-ssh-key-and-oci-instance-access.md) — new key generation, Compute public-key authorization, secure SSH, PuTTY and credential rotation.
3. [03 — VCN, Public/Private Subnets, Internet and NAT Gateways](03-vcn-public-private-subnets-internet-nat-gateways.md) — route separation, NSGs, controlled bastion access, NAT egress and troubleshooting.

## Evidence and security

Reference procedures are not completed lab results. Add sanitized instance metadata, route and NSG details, test outputs, dates and change records only after executing them. Do **not** publish private SSH keys, payment details, tenancy administrator credentials or third-party instructor handouts.

The key pair included in the uploaded source material is excluded. If that private key was previously authorized on any system, rotate it and remove its public counterpart from authorized hosts.

## Oracle references

- [OCI Free Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm)
- [OCI Networking Security](https://docs.oracle.com/en-us/iaas/Content/Security/Reference/networking_security.htm)
- [NAT Gateway](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/nat-create.htm)
- [Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables_topic-working.htm)
