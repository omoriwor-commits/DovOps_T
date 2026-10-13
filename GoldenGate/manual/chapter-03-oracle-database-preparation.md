# Chapter 3 — Prepare Oracle Databases for GoldenGate 26ai

**Scope:** Oracle-to-Oracle replication preparation, with version-specific logging, identity and supplemental logging requirements. Commands are reference procedures; record execution and validation separately.

## Scope and acceptance criteria

- Confirm CDB/root versus PDB configuration and privileges.
- Diagnose role, open mode, logging, database identity, keys and GoldenGate settings with read-only SQL.
- Explain why Extract needs archived redo, supplemental identification columns and an appropriate capture account.
- Compare minimal/subset database logging, table logging, and schema logging.
- Plan least-privilege GoldenGate administration and credential aliases.
- Document changes, rollback considerations and postchange evidence.

## 1. How the Oracle database and GoldenGate fit together

The source Oracle database generates redo; a configured Extract captures eligible changes and writes trails. GoldenGate depends on compatible database mode, redo availability, adequate supplemental identification columns, privileges, and a planned extraction position. A target database needs the appropriate Replicat connectivity, permissions and object definitions; it does not necessarily require identical capture-side logging unless replication may reverse or that feature requires it.

**Oracle documentation:** GoldenGate 26ai guidance distinguishes database-level minimal/subset replication logging and schema/table logging; not every environment should turn on unconditional ALL-column logging. [Oracle: Transaction Log Settings and Requirements](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/prepare-transaction-logs-settings-and-requirements-ogg-oracle.html).

## 2. Identify the execution context BEFORE a change

Run SQL*Plus or SQLcl as a suitably privileged user in the **intended** database. For CDB-level commands, confirm the session is at `CDB$ROOT` and that this source or target is the approved environment.

```sql
-- READ ONLY: current container and database
SHOW CON_NAME;
SHOW USER;
SELECT name, db_unique_name, database_role, open_mode, log_mode,
       force_logging, supplemental_log_data_min
FROM v$database;
SHOW PARAMETER enable_goldengate_replication;

-- From a suitable CDB administrative session:
SELECT con_id, name, open_mode FROM v$pdbs ORDER BY con_id;
```

**Interpretation:** `LOG_MODE` addresses redo archiving; `FORCE_LOGGING` is a separate protection; `SUPPLEMENTAL_LOG_DATA_MIN` does not alone prove table/schema row-key logging; `enable_goldengate_replication` is a separate initialization parameter. Do not mistake a successful database connection for sufficient GoldenGate capture privileges.

## 3. Check object keys and log groups

```sql
-- In the appropriate PDB, use the planned schema in place of APP_SCHEMA.
SELECT owner, table_name, constraint_name, constraint_type, status
FROM dba_constraints
WHERE owner = 'APP_SCHEMA'
  AND constraint_type IN ('P','U')
ORDER BY table_name, constraint_type;

SELECT owner, table_name, log_group_name, log_group_type, always
FROM dba_log_groups
WHERE owner = 'APP_SCHEMA'
ORDER BY table_name, log_group_name;

SELECT owner, table_name, log_group_name, column_name, position
FROM dba_log_group_columns
WHERE owner = 'APP_SCHEMA'
ORDER BY table_name, log_group_name, position;
```

**Why:** Replicat needs a reliable way to locate target rows for updates/deletes. The selected logging level should account for primary/unique key definitions, filtering, transformations, conflict handling and integrated Replicat scheduling requirements. Some objects without a usable key need deliberate key/mapping design.

**Expected result:** Real key and log-group metadata for the selected schema. No fabricated output is provided.

## 4. ARCHIVELOG and forced logging

Changing the database's ARCHIVELOG mode may require an outage and coordination with RMAN backups, standby databases, and recovery objectives. Inspect the current mode first; schedule any mode change as a separate approved database operation.

```sql
-- READ ONLY
ARCHIVE LOG LIST;
SELECT log_mode, force_logging FROM v$database;
```

