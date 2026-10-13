# 01 — OCI Free Tier Account and Tenancy Baseline

**Scope:** Oracle Cloud Infrastructure account registration, initial tenancy verification, IAM security, cost controls and service-limit awareness. This is a reference procedure; account creation has not been executed as part of this guide.

## 1. Account and subscription model

Oracle Cloud Infrastructure (OCI) Free Tier has two distinct parts:

| Offering | Operational meaning |
|---|---|
| Free Trial | Promotional credits and a time limit for eligible OCI services |
| Always Free | Specific eligible resources within published monthly/service limits, generally in the tenancy home region |

Oracle currently documents **$300 in promotional credit valid for up to 30 days** for the Free Trial. Always Free resources have separate eligibility and capacity constraints; not all service shapes, regions, features, or attached resources are included. Confirm the current offer and prices in your signup region. The home-region choice matters for Always Free Compute and Autonomous Database.

Official reference: https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm

## 2. Registration procedure

1. Open Oracle's official OCI signup page: https://www.oracle.com/cloud/free/
2. Select the Free Tier account registration option.
3. Supply the requested account holder, country and contact information.
4. Validate email/mobile details using Oracle's verification steps.
5. Choose the **home region carefully**, checking Always Free capacity considerations.
6. Complete the identity and payment verification required by Oracle. Use only Oracle's official signup form; do not disclose full card information in screenshots, logs or GitHub.
7. Review the current free-tier terms, costs, promotion duration and upgrade conditions.
8. Open the OCI Console through the approved tenancy identity-domain sign-in process.

Never assume that a resource is free just because the account was registered through a free-tier offer. Check the exact resource and associated networking/storage charges before provisioning.

## 3. Tenancy baseline and access controls

Record non-sensitive tenancy properties: tenancy display name, chosen home region, tenancy/region context, compartments, identity domain, assigned IAM groups and intended administrator/nonadministrator roles.

Set up MFA where supported and use individual named users rather than sharing administrator credentials. Limit the scope of resource-management access with IAM policies and compartment boundaries. Keep any training organization or classroom tenancy access instructions private; they do not authorize administration in another environment.

Recommended account separation:

| Identity or scope | Responsibility |
|---|---|
| Tenancy owner/administrator | Governance, identity configuration and permitted policy changes |
| Network administrator | VCN, subnet, gateways, NSGs and route tables in approved compartments |
| Compute operator | VM provisioning and operation within defined policies |
| Observer | Read-only resource inventory and audit review |

IAM policy syntax and permissions must be determined for the current identity-domain model and tenancy scope. Do not copy full-administrator policies into a public lab.

## 4. Cost and lifecycle controls

Before a resource is created:

- Confirm that its shape/service is Always Free eligible or identify the expected promotional-credit usage.
- Inspect limits, quotas and region availability.
- Review boot/block volumes, backups, public IP behavior and any associated services.
- Establish a lab shutdown and deletion plan.
- Review tenancy usage and billing/cost reports after provisioning.

Use resource tags such as \`project=oci-engineering-lab\` and \`owner=<team>\` where supported; do not tag with credentials or personal payment information.

## 5. Readiness and validation record

~~~text
Account created / date:
Home region:
Identity domain and login verification:
MFA status:
Lab compartment:
Authorized IAM role:
Free Tier and quota verification:
Expected eligible Compute shape:
Billing alert / cost check:
Resources provisioned:
Screenshots sanitized:
Status: PENDING / VERIFIED WITH EVIDENCE
~~~

The checklist above describes expected evidence, **not observed results**.

## 6. Operational risks

| Risk | Control |
|---|---|
| Unexpected charges | Check current eligibility/price; monitor cost and avoid uncontrolled upgrades |
| Trial promotion expires | Know the expiration and status of remaining resources |
| IAM overprivilege | Use least privilege and separate identities |
| Exposed account data | Do not commit account credentials, payment information or private tenancy screenshots |
| Capacity unavailable | Check regional quotas and availability before designing a dependent lab |

## Sources

- Oracle Free Tier: https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm
- Always Free resources: https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm
- OCI Console: https://cloud.oracle.com/

**Source basis:** Uploaded Lab 1 account setup PDF; expanded and updated using Oracle's public Free Tier documentation. No original handout reproduced.
