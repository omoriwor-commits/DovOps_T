# Lab Inventory

Every server, VM and cloud account this project uses or has used. No IP addresses, OCIDs or account IDs are recorded here (see [security-rules.md](security-rules.md)). Items marked **TODO** still need to be confirmed from the machines or consoles.

Last reviewed: October 2026

## Local lab (VirtualBox)

| Host | Role | OS | Database / software | Status |
|---|---|---|---|---|
| Physical host | Runs all local VMs | TODO | VirtualBox version TODO; CPU / RAM / disk TODO | Active |
| `racnode1` | Former RAC node 1 | Oracle Linux TODO | Previous Oracle 19c Grid Infrastructure, ASM, RAC | Deleted; 26ai rebuild planned |
| `racnode2` | Former RAC node 2 | Oracle Linux TODO | Previous Oracle 19c Grid Infrastructure, ASM, RAC | Deleted; 26ai rebuild planned; see the [October 2026 incident](../incident-reports/2026-10-rac-node2-startup-investigation.md) |
| 19c primary (hostname TODO) | Migration 1 source | Oracle Linux 7.9 | Oracle 19c, PDB `PRODBHR` | TODO |
| 19c standby (hostname TODO) | Physical standby | Oracle Linux 7.9 | Oracle 19c Data Guard | TODO |
| 26ai host (hostname TODO) | Migration 1 target, Migration 2 source | Oracle Linux 9.8 | Oracle AI Database 26ai (`PDB23AI`), GoldenGate 26ai | TODO |

RAC shared storage: three VirtualBox shared disks for OCR, DATA and FRA (20 GB, 40 GB and 20 GB).

## Cloud accounts

| Cloud | Used for | Region | Resources | Status | Budget alert |
|---|---|---|---|---|---|
| OCI | Migration 2 target, Migration 3 source | us-chicago-1 | Compute VM (Oracle 26ai), VCN, DRG, Site-to-Site VPN | Shut down; TODO confirm terminated or stopped | TODO; not yet evidenced |
| Azure | Migration 3 GoldenGate hub and SQL Server target | East US | Resource group with SQL Server VM, GoldenGate VM, VPN gateway, NSGs | Shut down; TODO confirm resource group deleted | $50/month, alerts at 50/75/90/100% (Aug 2026); TODO confirm still active |
| AWS | Not used by this project yet (planned extension) | n/a | None | Not in use | Set before first use |

## Cost note

An Azure VPN gateway bills by the hour whether or not the VMs run. If "shut down" meant only deallocating the VMs, check that the VPN gateway and its public IP were deleted too.
