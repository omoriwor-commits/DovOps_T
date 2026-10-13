# Chapter 4 — Integrated Extract Configuration and Source Trail Management

> **Status:** Oracle 26ai vendor-referenced teaching chapter. **No new Extract created, database changed or command executed.** All deployment names, aliases, trail prefixes and parameter blocks in this chapter are reconstructed teaching examples.  

## Scope and operational checks

1. Explain the function of an **integrated Extract** and how it interacts with Oracle database capture infrastructure.
2. Distinguish a GoldenGate *deployment administration connection* from a *source database login*.
3. Register an Extract **before** adding it, after verifying prerequisites and explicit initial capture position.
4. Create a local trail and match its two-character prefix to the Extract's EXTTRAIL parameter.
5. Diagnose checkpoints, reports, source logging, source capture registration and trail continuity.
6. Assess whether an observed status demonstrates capture only, transport only or actual target-data correctness.

## 1. What integrated Extract does

Integrated Extract operates with Oracle's integrated capture infrastructure to extract logical changes from database redo. Its database registration and capture settings are distinct from the GoldenGate microservice that manages the process. It requires appropriate source privileges, logging and a supported database/platform combination.

```text
  Source Oracle database / redo
            |
            v
  Database integrated capture infrastructure
            |
            v
       Integrated Extract
            |
            v
        Local trail ea#########
            |
            v
    Distribution path (Chapter 5)
            |
            v
        Target replication trail
            |
            v
       Replicat (Chapter 6)
```

**Operational note:** A running Extract proves neither the distribution path nor the target Replicat is delivering correct data. Logs, checkpoint progression, trail sequence and target-row validation are different evidence.

## 2. Preconditions and explicit decisions

Confirm each item before any writable administration command:

| Precondition | Verification | Why it matters |
|---|---|---|
| Certified Oracle source/GoldenGate combination | Exact release and Oracle certification reference | Command availability and integrated capture support vary |
| Proper database connection | Correct CDB/PDB service, `SHOW CON_NAME`, `DBLOGIN` | Wrong container or source compromises registration |
| Oracle redo and capture configuration | Chapter 3 logging queries, required `TRANDATA` | Missing keys or required redo makes logical capture incomplete |
| Capture account | Approved role-scoped privileges | Broad DBA privileges are not a safe default |
| Service access | Correct secured deployment URL, GoldenGate administrative role | Avoid managing the wrong deployment |
| Replication scope | Approved `TABLE` patterns and target design | Unintended schemas or unsupported objects must not be captured |
| Initial capture boundary | Documented start point, current transaction state and initial-load approach | Prevent gaps and duplicate application |
| Trail prefix/path | Writable deployment trail location, free space and retention | Extract must produce an unambiguous trail |
| Change/recovery plan | Saved configuration, approved maintenance and monitoring | Registration/start can affect capture lifecycle |

**Historical versus example:** Your separate Oracle 19c → 26ai project recorded `EXT19C` for remote integrated capture and `REP26AI` for apply. This chapter's process `EXTLAB`, alias `gg_source`, table `HR.EMPLOYEES` and trail `ea` are **not claimed as historical configuration**.

## 3. Inspect the source database (read-only)

Use the correct SQL container and a sufficiently privileged account.

```sql
SHOW CON_NAME;
SHOW USER;

SELECT name, db_unique_name, database_role, open_mode, log_mode,
       force_logging, supplemental_log_data_min
FROM v$database;

SHOW PARAMETER enable_goldengate_replication;

-- After registration: captures registered with the connected database.
SELECT capture_name, status
FROM dba_capture
ORDER BY capture_name;
```

**Interpretation:** A zero-row `DBA_CAPTURE` result *before* registration is normal. After registration, inspect the intended registered capture name/state in the correct source/mining database. It is not proof that Extract writes trail records successfully, nor that Replicat applied anything.

The source's archived redo retention must remain sufficient for normal lag and restart/recovery; do not purge redo or trails merely because an Extract shows RUNNING.

## 4. Open Admin Client and connect to the right deployment

**Where:** GoldenGate software host or a supported Admin Client installation. **Account:** authorized GoldenGate administrator. **Risk:** connecting is administrative access; avoid exposing passwords.

```bash
cd "$OGG_HOME/bin"
./adminclient
```

Use the approved secured deployment endpoint, deployment identity and authenticated administrative account. Oracle documents deployment-specific `CONNECT` examples with credentials; **do not paste passwords into public commands or store them in shell history**. Prefer an approved secure credential method available for your release.

Inside the intended Admin Client context, after the database connection alias has been configured in Administration Service:

```text
DBLOGIN USERIDALIAS gg_source
```