Oracle 26ai documentation strongly recommends forced logging for GoldenGate source use cases and documents the associated change:

```sql
-- CHANGE-CONTROLLED; do not execute without approval and impact analysis
ALTER DATABASE FORCE LOGGING;
```

Assess redo volume, bulk-load performance, standby behavior and maintenance plan first. Changing a database into ARCHIVELOG mode requires a separate, environment-specific DBA runbook with recovery/backup validation.

## 5. Enable GoldenGate replication capability

reference examples records:

```sql
ALTER SYSTEM SET enable_goldengate_replication = TRUE;
```

Oracle's 26ai getting-started guidance also recommends enabling this initialization parameter on the appropriate source/target/standby scope; one documented example is:

```sql
-- CHANGE-CONTROLLED, scope and SID chosen for the actual database topology
ALTER SYSTEM SET enable_goldengate_replication=TRUE SCOPE=BOTH SID='*';
```

**Where:** privileged database administration session on the intended instance/CDB. **Why:** enables database functionality used by GoldenGate capture/apply. **Validation:** `SHOW PARAMETER enable_goldengate_replication` in the relevant context; confirm instance scope and parameter persistence. Do not copy `SID='*'` into a nonmatching topology by rote.

Reference: [Oracle 26ai — Configure Source and Target Databases](https://docs.oracle.com/en/database/goldengate/core/26/ggmah/task-1-configure-source-and-target-databases.html).

## 6. Supplemental logging: choose the minimum appropriate scope

Redo ordinarily records the changes necessary for Oracle recovery, not necessarily all unchanged key columns required for downstream logical apply. Supplemental logging adds useful identifying/scheduling columns. The added redo can affect I/O, archiving and downstream retention requirements.

**Read-only check:**

```sql
SELECT supplemental_log_data_min, force_logging FROM v$database;
```

**Database-level change (illustrative, authorization required):**

```sql
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
```

**Version nuance:** Oracle 26ai also documents subset database replication logging, including a PDB-scoped example. Determine the supported option for the actual source database and container before choosing between older minimal logging syntax and subset replication logging. These are **alternatives dictated by environment**, not commands to run blindly in sequence.

**Table-level GoldenGate command after an authenticated DBLOGIN (illustrative):**

```text
ADD TRANDATA pdb1.app_schema.orders
INFO TRANDATA pdb1.app_schema.orders
```

**Schema-level alternative (illustrative):**

```text
ADD SCHEMATRANDATA pdb1.app_schema
INFO SCHEMATRANDATA pdb1.app_schema
```

Oracle recommends schema-level logging in many cases because it also covers newly created schema objects, and specifically describes its relevance for DDL replication. Conversely, choose targeted table-level logging when appropriately scoped and supported. **Never assume `ALLCOLS` is universally required**; extra logging has real resource cost.

Admin Client/web service connection and syntax must correspond to the actual GoldenGate deployment, database alias and release. [Oracle: ADD TRANDATA](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-trandata.html); [Oracle: Prerequisites before Extract/Replicat](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/configure-ogg-adding-extract-and-replicat.html).

## 7. GoldenGate database account design and privileges

A common user may be needed for particular CDB-wide capture topologies; privilege procedures depend on the database release. Do not grant `DBA` simply to make capture work. For supported earlier Oracle releases, review `DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE`; Oracle AI Database 26ai uses its documented `OGG_CAPTURE`/`OGG_APPLY` model instead.

Plan these identities individually:

| Identity | Function | Boundary |
|---|---|---|
| Linux GoldenGate installation user | Owns software/runtime as approved | Operating system |
| GoldenGate service administrator | Manages Microservices deployment and access | GoldenGate service authentication |
| Source GoldenGate database account | Capture/registration, logging administration as needed | Source Oracle database/CDB/PDB |
| Target GoldenGate database account | Replicat connection, required apply capabilities | Target Oracle database/CDB/PDB |
| Application schema user | Owns replicated application tables | Individual Oracle schema/PDB |

Use release-appropriate **Oracle-supported** privilege-granting procedures and least privilege. The exact `GRANT_ADMIN_PRIVILEGE` procedure options depend on capture/apply roles, multitenant layout and Oracle release. **Do not invent a universal executable C## user-creation script here.**

Before authoring the change request, document: account name, container(s), password/wallet policy, target grants, object ownership, quota/tablespace needs, and which process actually needs each permission. Capture a sanitized DBA review and verify the resulting access without publishing passwords.

Reference: [Oracle — Configure Source/Target and Replication Administrator](https://docs.oracle.com/en/database/goldengate/core/26/ggmah/task-1-configure-source-and-target-databases.html).

## 8. Credential aliases and connection validation

Create the approved database credential under Administration Service **DB Connections**. This separates a reusable alias from repeated plaintext passwords in process configuration.

Example of a **nonsecret** Admin Client pattern:

```text
DBLOGIN USERIDALIAS gg_source
```

`gg_source` is a placeholder alias. Configure a supported DB Connection/credential store first; verify that it connects to the **intended** source or target PDB service and carries the intended permissions. Do not put `PASSWORD ...` in a public runbook, shell transcript or GitHub file.

## 9. Integrated Extract readiness

Use this read-only capture inventory query after connecting to the intended database:

```sql
SELECT capture_name FROM dba_capture;
```

It helps inspect database-side registered capture processes, but a zero-row result before Extract registration is not itself a failure. Verification after setup should also cover registered capture state, the intended PDB/source scope, process checkpoints, logging, correct trail path and successful DML on replicated tables. No Extract has been created by following this chapter.

## 10. Validation procedure

**Scenario:** Two Oracle multitenant databases will replicate changes from an application schema in a source PDB to a target PDB. The engineer must prepare an approval package *without changing anything*.

1. Record `SHOW CON_NAME`, `SHOW USER`, database role, log mode, forced/minimal logging and GoldenGate parameter values.
2. Inventory primary/unique constraints for two source tables.
3. Inspect supplemental log groups and identify missing key columns.
4. Recommend *one* logging strategy (schema or table), explaining the reason and expected redo overhead.
5. Specify separate source capture and target apply accounts and the privileges each needs.
6. Write a validation plan for connection, registrations, logging coverage, trail generation, apply and row-level reconciliation.
7. Mark all SQL-changing commands as **pending authorization**. Do not execute them as part of this read-only exercise.

**Verification points:** ARCHIVELOG concerns archived redo availability, while supplemental logging provides row identification; container context controls the scope of configuration and grants; DBA_CAPTURE registration alone does not demonstrate target correctness; schema-level logging may cover newly created tables when appropriately configured.

## 11. Validation and evidence standard

| Requirement | Status |
|---|---|
| Reference materials | Oracle documentation linked below |
| Oracle 26ai logging options cross-checked | Yes — vendor reference |
| Read-only SQL examples | Available; run and retain results in the lab |
| Vendor-appropriate account grant plan drafted | Incomplete pending chosen topology |
| ARCHIVELOG change tested in lab | Not tested |
| Supplemental logging enabled and validated on a lab source | Not tested |
| DB credential aliases verified against actual PDB | Not tested |
| Integrated Extract / Replicat running and data reconciled | Not part of this chapter |

A reader must never infer a completed database change or production-ready pipeline solely from this chapter.

## References

- [Oracle 26ai Transaction Log Settings and Requirements](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/prepare-transaction-logs-settings-and-requirements-ogg-oracle.html)
- [Oracle 26ai Configure Source and Target Databases](https://docs.oracle.com/en/database/goldengate/core/26/ggmah/task-1-configure-source-and-target-databases.html)
- [Oracle 26ai ADD TRANDATA Reference](https://docs.oracle.com/en/database/goldengate/core/26/gclir/add-trandata.html)
- [Oracle 26ai Before Adding Extract and Replicat](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/configure-ogg-adding-extract-and-replicat.html)

**Next chapter:** Administration Service, credential configuration, Integrated Extract registration and source trails with process parameters, actual validation and troubleshooting.
