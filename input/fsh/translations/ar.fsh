// Arabic (ar) CodeSystem supplements for this IG's own CodeSystems.
// Agent translation, UNOFFICIAL and unreviewed: no human sign-off. One file per locale;
// the CodeSystems themselves are not edited. Displays and definitions mirror translations/ar/.

CodeSystem: DVCRelationshipStatusAr
Id: DVCRelationshipStatus-ar
Title: "حالة العلاقة بجهة الاتصال لدى المريض"
Description: "ملحق باللغة العربية (ar) لنظام الرموز DVCRelationshipStatus: تسميات كل مفهوم. ترجمة غير رسمية أعدّها وكيل آلي، دون مراجعة بشرية."
* ^status = #draft
* ^experimental = true
* ^content = #supplement
* ^supplements = Canonical(DVCRelationshipStatus)
* ^language = #ar
* ^caseSensitive = true
* #Parent "أحد الوالدين"
  * ^designation[0].language = #ar
  * ^designation[0].value = "أحد الوالدين"
* #Guardian "الوصي"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الوصي"

CodeSystem: DisclosureStatementsAr
Id: DisclosureStatements-ar
Title: "بيانات الإفصاح"
Description: "ملحق باللغة العربية (ar) لنظام الرموز DisclosureStatements: تسميات كل مفهوم. ترجمة غير رسمية أعدّها وكيل آلي، دون مراجعة بشرية."
* ^status = #draft
* ^experimental = true
* ^content = #supplement
* ^supplements = Canonical(DisclosureStatements)
* ^language = #ar
* ^caseSensitive = true
* #disclose-icvp "الإفصاح عن الشهادة الدولية للتطعيم أو الاتقاء (ICVP)"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن الشهادة الدولية للتطعيم أو الاتقاء (ICVP)"
* #disclose-icvp-narrative "الإفصاح عن السرد النصي للشهادة ICVP"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن السرد النصي للشهادة ICVP"
* #disclose-icvp-demographic "الإفصاح عن التفاصيل الكاملة للسرد النصي للبيانات الديمغرافية في الشهادة ICVP"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن التفاصيل الكاملة للسرد النصي للبيانات الديمغرافية في الشهادة ICVP"
* #disclose-icvp-demographic-narrative "الإفصاح عن السرد النصي للبيانات الديمغرافية في الشهادة ICVP"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن السرد النصي للبيانات الديمغرافية في الشهادة ICVP"
* #disclose-icvp-demographic-name "الإفصاح عن الاسم"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن الاسم"
* #disclose-icvp-demographic-sex "الإفصاح عن الجنس"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن الجنس"
* #disclose-icvp-demographic-dob "الإفصاح عن تاريخ الميلاد"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن تاريخ الميلاد"
* #disclose-icvp-demographic-nationality "الإفصاح عن الجنسية"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن الجنسية"
* #disclose-icvp-demographic-national-id "الإفصاح عن رقم الهوية الوطنية"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن رقم الهوية الوطنية"
* #disclose-icvp-vaccination "الإفصاح عن بيانات التطعيم في الشهادة ICVP"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن بيانات التطعيم في الشهادة ICVP"
* #disclose-icvp-vaccination-narrative "الإفصاح عن السرد النصي للتطعيم في الشهادة ICVP"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن السرد النصي للتطعيم في الشهادة ICVP"
* #disclose-icvp-vaccination-clinician "الإفصاح عن اسم الممارس السريري"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن اسم الممارس السريري"
* #disclose-icvp-vaccination-issuer "الإفصاح عن الجهة المُصدِرة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإفصاح عن الجهة المُصدِرة"

CodeSystem: DocumentationSectionsAr
Id: DocumentationSections-ar
Title: "قسم توثيق إرشادات SMART"
Description: "ملحق باللغة العربية (ar) لنظام الرموز DocumentationSections: تسميات كل مفهوم. ترجمة غير رسمية أعدّها وكيل آلي، دون مراجعة بشرية."
* ^status = #draft
* ^experimental = true
* ^content = #supplement
* ^supplements = Canonical(DocumentationSections)
* ^language = #ar
* ^caseSensitive = true
* #request-trigger "الأحداث المُطلِقة للطلب"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الأحداث المُطلِقة للطلب"
* #request-semantics "دلالات رسالة الطلب"
  * ^designation[0].language = #ar
  * ^designation[0].value = "دلالات رسالة الطلب"
* #request-actions "الإجراءات المتوقعة للطلب"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإجراءات المتوقعة للطلب"
* #response-trigger "الأحداث المُطلِقة للاستجابة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الأحداث المُطلِقة للاستجابة"
* #response-semantics "دلالات رسالة الاستجابة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "دلالات رسالة الاستجابة"
* #response-actions "الإجراءات المتوقعة للاستجابة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإجراءات المتوقعة للاستجابة"
* #security-considerations "الاعتبارات الأمنية"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الاعتبارات الأمنية"

CodeSystem: HLTYPEAr
Id: HL.TYPE-ar
Title: "نظام رموز أنواع الروابط الصحية (HL)"
Description: "ملحق باللغة العربية (ar) لنظام الرموز HL.TYPE: تسميات كل مفهوم. ترجمة غير رسمية أعدّها وكيل آلي، دون مراجعة بشرية."
* ^status = #draft
* ^experimental = true
* ^content = #supplement
* ^supplements = Canonical(HL.TYPE)
* ^language = #ar
* ^caseSensitive = true
* #vhl "رابط صحي قابل للتحقق"
  * ^designation[0].language = #ar
  * ^designation[0].value = "رابط صحي قابل للتحقق"
