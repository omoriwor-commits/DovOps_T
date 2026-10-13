# Chapter 1 — Oracle GoldenGate Architecture, Deployment Models and Technical Prerequisites

> **Reference scope:** Vendor documentation and illustrative configurations. Executed changes require separately retained logs and validation evidence.
> **Scope:** Oracle GoldenGate 26ai Microservices Architecture (MA), with comparisons to Classic Architecture and user-documented Oracle migration labs.  

## Learning outcomes

At the end of the lesson, a learner should be able to:

1. Describe the problem GoldenGate solves and distinguish logical CDC replication from physical standby recovery.
2. Trace a committed change through **Extract → trail → Distribution Service → Receiver Service → trail → Replicat**.
3. Identify the administrative responsibility of Service Manager, Administration Service, Distribution Service, Receiver Service, Performance Metrics Service and Admin Client.
4. Compare local capture, remote capture, local apply, remote apply and hub arrangements.
5. Explain the effect of multitenant databases, supplemental logging, network paths, privileges, storage and instantiation strategy on a deployment design.
6. Gather a **read-only** baseline safely before changing a source or target database.
7. Specify what evidence would establish that a replication design has actually worked.

## 1. What GoldenGate does and does not do

Oracle GoldenGate moves selected database changes between systems. An Extract process captures changes, persists change records to trails, and a Replicat process applies changes to the target according to mapping and apply rules. The design supports logical change data capture, cross-version or cross-platform integration **when the specific source and target combinations are certified**, and planned migration.

It is not itself a substitute for database backups, and it is not equivalent to Data Guard physical redo apply. A GoldenGate pipeline can be **running** while rows are missing, duplicate, filtered, unmapped or delayed. Always verify the destination, not just process uptime.

**Teaching question:** Why might a successful Extract status still leave the target incorrect? Because capture health does not prove transport, apply, correct mapping, instantiation, or data consistency.

## 2. Main replication data flow

```text
  SOURCE ORACLE DB (redo / committed changes)
                  |
                  v
           [EXTRACT process]
                  |
                  v
         [SOURCE LOCAL TRAIL]
                  |
                  v
       [DISTRIBUTION SERVICE]
                  |
           authenticated transport
                  |
                  v
          [RECEIVER SERVICE]
                  |
                  v
         [TARGET LOCAL TRAIL]
                  |
                  v
           [REPLICAT process]
                  |
                  v
            TARGET DATABASE
```

This diagram is a **representative two-deployment configuration**, not a rule that every architecture needs all the depicted services. A single deployment or certain remote-capture/remote-apply designs may place components differently. Classic Architecture commonly uses a data pump and Collector in comparable transport roles. Oracle GoldenGate 26ai also supports configured **Distribution Service Path and Receiver Service Path filters**; filtering may occur at capture, transport or apply. See [Chapter 5](chapter-05-distribution-and-receiver-services.md).

### Transaction walkthrough

Suppose an application commits `UPDATE hr.employees SET salary = ... WHERE employee_id = ...`. At a high level:

1. The source database records the transaction in its redo stream.
2. Extract captures the configured logical changes and writes them into a GoldenGate trail.
3. If transporting between deployments, Distribution reads that source trail and Receiver accepts the stream.
4. Replicat reads the target trail and executes the corresponding target operation under its configured mapping.
5. Validation compares the source and target **after the pipeline has caught up**, accounting for intended transformations and any supported capture/apply limitations.

**Important:** This is a conceptual explanation, not a commitment that every redo record, in-flight transaction or unsupported object operation is processed identically.

## 3. Services and tools: who does what?

| Component | Responsibility | What to inspect when troubleshooting |
|---|---|---|
| Service Manager | Monitors and controls deployment services; manages local deployments | Is the deployment listed? Are its services started? Are ports/configuration correct? |
| Administration Service | Creates, configures, controls and reports on Extract and Replicat; credentials and parameter configuration | Is the process registered, running and on the correct checkpoint? What does its report say? |
| Distribution Service | Transports source trail data using distribution paths | Does the path read the intended source trail, and is it connected? |
| Receiver Service | Handles incoming trails and receiver-side path information | Is the destination receiving and writing the correct trail? |
| Performance Metrics Service | Collects and exposes operational and performance metrics | Are lag, throughput and errors consistent with observed transactions? |
| Admin Client | Command-line administrative interface for Microservices | Are you connected to the intended endpoint/deployment before issuing commands? |
| Extract | Captures configured source changes to a trail | Source registration/logging, read checkpoint and process report |
| Replicat | Applies trail records to a target | Target access, mapping, checkpoint, collision/error reports |

