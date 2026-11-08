Security and privacy are part of each process in this guide, not a separate layer:

- **Consent is enforced where the data is held.** The VHL Sharer enforces the consent in its own Consent Registry (IHE PCF `[ITI-108]`). A copy of a consent carried inside a document is evidence only. See [Process A](business-processes.html#a-record-and-manage-patient-privacy-consent) and [Process C](business-processes.html#c-present-and-redeem-verifiable-health-link-with-pcf-consent-enforcement).
- **No silent permit.** A consent decision is `permit`, `deny` or `unknown`. A missing, expired or unreachable consent never gives `permit`.
- **Trust is checked against a Trust Anchor.** Signatures on links and certificates are verified against the trust list of an abstract Trust Anchor (`[ITI-YY2]`). The guide does not depend on one particular anchor.
- **Decisions are recorded.** Each access decision is recorded as W3C PROV-O provenance that cites `Consent.id` and `Consent.meta.versionId`. [Process G](business-processes.html#g-audit-provenance-and-duty-checks-under-a-data-sharing-agreement) covers audit under a data sharing agreement.
- **Revocation.** [Process H](business-processes.html#h-revocation-and-suspension-under-a-data-sharing-agreement) covers revoking and suspending access.
