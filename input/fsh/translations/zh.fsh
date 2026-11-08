// Simplified Chinese (zh) display designations for this IG's code systems,
// as FHIR CodeSystem supplements (content = supplement): FHIR's own
// translation mechanism, one file per locale, no edit to the base code systems.
// UNOFFICIAL: drafted by an agent; no human has signed it off. Codes and
// acronyms are kept as written; ICVP terms follow WHO's Chinese IHR (2005).

CodeSystem: DVCRelationshipStatusZh
Id: DVCRelationshipStatus-zh
Title: "DVCRelationshipStatus — Chinese (zh) supplement"
Description: "Unofficial Simplified Chinese (zh) display designations for the DVCRelationshipStatus code system, drafted by an agent and not signed off by a human."
* ^experimental = true
* ^status = #draft
* ^language = #zh
* ^content = #supplement
* ^supplements = Canonical(DVCRelationshipStatus)
* #Parent
* #Parent ^designation[+].language = #zh
* #Parent ^designation[=].value = "父母"
* #Guardian
* #Guardian ^designation[+].language = #zh
* #Guardian ^designation[=].value = "监护人"

CodeSystem: DisclosureStatementsZh
Id: DisclosureStatements-zh
Title: "DisclosureStatements — Chinese (zh) supplement"
Description: "Unofficial Simplified Chinese (zh) display designations for the DisclosureStatements code system, drafted by an agent and not signed off by a human."
* ^experimental = true
* ^status = #draft
* ^language = #zh
* ^content = #supplement
* ^supplements = Canonical(DisclosureStatements)
* #disclose-icvp
* #disclose-icvp ^designation[+].language = #zh
* #disclose-icvp ^designation[=].value = "披露 ICVP"
* #disclose-icvp-narrative
* #disclose-icvp-narrative ^designation[+].language = #zh
* #disclose-icvp-narrative ^designation[=].value = "披露 ICVP 叙述"
* #disclose-icvp-demographic
* #disclose-icvp-demographic ^designation[+].language = #zh
* #disclose-icvp-demographic ^designation[=].value = "披露 ICVP 人口统计学叙述的完整详情"
* #disclose-icvp-demographic-narrative
* #disclose-icvp-demographic-narrative ^designation[+].language = #zh
* #disclose-icvp-demographic-narrative ^designation[=].value = "披露 ICVP 人口统计学叙述"
* #disclose-icvp-demographic-name
* #disclose-icvp-demographic-name ^designation[+].language = #zh
* #disclose-icvp-demographic-name ^designation[=].value = "披露姓名"
* #disclose-icvp-demographic-sex
* #disclose-icvp-demographic-sex ^designation[+].language = #zh
* #disclose-icvp-demographic-sex ^designation[=].value = "披露性别"
* #disclose-icvp-demographic-dob
* #disclose-icvp-demographic-dob ^designation[+].language = #zh
* #disclose-icvp-demographic-dob ^designation[=].value = "披露出生日期"
* #disclose-icvp-demographic-nationality
* #disclose-icvp-demographic-nationality ^designation[+].language = #zh
* #disclose-icvp-demographic-nationality ^designation[=].value = "披露国籍"
* #disclose-icvp-demographic-national-id
* #disclose-icvp-demographic-national-id ^designation[+].language = #zh
* #disclose-icvp-demographic-national-id ^designation[=].value = "披露国民身份证件号码（ID）"
* #disclose-icvp-vaccination
* #disclose-icvp-vaccination ^designation[+].language = #zh
* #disclose-icvp-vaccination ^designation[=].value = "披露 ICVP 疫苗接种"
* #disclose-icvp-vaccination-narrative
* #disclose-icvp-vaccination-narrative ^designation[+].language = #zh
* #disclose-icvp-vaccination-narrative ^designation[=].value = "披露 ICVP 疫苗接种叙述"
* #disclose-icvp-vaccination-clinician
* #disclose-icvp-vaccination-clinician ^designation[+].language = #zh
* #disclose-icvp-vaccination-clinician ^designation[=].value = "披露临床医生姓名"
* #disclose-icvp-vaccination-issuer
* #disclose-icvp-vaccination-issuer ^designation[+].language = #zh
* #disclose-icvp-vaccination-issuer ^designation[=].value = "披露签发方"

