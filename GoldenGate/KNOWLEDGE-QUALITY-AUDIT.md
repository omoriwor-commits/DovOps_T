# GoldenGate Knowledge Quality Audit

**Scope:** Seventeen instructor recap documents, a VirtualBox training guide, and the existing independently documented Oracle 19c-to-26ai and OCI-to-Azure lab projects.

**Goal:** Separate source-backed engineering material from repetition, ambiguous syntax, unsupported completion claims, and potentially unsafe operational advice. This is an editorial and engineering triage, **not an Oracle certification or live-lab test report**.

## Keep as core technical knowledge

| Topic | Source material | Treatment |
|---|---|---|
| Classic vs Microservices concepts, process roles | Days 1–2 | Consolidate into architecture chapter; verify version-specific product claims |
| Six process-placement topologies | Day 6; existing deployment-methodologies guide | Keep one canonical comparison; cross-link to chosen historical 19c-to-26ai design |
| Installation layout, OUI and OGGCA response-file approaches | Days 3–5 | Keep exact illustrative invocations with release/context qualification; actual response files absent |
| Database prerequisites, logging, credential aliases | Days 7–8 | Keep diagnostically useful SQL, annotate required privileges, CDB/PDB context and minimum logging |
| Extract, trails, Distribution, Receiver, Replicat | Days 9–10 | Preserve data flow, diagnostic commands and validation requirements |
| Parameter-file lifecycle | Day 11 | Keep change-control guidance; parameter scoping requires exact syntax review |
| Initial load, mapping and migration positioning | Days 13–14 and 17 | Keep examples as training material, not validated cutover procedures |
| Admin Client and Classic/MA interoperability | Day 15 | Preserve process and transport concepts; authenticate safely and verify release-specific commands |
| Filtering and transformations | Days 16–17 | Preserve WHERE, FILTER and COLMAP teaching examples after syntax and semantics review |

## Flag before operational use

1. **Day 4 wallet replacement:** the proposed workaround of copying credential wallets from a dummy deployment is **not an approved recovery runbook**. Do not execute or publish as a recommended reset procedure without vendor-supported verification.
2. **Day 7 blanket DBA grant:** not an appropriate default. Prefer supported capture/apply privileges with least privilege and confirmed multitenant context.
3. **Day 12 HANDLECOLLISION default claim:** do not assume collision handling is on by default, or use it indefinitely during normal replication. Confirm exact parameter spelling, documented behavior and cleanup.
4. **Day 10 fixed ten-second checkpoint threshold:** not a universal health criterion. Assess process lag and checkpoint age against workload, activity, and defined SLA.
5. **Days 13–14 initial load and AFTERCSN:** examples do not establish a gap-free instantiation chain. Verify capture start, source consistency SCN, target baseline, Replicat positioning and reconciliation.
6. **Day 15 credentials:** never preserve plaintext demonstration passwords, shell-history passwords, or default VM credentials in public snippets.
7. **Day 16 FILTER syntax:** confirm the precise syntax, function semantics and desired behavior per DML operation in a supported lab before promoting examples to runnable templates.
8. **Day 17 table onboarding:** stopping multiple shared processes is not automatically required or safe. Define zero-loss, restart, logging, data instantiation and impact checks.
9. **Training VM image setup:** treat image download links, default usernames/passwords and import settings as private training metadata; do not endorse an image or reuse default credentials without assessment.

## Condense or exclude from public manual

- Repeated end-of-session lab homework appearing across multiple recap documents.
- Promotional blog/video references without a specific technical claim or validation purpose.
- Repeated definitions of the same GoldenGate component in each session.
- Unsupported universal claims about AI-driven tuning, speed, support matrices or platform interoperability.
- Plaintext passwords, personal contact information, credential-store contents and wallet material.
- Exact original handouts: retain privately in Drive rather than republish instructor-authored content.

## Evidence classification

- **Executed and verified in project record:** link dated outputs, sanitized scripts and observed results.
- **Reported historical lab outcome:** describe historical achievement, noting where outputs have not yet been committed.
- **Vendor-confirmed reference:** cite official release/version documentation; not proof of execution.
- **Instructor training example:** preserve as illustrative syntax, not independently verified.
- **Open verification:** include a clear test plan and acceptance criterion.
- **Rejected or unsafe advice:** label the specific risk and do not use as a command runbook.

## High-value next verification work

1. Capture full sanitized OGGCA deployment response file and post-install service checks from the current supported lab.
2. Archive the exact Integrated Extract and Replicat parameters from a successful Oracle-to-Oracle test.
3. Demonstrate supplemental logging, trail transport, checkpoint, restart and INSERT/UPDATE/DELETE reconciliation.
4. Reconstruct the initial-load and instantiation procedure with explicit no-gap checks.
5. Verify syntax against Oracle's release-specific manuals before publishing copy/paste commands.

## Archive policy

The original training documents remain unchanged in the [Google Drive source archive](https://drive.google.com/drive/folders/1fyt1EcAJWA-Q4UFKDzesz4nqDc6e1wl5). The [working manual](manual/README.md) contains synthesized engineering guidance; linked independent project repositories remain the source of project-level implementation evidence.