**Terminology:** Oracle 26ai documentation refers to Administration **Service**, Distribution **Service**, Receiver **Service** and Performance Metrics **Service**; training recaps sometimes say *Server*. Preserve the historical wording in original documents but use the 26ai documentation's names in the teaching reference.

**Reference:** [Oracle GoldenGate 26ai — Microservices components](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/overview-components-oracle-goldengate-microservices-architecture.html).

## 4. Classic versus Microservices

| Design attribute | Classic Architecture | Microservices Architecture |
|---|---|---|
| Primary administration | GGSCI, Manager and process utilities | Browser-based service interfaces, REST APIs, Admin Client |
| Replication | Extract/trail/Replicat | Extract/trail/Replicat (under deployment services) |
| Network trail transport | Often data pump / Collector | Distribution Service / Receiver Service |
| Operational considerations | Host-oriented process management | Service/deployment inventory, API-based management, separate service health |

**Do not infer:** Microservices is not restricted to Oracle databases merely because an introductory course slide used Oracle examples. Consult the exact GoldenGate build and support matrix.

## 5. Placement architecture: six teaching patterns

These are **location patterns**; they do not by themselves certify a source/target pair, define network connectivity, or specify the exact number of deployments.

| Pattern | Extract placement | Replicat placement | Typical consideration |
|---|---|---|---|
| 1. Local/local | On source host | On target host | Additional software on both database hosts |
| 2. Local/remote | On source host | Remote connection from source-side host to target DB | Single-host management, network dependency for apply |
| 3. Remote/local | Remote connection to source DB from target-side host | On target host | Reduced GoldenGate software on source; source capture support must be verified |
| 4. Hub remote/remote | Intermediate hub | Same hub | Central administration and concentrated failure domain |
| 5. Hub remote/local | Hub | Target host | Central capture with local target apply |
| 6. Local/hub remote | Source host | Intermediate hub | Local capture, remote apply from hub |

See the separately maintained [six deployment methodologies](../six-deployment-methodologies.md), which contains further trade-offs.

### Historical project vs training example

The separately documented Oracle 19c-to-26ai lab records **remote Integrated Extract** connecting to a 19c source from GoldenGate 26ai and **Integrated Replicat** on the target side. The recorded process names include `EXT19C` and `REP26AI`. Historical DML/DDL success was **reported**, but this chapter does not assert that exact parameter files and comprehensive machine output were preserved.