CodeSystem: DocumentationSectionsZh
Id: DocumentationSections-zh
Title: "DocumentationSections — Chinese (zh) supplement"
Description: "Unofficial Simplified Chinese (zh) display designations for the DocumentationSections code system, drafted by an agent and not signed off by a human."
* ^experimental = true
* ^status = #draft
* ^language = #zh
* ^content = #supplement
* ^supplements = Canonical(DocumentationSections)
* #request-trigger
* #request-trigger ^designation[+].language = #zh
* #request-trigger ^designation[=].value = "请求触发事件"
* #request-semantics
* #request-semantics ^designation[+].language = #zh
* #request-semantics ^designation[=].value = "请求消息语义"
* #request-actions
* #request-actions ^designation[+].language = #zh
* #request-actions ^designation[=].value = "请求预期操作"
* #response-trigger
* #response-trigger ^designation[+].language = #zh
* #response-trigger ^designation[=].value = "响应触发事件"
* #response-semantics
* #response-semantics ^designation[+].language = #zh
* #response-semantics ^designation[=].value = "响应消息语义"
* #response-actions
* #response-actions ^designation[+].language = #zh
* #response-actions ^designation[=].value = "响应预期操作"
* #security-considerations
* #security-considerations ^designation[+].language = #zh
* #security-considerations ^designation[=].value = "安全考虑"

CodeSystem: HLTYPEZh
Id: HL.TYPE-zh
Title: "HL.TYPE — Chinese (zh) supplement"
Description: "Unofficial Simplified Chinese (zh) display designations for the HL.TYPE code system, drafted by an agent and not signed off by a human."
* ^experimental = true
* ^status = #draft
* ^language = #zh
* ^content = #supplement
* ^supplements = Canonical(HL.TYPE)
* #vhl
* #vhl ^designation[+].language = #zh
* #vhl ^designation[=].value = "可验证健康链接"
* #shl
* #shl ^designation[+].language = #zh
* #shl ^designation[=].value = "智能健康链接"

