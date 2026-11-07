// FHIR R4 ConceptMap: target.equivalence (R5 renamed it relationship).
// R4 reads from the target's side: `wider` is R5 source-is-narrower-than-target,
// `narrower` is R5 source-is-broader-than-target.
RuleSet: ElementMap(source, target, equivalence)
* element[+]
  * code = #{source}
  * target[+]
    * code = #{target}
    * equivalence = #{equivalence}