Source project: [Oracle 19c-to-26ai GoldenGate migration](https://github.com/omoriwor-commits/enterprise-data-platform-labs/tree/main/migrations/oracle-19c-to-26ai-goldengate).

A separate OCI-to-Azure heterogeneous replication lab had working source capture and trail delivery milestones, while **end-to-end SQL Server Replicat apply was not verified**. Never blend these two projects into a single proof.

## 6. Preinstallation design and prerequisite checklist

Before modifying either database, collect and approve the following:

| Layer | Questions to answer | Expected evidence |
|---|---|---|
| Compatibility | What exact Oracle DB, GoldenGate, OS and platform releases are supported together? | Oracle release-specific certification/support references |
| Database topology | Single-tenant vs CDB/PDB; physical/logical source/target? | Database identities, containers, roles and open modes |
| Replication scope | Which schemas/tables, keys, DML and DDL? Any exclusions/LOBs? | Signed-off source/target object inventory |
| Availability | What outage window, recovery objective and fallback? | Approved deployment/cutover plan |
| Logging | Is ARCHIVELOG enabled when required? Are supplemental log groups adequate? | SQL evidence and expected downstream key columns |
| Permissions | Which database credentials and administrative privileges? | Approved minimum-privilege access plan; no public secrets |
| Software directories | Separate installed binary home and writeable runtime/deployment homes? | Filesystem and ownership plan |
| Networking | Source DB/TNS path, GoldenGate service paths, DNS, ports, routing, TLS? | Connectivity tests and firewall approvals |
| Capacity | Redo volume, trail retention, storage, CPU, network throughput? | Measured baseline and headroom estimates |
| Initial load | How are existing rows copied consistently with ongoing capture? | Documented capture/start position and target instantiation design |
| Operations | How will restart, alerting, purge, backups and credential recovery be handled? | Runbook, monitoring and escalation path |

### Read-only discovery exercise (Oracle SQL)

Run this in a **lab** with access to the appropriate CDB root or PDB, noting the exact container and privileges. These are inspection queries, not installation commands.

```sql
-- Identify current container (where supported).
SHOW CON_NAME;

-- Database role and logging.
SELECT name, db_unique_name, database_role, open_mode, log_mode
FROM v$database;

-- Minimal supplemental logging indicator.
SELECT supplemental_log_data_min
FROM v$database;

-- GoldenGate replication initialization parameter.
SHOW PARAMETER enable_goldengate_replication;

-- Multitenant PDB status: run from an appropriate CDB context.
SELECT con_id, name, open_mode
FROM v$pdbs
ORDER BY con_id;
```

**Why:** Configuration and privilege choices differ depending on database role, multitenant context and enabled logging. A working connection string alone does not verify capture support.

**Expected results:** The queries return actual database-specific rows and parameter values; *no fixed example output is fabricated*. Record them in a redacted lab evidence file and stop if privileges are insufficient.

**Do not run yet:** ARCHIVELOG mode changes, force logging, blanket supplemental logging, `DBMS_GOLDENGATE_AUTH`, credential creation or `enable_goldengate_replication` changes until installation, downtime impact and DBA authorization have been reviewed in their own runbooks.

## 7. Operating and teaching principles

- Always differentiate *vendor-documented command*, *instructor sample*, *reconstruction* and *executed lab evidence*.
- Every writable command needs the **host/database, operating account, container, prerequisites, rollback/impact and validation query**.
- Process uptime is not the same thing as replication correctness.
- Network transport, data transformations and source/target keys must be included in the test plan.
- Save a sanitized topology sheet, a release matrix, real outputs and change timestamps. Never publish credentials or proprietary VM handouts.

## 8. Troubleshooting exercise (without changing the system)

**Scenario:** Extract is RUNNING but target data has not changed.

Ask the student to list checks in order:
1. Was the test transaction committed on a table in the Extract capture scope?
2. Is required logging active for that table and is the capture checkpoint advancing?
3. Is the correct local trail receiving new records?
4. Is Distribution reading the same trail and is Receiver writing a target trail?
5. Does Replicat read the correct trail and is it running without apply errors?
6. Do table maps and key columns target the correct database objects?
7. Is there a pending initial-load/instantiation issue or an intentional filter?
8. After catch-up, do source and target rows actually agree?

**Diagnostic response:** Investigate the chain from source to target; the precise failing boundary requires logs, process reports, configuration and transaction evidence. Do not assume that the process marked RUNNING proves successful apply.

## 9. Knowledge check

1. What is a trail file and why does it matter for restart/recovery?
2. Which service manages Extract and Replicat configuration?
3. Can a Distribution Path itself filter trail records?
4. What trade-off arises when remote capture places GoldenGate on the target-side host?
5. What does `ARCHIVELOG` status tell you, and what does it **not** prove about supplemental logging?
6. Why must an initial-load snapshot be coordinated with the replication start point?

**Suggested answers:** Trail persists logical changes between capture and apply; Administration Service manages the processes; Oracle 26ai Distribution Service Paths may filter trail content when path filtering is explicitly configured; remote capture depends on source access/support and network; ARCHIVELOG indicates archived redo behavior but not adequate table-level row identification; an inconsistent snapshot/start boundary can create gaps or duplicate apply.

## 10. Chapter 1 completion checklist

- [ ] Learner can draw a full source-to-target data flow.
- [ ] Learner can explain the five deployment services and Admin Client.
- [ ] Learner can contrast Classic and Microservices administration.
- [ ] Learner can identify a valid topology for an **explicit certified scenario**.
- [ ] Learner has captured read-only database prerequisite outputs.
- [ ] Learner can identify what remains unverified before executing configuration.

## References and provenance

- [Oracle GoldenGate 26ai — Components of Microservices Architecture](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/overview-components-oracle-goldengate-microservices-architecture.html)
- [Oracle GoldenGate 26ai — About Microservices Architecture](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/overview-oracle-goldengate-microservices-architecture.html)
- [Oracle GoldenGate 26ai — Documentation table of contents](https://docs.oracle.com/en/database/goldengate/core/26/coredoc/toc.htm)

**Next chapter:** Installation planning, supported platform checks, filesystem and security model, software installation and Microservices deployment with OGGCA. That chapter must distinguish safely executable checks from deployment-changing commands and document the actual response file before declaring a procedure tested.
