# 03 — OCI VCN, Public/Private Subnets, Internet and NAT Gateways

**Scope:** OCI virtual networking design, routed public/private Compute access, SSH via bastion, and controlled outbound Internet connectivity for private instances. Configuration and diagrams are examples; actual lab outputs are pending.

## 1. Reference topology

~~~text
                         Internet
                            |
                     Internet Gateway
                            |
             +--------------+-------------+
             | OCI VCN: 10.0.0.0/16       |
             |                            |
             | Public subnet             |
             | 10.0.20.0/24              |
             | Bastion VM (public IP)     |
             | Route: 0/0 -> IGW         |
             |                            |
             | Private subnet            |
             | 10.0.10.0/24              |
             | App/DB VM (no public IP)   |
             | Route: 0/0 -> NAT         |
             |                            |
             +--------------+-------------+
                            |
                        NAT Gateway
                            |
                     Outbound Internet
~~~

CIDRs are illustrative and need to be checked against existing VCN and on-premises network prefixes before deployment. The public and private subnet route tables must be independent. A subnet's *public/private* designation and the presence of a route do not override NSG/security-list policies.

## 2. Address and route plan

| Resource | Example | Implementation rule |
|---|---|---|
| VCN | \`10.0.0.0/16\` | Avoid CIDR overlap with connected networks |
| Public subnet | \`10.0.20.0/24\` | Public IPs allowed; route \`0.0.0.0/0 -> IGW\` |
| Private subnet | \`10.0.10.0/24\` | No public IPs; route \`0.0.0.0/0 -> NAT\` |
| Internet Gateway | One enabled gateway | Provides external connectivity for eligible public resources |
| NAT Gateway | One gateway per VCN generally sufficient | Outbound connectivity for private resources; no unsolicited inbound Internet |
| Public NSG | Inbound SSH from trusted CIDR only | No broad internet SSH exposure |
| Private NSG | SSH from approved bastion/security group | Only required application ports |

Do not use “all protocols from public subnet” unless the lab's precise threat model requires it. A narrower TCP/22 source rule is sufficient for this SSH demonstration.

## 3. Create the VCN and subnets

1. Open **Networking > Virtual Cloud Networks** and select the approved compartment.
2. Create a VCN with a nonoverlapping CIDR (e.g. \`10.0.0.0/16\`).
3. Create or verify the Internet Gateway.
4. Create separate public and private route tables.
5. Add \`0.0.0.0/0 -> Internet Gateway\` **only** to the public subnet's route table for this design.
6. Create the public subnet \`10.0.20.0/24\` and associate its route table.
7. Create the private subnet \`10.0.10.0/24\` without public IPv4 assignment and associate its own route table.
8. Create and associate NSGs for permitted network traffic; review effective security lists too.

OCI automatically handles normal intra-VCN local routing for the VCN CIDRs; extra explicit routes for the two subnets are not normally required. See Oracle's route-table documentation.

## 4. Provision an isolated bastion and private instance

- Bastion instance: Linux image, public subnet, public IP, newly generated SSH public key.
- Private instance: Linux image, private subnet, **no** public IP, new or approved SSH public key.
- Choose supported shapes under the tenancy's current Free Tier/quotas; older source screenshots refer to outdated Oracle Linux/shape examples and should not be treated as current selections.
- Apply NSGs permitting the bastion-to-private SSH path but no direct internet-to-private ingress.

The source document used a separate Linux VM as the bastion. OCI also provides a managed Bastion service, which may reduce the need for a persistently exposed public VM. Check its supported session types and prerequisites before choosing an approach.

## 5. Connect through a bastion without moving the private key

From a Windows workstation with OpenSSH installed:

~~~powershell
ssh -i "$env:USERPROFILE\.ssh\id_ed25519_oci_lab" -J opc@<BASTION_PUBLIC_IP> opc@<PRIVATE_INSTANCE_IP>
~~~

This ProxyJump syntax assumes your local SSH identity is authorized on both hosts and the bastion can reach TCP/22 on the private instance. If separate credentials/keys are required, define appropriately secured host entries in \`~/.ssh/config\` instead. **Do not copy a private key onto the public bastion host.**

## 6. Add NAT-based outbound access to the private subnet

1. Under the VCN select **NAT Gateways** and create/enable the gateway.
2. In the **private subnet route table**, add \`0.0.0.0/0\` with target **NAT Gateway**.
3. Confirm the private NSG/security list permits the required outbound protocol and destination.
4. Confirm DNS resolution and host firewall rules permit the expected request.
5. Test a permitted outbound HTTPS request from the private VM.

~~~bash
# Example only; execute from the PRIVATE instance.
curl -I --connect-timeout 8 https://www.oracle.com/
~~~

A valid HTTP response or redirect and configured route/security controls provide stronger evidence than relying on ICMP \`ping\` alone, which may be blocked by a remote host. Verify that the private VM still has no public IP and that no inbound internet access was introduced.

The NAT gateway is not a bastion and cannot be used for unsolicited inbound SSH. OCI documents a private-subnet Internet connectivity quick action that can create NAT, route and security configuration when appropriate.

## 7. Failure isolation

| Observation | First checks |
|---|---|
| Public VM has no internet | Public IP, correct public route table, enabled IGW, egress rules, DNS |
| SSH to bastion times out | Authorized source CIDR, port 22, public IP, host firewall, subnet |
| Bastion cannot SSH to private VM | Private IP, NSGs/security lists, local VCN path and key authorization |
| Private VM cannot reach internet | Private route table points to NAT, NAT enabled, egress and DNS |
| Private VM accepts public inbound SSH | Security incident: verify subnet classification, public IP, rules and exposure |
| Unexpected charges | Check chosen Compute shape, attached storage and related service usage |

## 8. Verification and teardown checklist

- [ ] Actual VCN CIDR and subnet identifiers recorded.
- [ ] Public subnet uses the intended IGW route.
- [ ] Private subnet uses the NAT route and has no public-IP assignment.
- [ ] SSH source restriction is reviewed; no unrestricted TCP/22 exposure.
- [ ] Direct approved SSH to public VM and bastion-based SSH to private VM tested.
- [ ] Private outbound HTTPS works and unsolicited inbound Internet remains blocked.
- [ ] NSG and route-table screenshots are sanitized.
- [ ] Trial resources and associated gateways/IPs/volumes are deleted when no longer needed.

~~~text
Compartment / date:
VCN and subnet IDs (redacted):
Bastion/private VM image:
Route/NSG verification:
SSH test:
NAT HTTPS test:
Private public-IP check:
Cost/cleanup status:
Result: PENDING / VERIFIED WITH EVIDENCE
~~~

## Oracle references

- NAT Gateway: https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/nat-create.htm
- Route Tables: https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables_topic-working.htm
- VCN Security: https://docs.oracle.com/en-us/iaas/Content/Security/Reference/networking_security.htm
- Managed Bastion: https://docs.oracle.com/en-us/iaas/Content/Bastion/Concepts/bastionoverview.htm
- Private-subnet internet quick action: https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/quick-action-nat-gateway.htm

**Source basis:** Uploaded Lab 3 OCI VCN/Internet/NAT gateway PDF, with corrections to subnet security and current Oracle references. Instructor screenshot sequences are not redistributed.
