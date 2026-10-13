# Technical Record Template

Copy this template into the relevant topic or project. Delete placeholders before publishing.

## Metadata
- **Title and record type:** Architecture reference / Runbook / Incident / Evidence / Historical reconstruction
- **Origin:** Independent lab / Sanitized professional experience / General reference
- **Date or approximate period:**
- **Technology, versions, and topology:**
- **Verification status:** Documented lab validation / Reported historical outcome / Under investigation / Planned / Reference only
- **Canonical project and related documentation:**

## 1. Objective and technical context
Describe what problem is addressed, when this method is appropriate, design constraints, and operational risk.

## 2. Architecture or symptoms
Describe components and relationships or precise error messages and affected services. Remove sensitive identifiers.

## 3. Prerequisites and safety
Document software compatibility, supported versions, privileges required, backups, change window, access controls, and dependencies.

## 4. Procedure or investigation
For every significant step, record:
1. **Why** it is necessary.
2. **Where and how** to execute the command or configuration.
3. **Expected result** and confirmation command.
4. **Observed result**, only if evidence exists.
5. **Failure branch** and diagnostic commands.

Do not present sample syntax as successfully executed without verification.

## 5. Validation and acceptance criteria
| Test | Expected | Observed | Evidence link |
|---|---|---|---|
| Describe test | Define success | Verified / Unverified | Link or none |

Distinguish partial recovery from complete service validation.

## 6. Root-cause analysis
Separate observations, candidate explanations, proven cause, remediation, and remaining uncertainty.

## 7. Recovery and rollback
Describe reversal, recovery checks, security considerations, and production limitations.

## 8. Lessons and alternatives
Explain trade-offs, rejected designs, and reusable operating principles.

## 9. References and archive provenance
Link official documentation, scripts, dated outputs, source project and related incidents. State which material was reconstructed from memory and which original evidence remains available.

**Publication hygiene:** Never commit secrets, credentials, private keys, personal financial records, proprietary client data or unsanitized production logs.
