This page lists the decision logic of this guide. Each decision is written in OMG Decision Model and Notation (DMN) 1.3, and names the business process tasks it serves.

| Decision | Serves | What it decides |
| --- | --- | --- |
| [`PHW.DT.AgreementAccess`](business-processes.html#combining-several-agreements-dmn-phwdtagreementaccess) | Process F, task `PHW.F.10` | Whether a receiver gets access when several data sharing agreements, and the person's consent, apply to the same request. |

Consent itself is decided by the three-valued evaluation described in the [business processes](business-processes.html#architectural-principles): `permit`, `deny` or `unknown`. A missing, expired or unreachable consent never gives `permit`.