This is the **source Oracle database login**, not the Admin Client service login. Prove it points to the right source/PDB before registration. Reference: [Oracle 26ai — Add an Extract](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/extract-add-primary-extract.html).

## 5. Register an integrated Extract

**Change-controlled, illustrative Admin Client commands:** execute only after validating privileges, selected database and start SCN/initial-load plan.

```text
REGISTER EXTRACT EXTLAB DATABASE
```

Oracle's 26ai Extract guide explicitly requires integrated Extract registration **before** creation. Registration prepares the database integrated capture relationship. Names must satisfy GoldenGate length and naming limits. This registration can take time; inspect the Admin Client message and database-side status.

For multitenant capture, Oracle also documents `REGISTER EXTRACT ... DATABASE CONTAINER (...)` variants. **Do not assume** that a generic root connection and a PDB-scoped registration are interchangeable. Source topology, remote/downstream mining and shared dictionary options alter valid syntax; refer to the applicable Oracle command reference before adding those clauses.

**Validation (read-only):**

```sql
SELECT capture_name, status FROM dba_capture ORDER BY capture_name;
```

Vendor: [REGISTER EXTRACT](https://docs.oracle.com/en/database/goldengate/core/26/gclir/register-extract.html).

## 6. Add an integrated Extract and trail

**Change-controlled, reconstructed example in Admin Client:**

```text
ADD EXTRACT EXTLAB, INTEGRATED TRANLOG, BEGIN NOW
ADD EXTTRAIL ea, EXTRACT EXTLAB, MEGABYTES 200
```

**Exact role of each directive:**

| Syntax | Meaning | Important qualification |
|---|---|---|
| `ADD EXTRACT` | Creates a managed Extract group | Does not itself confirm successful ongoing capture |
| `INTEGRATED TRANLOG` | Selects integrated Oracle log capture | Requires prior database registration and support |
| `BEGIN NOW` | Requests a starting boundary at creation/start time | **Not a generic initial-load instantiation strategy**; confirm consistency |
| `ADD EXTTRAIL ea` | Configures a local Extract trail prefix | Does **not** immediately create on-disk trail files |
| `EXTRACT EXTLAB` | Binds trail to one Extract group | Multiple Extracts cannot write the same trail |
| `MEGABYTES 200` | Sets a maximum trail-file size | Capacity and defaults are release/context dependent |

Oracle states that `ADD EXTTRAIL` defines the trail; the **actual trail files are generated as Extract writes data**. In 26ai the trail prefix is two characters and each file receives a nine-digit sequence suffix. Examples such as `ea000000001` are illustrative only.

Official references: [ADD EXTRACT](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-extract.html), [ADD EXTTRAIL](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-exttrail.html), [Add a Trail](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/extract-add-trail.html).

## 7. Extract parameter file

**Illustrative teaching configuration, not a tested copy of your historical lab:**

```text
EXTRACT EXTLAB
USERIDALIAS gg_source DOMAIN OracleGoldenGate
EXTTRAIL ea
TABLE HR.EMPLOYEES;
```

**Line-by-line explanation:**

1. `EXTRACT EXTLAB`: names the Extract whose parameters are being configured.
2. `USERIDALIAS gg_source DOMAIN OracleGoldenGate`: uses a credential alias from the configured credential system rather than a plaintext database password. Confirm the domain and alias are actually available.
3. `EXTTRAIL ea`: declares the local trail used by this Extract; its prefix must match the `ADD EXTTRAIL` binding.
4. `TABLE HR.EMPLOYEES;`: captures the specified table in the appropriate source scope. **Multitenant naming may require a PDB-qualified pattern**, e.g. `PDB1.HR.EMPLOYEES`; don't interchange two-part and three-part object names without verifying connection and source topology.

The Oracle 26ai MA guide provides an Extract parameter-file example containing `EXTRACT`, `USERIDALIAS`, `EXTTRAIL` and `TABLE` directives. In the Administration Service GUI, inspect the process parameter editor; for command-line administration, use the release-supported parameter-file management mechanism. The training mentions deployment runtime configuration under `$DEPLOYMENT_HOME/etc/conf/ogg`; verify the actual deployment variables and paths rather than hardcoding them.

Reference: [Add an Extract — Parameter File](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/extract-add-primary-extract.html).

## 8. Starting and validating capture

Only after registration, trail binding, parameter validation and an approved start boundary should the owner start the Extract through Administration Service or a supported Admin Client command.

**Read-only Admin Client inspections:**

```text
INFO ALL
INFO EXTRACT EXTLAB
STATS EXTRACT EXTLAB
```

**OS-side observational checks (adapt to actual deployment location):**

```bash
df -hT
# Verify the true deployment data home first:
ls -lh "$OGG_DATA_HOME"
```

**Collect real evidence:** process status, checkpoints, Extract report, database registration, actual trail prefix and sequence progression, committed source DML and captured operation statistics. If an idle database generates no source changes, zero new DML counts do not automatically mean Extract is broken.

**Validation boundary:** This chapter establishes the source capture side only. End-to-end replication is proved **after** Distribution/Receiver/Replicat setup and source-target data comparison.

## 9. Diagnosing common Extract and trail faults

| Symptom | Likely investigation | Safe initial action |
|---|---|---|
| Registration fails | Database alias/container/privileges; wrong source; unsupported integrated capture configuration | Inspect log and source account privileges, do not repeat blindly |
| Extract abends | Parameter syntax, redo access, capture registration, object support, logging, trail filesystem | Inspect report, error log and exact OGG error code |
| Process running but zero records | Idle application, uncommitted changes, wrong TABLE scope, misconfigured registration | Commit a controlled DML transaction and inspect status/stats |
| Trail not appearing | Trail binding mismatch, Extract not started, path/permissions, no captured work | Compare parameter `EXTTRAIL` against `ADD EXTTRAIL` output |
| Trail grows without target movement | Distribution/Receiver/Replicat stage unconfigured or unhealthy | Diagnose next pipeline boundary, do not delete trail |
| Source checkpoint lag | Long transactions, source redo backlog, insufficient resources, connectivity or log retention | Inspect checkpoint/report and source constraints |
| Trail sequence missing | Deleted/moved trail, retention/purge policy, downstream lag | Preserve state, recover required records using a supported method |

**Security and recovery:** Avoid indiscriminate trail cleanup, force repositioning, `DELETE EXTRACT` or `UNREGISTER EXTRACT` as first-response troubleshooting. Each can compromise capture continuity and must have a validated recovery path.

## 10. Validation checklist

**Exercise A — Read-only reconnaissance**

1. Identify CDB/PDB and database logging mode.
2. Inspect `DBA_CAPTURE` before creating a capture process.
3. Confirm source account, TLS deployment endpoint and planned table scope.
4. Write expected evidence for successful registration and for actual trail output.

**Exercise B — Disposable lab installation (change-controlled)**

1. Confirm Chapter 3 prerequisites and the source's exact supported release.
2. Register `EXTLAB` and compare database-side registration.
3. Add integrated Extract and bind a distinct `ea` trail.
4. Configure a suitable table scope and approved source credential alias.
5. Start Extract and commit controlled INSERT/UPDATE/DELETE transactions on the table.
6. Collect status, stats, errors, trail sequence and source transaction identifiers.
7. Do **not** call the source-to-target replication successful until the later apply chapter verifies target rows.

**Review questions:** Why does registration precede Extract creation? What is different between `ADD EXTTRAIL` and the resulting physical trail file? Can `INFO EXTRACT` alone demonstrate that Replicat applied changes? What is the risk of `BEGIN NOW` during an already populated source-to-target migration?

**Answers:** Integrated capture needs a database registration; trail configuration only reserves/binds the trail while files are written later; no, capture status does not prove target apply; start boundary must align with a consistent initial data baseline.

## 11. Evidence log template

```text
Lab date / observer:
Source Oracle database version, CDB/PDB:
GoldenGate 26ai exact build and deployment:
Capture method (local, remote or downstream):
Extract name:
Database credential alias (NO password):
Capture registration confirmation:
Approved starting SCN/CSN and snapshot method:
Extract parameter file (redacted):
Trail prefix and output location:
Captured INSERT/UPDATE/DELETE counts:
Checkpoint and report excerpts:
Error log / unresolved issues:
Target reconciliation: NOT TESTED IN THIS CHAPTER
Final evidence label: Vendor example / reconstructed / tested with attached outputs
```

## References and quality status

- [Oracle 26ai — Add an Extract](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/extract-add-primary-extract.html)
- [Oracle 26ai — REGISTER EXTRACT](https://docs.oracle.com/en/database/goldengate/core/26/gclir/register-extract.html)
- [Oracle 26ai — ADD EXTRACT](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-extract.html)
- [Oracle 26ai — ADD EXTTRAIL](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-exttrail.html)
- [Oracle 26ai — Add a Trail](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/extract-add-trail.html)

**Completion state:** Vendor syntax/reference checked; original training material preserved; example configuration reconstructed and clearly labeled; fresh lab registration/capture/validation **pending**.

**Next chapter:** Distribution Service, Receiver Service, path connectivity and trail delivery between GoldenGate deployments.