CodeSystem: ICVPCoreZh
Id: ICVP.Core-zh
Title: "ICVP.Core — Chinese (zh) supplement"
Description: "Unofficial Simplified Chinese (zh) display designations for the ICVP.Core code system, drafted by an agent and not signed off by a human."
* ^experimental = true
* ^status = #draft
* ^language = #zh
* ^content = #supplement
* ^supplements = Canonical(ICVP.Core)
* #ICVP.A9.DE.1
* #ICVP.A9.DE.1 ^designation[+].language = #zh
* #ICVP.A9.DE.1 ^designation[=].value = "疫苗接种或预防措施接受者姓名"
* #ICVP.A9.DE.2
* #ICVP.A9.DE.2 ^designation[+].language = #zh
* #ICVP.A9.DE.2 ^designation[=].value = "出生日期"
* #ICVP.A9.DE.3
* #ICVP.A9.DE.3 ^designation[+].language = #zh
* #ICVP.A9.DE.3 ^designation[=].value = "性别"
* #ICVP.A9.DE.4
* #ICVP.A9.DE.4 ^designation[+].language = #zh
* #ICVP.A9.DE.4 ^designation[=].value = "男"
* #ICVP.A9.DE.5
* #ICVP.A9.DE.5 ^designation[+].language = #zh
* #ICVP.A9.DE.5 ^designation[=].value = "女"
* #ICVP.A9.DE.6
* #ICVP.A9.DE.6 ^designation[+].language = #zh
* #ICVP.A9.DE.6 ^designation[=].value = "其他"
* #ICVP.A9.DE.7
* #ICVP.A9.DE.7 ^designation[+].language = #zh
* #ICVP.A9.DE.7 ^designation[=].value = "未知"
* #ICVP.A9.DE.8
* #ICVP.A9.DE.8 ^designation[+].language = #zh
* #ICVP.A9.DE.8 ^designation[=].value = "国籍"
* #ICVP.A9.DE.9
* #ICVP.A9.DE.9 ^designation[+].language = #zh
* #ICVP.A9.DE.9 ^designation[=].value = "国民身份证件（如适用）"
* #ICVP.A9.DE.10
* #ICVP.A9.DE.10 ^designation[+].language = #zh
* #ICVP.A9.DE.10 ^designation[=].value = "父母或监护人姓名"
* #ICVP.C5.DE.11
* #ICVP.C5.DE.11 ^designation[+].language = #zh
* #ICVP.C5.DE.11 ^designation[=].value = "疫苗或预防措施"
* #ICVP.C5.DE.12
* #ICVP.C5.DE.12 ^designation[+].language = #zh
* #ICVP.C5.DE.12 ^designation[=].value = "疾病或病症名称"
* #ICVP.C5.DE.13
* #ICVP.C5.DE.13 ^designation[+].language = #zh
* #ICVP.C5.DE.13 ^designation[=].value = "日期"
* #ICVP.C5.DE.14
* #ICVP.C5.DE.14 ^designation[+].language = #zh
* #ICVP.C5.DE.14 ^designation[=].value = "监督临床医生姓名"
* #ICVP.C5.DE.15
* #ICVP.C5.DE.15 ^designation[+].language = #zh
* #ICVP.C5.DE.15 ^designation[=].value = "负责签发本证书的相关主管机关"
* #ICVP.C5.DE.16
* #ICVP.C5.DE.16 ^designation[+].language = #zh
* #ICVP.C5.DE.16 ^designation[=].value = "疫苗或预防措施的生产商"
* #ICVP.C5.DE.17
* #ICVP.C5.DE.17 ^designation[+].language = #zh
* #ICVP.C5.DE.17 ^designation[=].value = "疫苗或预防措施的批号"
* #ICVP.C5.DE.18
* #ICVP.C5.DE.18 ^designation[+].language = #zh
* #ICVP.C5.DE.18 ^designation[=].value = "批号（字符串）"
* #ICVP.C5.DE.19
* #ICVP.C5.DE.19 ^designation[+].language = #zh
* #ICVP.C5.DE.19 ^designation[=].value = "批号（编码）"
* #ICVP.D5.DE.20
* #ICVP.D5.DE.20 ^designation[+].language = #zh
* #ICVP.D5.DE.20 ^designation[=].value = "证书生效日期"
* #ICVP.D5.DE.21
* #ICVP.D5.DE.21 ^designation[+].language = #zh
* #ICVP.D5.DE.21 ^designation[=].value = "证书有效期至"
* #ICVP.D5.DE.22
* #ICVP.D5.DE.22 ^designation[+].language = #zh
* #ICVP.D5.DE.22 ^designation[=].value = "证书有效期至（字符串）"
* #ICVP.D5.DE.23
* #ICVP.D5.DE.23 ^designation[+].language = #zh
* #ICVP.D5.DE.23 ^designation[=].value = "证书有效期至（日期）"
* #ICVP.D5.DE.24
* #ICVP.D5.DE.24 ^designation[+].language = #zh
* #ICVP.D5.DE.24 ^designation[=].value = "附件 6 中 ICVP 示范格式表格后的文字"
* #ICVP.D5.DE.25
* #ICVP.D5.DE.25 ^designation[+].language = #zh
* #ICVP.D5.DE.25 ^designation[=].value = "签发方的密码学签名"
* #ICVP.D5.DE.26
* #ICVP.D5.DE.26 ^designation[+].language = #zh
* #ICVP.D5.DE.26 ^designation[=].value = "用于签名验证的密钥标识符"
* #ICVP.D5.DE.27
* #ICVP.D5.DE.27 ^designation[+].language = #zh
* #ICVP.D5.DE.27 ^designation[=].value = "版本"