* #shl "رابط SMART Health Link"
  * ^designation[0].language = #ar
  * ^designation[0].value = "رابط SMART Health Link"

CodeSystem: ICVPCoreAr
Id: ICVP.Core-ar
Title: "نظام الرموز ICVP.Core لعناصر البيانات"
Description: "ملحق باللغة العربية (ar) لنظام الرموز ICVP.Core: تسميات كل مفهوم. ترجمة غير رسمية أعدّها وكيل آلي، دون مراجعة بشرية."
* ^status = #draft
* ^experimental = true
* ^content = #supplement
* ^supplements = Canonical(ICVP.Core)
* ^language = #ar
* ^caseSensitive = true
* #ICVP.A9.DE.1 "اسم متلقي اللقاح أو الاتقاء"
  * ^designation[0].language = #ar
  * ^designation[0].value = "اسم متلقي اللقاح أو الاتقاء"
* #ICVP.A9.DE.2 "تاريخ الميلاد"
  * ^designation[0].language = #ar
  * ^designation[0].value = "تاريخ الميلاد"
* #ICVP.A9.DE.3 "الجنس"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الجنس"
* #ICVP.A9.DE.4 "ذكر"
  * ^designation[0].language = #ar
  * ^designation[0].value = "ذكر"
* #ICVP.A9.DE.5 "أنثى"
  * ^designation[0].language = #ar
  * ^designation[0].value = "أنثى"
* #ICVP.A9.DE.6 "آخر"
  * ^designation[0].language = #ar
  * ^designation[0].value = "آخر"
* #ICVP.A9.DE.7 "غير معروف"
  * ^designation[0].language = #ar
  * ^designation[0].value = "غير معروف"
* #ICVP.A9.DE.8 "الجنسية"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الجنسية"
* #ICVP.A9.DE.9 "وثيقة الهوية الوطنية، إن وُجدت"
  * ^designation[0].language = #ar
  * ^designation[0].value = "وثيقة الهوية الوطنية، إن وُجدت"
* #ICVP.A9.DE.10 "اسم أحد الوالدين أو الوصي"
  * ^designation[0].language = #ar
  * ^designation[0].value = "اسم أحد الوالدين أو الوصي"
* #ICVP.C5.DE.11 "اللقاح أو الاتقاء"
  * ^designation[0].language = #ar
  * ^designation[0].value = "اللقاح أو الاتقاء"
* #ICVP.C5.DE.12 "اسم المرض أو الحالة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "اسم المرض أو الحالة"
* #ICVP.C5.DE.13 "التاريخ"
  * ^designation[0].language = #ar
  * ^designation[0].value = "التاريخ"
* #ICVP.C5.DE.14 "اسم الممارس السريري المشرف"
  * ^designation[0].language = #ar
  * ^designation[0].value = "اسم الممارس السريري المشرف"
* #ICVP.C5.DE.15 "السلطة المعنية المسؤولة عن إصدار هذه الشهادة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "السلطة المعنية المسؤولة عن إصدار هذه الشهادة"
* #ICVP.C5.DE.16 "الشركة المصنِّعة للقاح أو الاتقاء"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الشركة المصنِّعة للقاح أو الاتقاء"
* #ICVP.C5.DE.17 "رقم دفعة اللقاح أو الاتقاء"
  * ^designation[0].language = #ar
  * ^designation[0].value = "رقم دفعة اللقاح أو الاتقاء"
* #ICVP.C5.DE.18 "رقم الدفعة (نص)"
  * ^designation[0].language = #ar
  * ^designation[0].value = "رقم الدفعة (نص)"
* #ICVP.C5.DE.19 "رقم الدفعة (مُرمَّز)"
  * ^designation[0].language = #ar
  * ^designation[0].value = "رقم الدفعة (مُرمَّز)"
* #ICVP.D5.DE.20 "الشهادة صالحة من"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الشهادة صالحة من"
* #ICVP.D5.DE.21 "الشهادة صالحة حتى"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الشهادة صالحة حتى"
* #ICVP.D5.DE.22 "الشهادة صالحة حتى (نص)"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الشهادة صالحة حتى (نص)"
* #ICVP.D5.DE.23 "الشهادة صالحة حتى (تاريخ)"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الشهادة صالحة حتى (تاريخ)"
* #ICVP.D5.DE.24 "النص الذي يلي الجدول في نموذج الشهادة ICVP في المرفق 6"
  * ^designation[0].language = #ar
  * ^designation[0].value = "النص الذي يلي الجدول في نموذج الشهادة ICVP في المرفق 6"
* #ICVP.D5.DE.25 "التوقيع التشفيري للجهة المُصدِرة"
  * ^designation[0].language = #ar
  * ^designation[0].value = "التوقيع التشفيري للجهة المُصدِرة"
* #ICVP.D5.DE.26 "معرِّف المفتاح للتحقق من التوقيع"
  * ^designation[0].language = #ar
  * ^designation[0].value = "معرِّف المفتاح للتحقق من التوقيع"
* #ICVP.D5.DE.27 "الإصدار"
  * ^designation[0].language = #ar
  * ^designation[0].value = "الإصدار"
