<div>
<p>This implementation guide is still being developed. Its content is for demonstration purposes only.</p>
</div>{:.stu-note}

### Summary

This implementation guide specifies how a **Personal Health Wallet (PHW)** lets a person record privacy consent, share health information through verifiable health links, and have that consent enforced when the information is used. It uses **IHE Privacy Consent on FHIR (PCF) 1.1.0** for consent directives and **IHE Verifiable Health Links (VHL) 1.0.0-comment** for the links.

Every process is **trust-anchor neutral**: keys are published to, and trust lists read from, an abstract Trust Anchor. The WHO Global Digital Health Certification Network (GDHCN) is one possible Trust Anchor among others. The guide makes no claim of conformance to IHE Internet User Authorization (IUA).

Supporting guidance, recommendations, resources and standards are listed in the <a href="en/folio-assistant-core/bibliography/">Bibliography</a> and on the <a href="dependencies.html">Dependencies</a> page.

### What this guide contains

- <a href="business-processes.html">Business Processes</a>: eleven BPMN 2.0 processes:
  - Consent and verifiable health links: A record and manage consent, B issue a consent-backed link, C present and redeem a link.
  - Data sharing agreements between servers: D register a client, E server-to-server access, F access decision, G audit and provenance, H revocation and suspension, I decide a link request under an agreement.
  - Shared certificate processes: J issue a certificate, K verify a certificate and its status.
- <a href="decision-logic.html">Decision-support Logic</a>: the DMN decision `PHW.DT.AgreementAccess`, which combines several agreements for one receiver.
- <a href="example-pilgrimage.html">Worked Example: IPS Pilgrimage (Hajj)</a>: processes A, B, C, F and I applied to one case.
- <a href="system-actors.html">System Actors</a>, <a href="sequence-diagrams.html">Sequence Diagrams</a> and <a href="transactions.html">Transactions</a>.
- The logical models, profiles, value sets and examples are listed in the [Artifact Index](artifacts.html). An offline copy of the guide is on the [Downloads](downloads.html) page.

### How this guide is organised

This guide follows the [levels of knowledge representation](https://hl7.org/fhir/uv/cpg/documentation-approach-06-01-levels-of-knowledge-representation.html):

- <a href="business-requirements.html">Business Requirements</a>: concepts, personas, business processes and decision logic.
- <a href="data-models-and-exchange.html">Data Models and Exchange</a>: actors, sequence diagrams, transactions and codings.
- <a href="deployment.html">Deployment</a>: security and privacy, testing, reference implementations and downloads.

### Disclaimer

This specification is a working draft for demonstration and may not be used for any implementation purposes. It is provided without warranty of completeness or consistency, and the official publication supersedes it. No liability can be inferred from the use or misuse of this specification or its consequences.

### Dependencies

{% include dependency-table-short.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
