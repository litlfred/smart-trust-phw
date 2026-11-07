Instance: ICVP.Core.ConceptMap
InstanceOf: ConceptMap
Description:  "Mapping to and from ICVP.Core Data Dictionary to other code systems."
Usage:        #definition

* name = "ICVP_Core_ConceptMap"
* title = "ConceptMap to and from ICVP.Core Data Elements"
* status = #active
* experimental = false
* date = "2026-04-10"

// ----- Administrative Gender -----
* group[+]
  * source = Canonical(ICVP.Core)
  * target = $GENDER
  * insert ElementMap(ICVP.A9.DE.4, male, equivalent)
  * insert ElementMap(ICVP.A9.DE.5, female, equivalent)
  * insert ElementMap(ICVP.A9.DE.6, other, narrower)
  * insert ElementMap(ICVP.A9.DE.7, unknown, equivalent)
* group[+]
  * source = $GENDER
  * target = Canonical(ICVP.Core)
  * insert ElementMap(male, ICVP.A9.DE.4, equivalent)
  * insert ElementMap(female, ICVP.A9.DE.5, equivalent)
  * insert ElementMap(other, ICVP.A9.DE.6, wider)
  * insert ElementMap(unknown, ICVP.A9.DE.7, equivalent)

// ----- ICD-11 -----
* group[+]
  * source = Canonical(ICVP.Core)
  * target = $ICD11
  * insert ElementMap(ICVP.A9.DE.4, XX2UQ8, equivalent)
  * insert ElementMap(ICVP.A9.DE.5, XX2V25, equivalent)
  * insert ElementMap(ICVP.A9.DE.6, XX45B7, narrower)
  * insert ElementMap(ICVP.A9.DE.7, XX2PX3, equivalent)
* group[+]
  * source = $ICD11
  * target = Canonical(ICVP.Core)
  * insert ElementMap(XX2UQ8, ICVP.A9.DE.4, equivalent)
  * insert ElementMap(XX2V25, ICVP.A9.DE.5, equivalent)
  * insert ElementMap(XX45B7, ICVP.A9.DE.6, wider)
  * insert ElementMap(XX2PX3, ICVP.A9.DE.7, equivalent)

// ----- LOINC -----
* group[+]
  * source = Canonical(ICVP.Core)
  * target = $LOINC
  * insert ElementMap(ICVP.A9.DE.1, 87226-7, equivalent)
  * insert ElementMap(ICVP.A9.DE.2, 21112-8, equivalent)
  * insert ElementMap(ICVP.A9.DE.4, 11433-0, equivalent)
  * insert ElementMap(ICVP.A9.DE.5, 11432-2, equivalent)
  * insert ElementMap(ICVP.A9.DE.6, 11431-4, narrower)
  * insert ElementMap(ICVP.A9.DE.8, 69433-1, wider)
  * insert ElementMap(ICVP.A9.DE.9, 76435-7, wider)
  * insert ElementMap(ICVP.A9.DE.10, 79183-0, narrower)
  * insert ElementMap(ICVP.C5.DE.11, 39236-5, equivalent)
  * insert ElementMap(ICVP.C5.DE.12, 39236-5, equivalent)
  * insert ElementMap(ICVP.C5.DE.13, 30952-6, wider)
  * insert ElementMap(ICVP.C5.DE.16, 30957-5, equivalent)
  * insert ElementMap(ICVP.C5.DE.18, 30959-1, equivalent)
  * insert ElementMap(ICVP.C5.DE.19, 30959-1, equivalent)
* group[+]
  * source = $LOINC
  * target = Canonical(ICVP.Core)
  * insert ElementMap(87226-7, ICVP.A9.DE.1, equivalent)
  * insert ElementMap(21112-8, ICVP.A9.DE.2, equivalent)
  * insert ElementMap(11433-0, ICVP.A9.DE.4, equivalent)
  * insert ElementMap(11432-2, ICVP.A9.DE.5, equivalent)
  * insert ElementMap(11431-4, ICVP.A9.DE.6, wider)
  * insert ElementMap(69433-1, ICVP.A9.DE.8, narrower)
  * insert ElementMap(76435-7, ICVP.A9.DE.9, narrower)
  * insert ElementMap(79183-0, ICVP.A9.DE.10, wider)
  * insert ElementMap(39236-5, ICVP.C5.DE.11, equivalent)
  * insert ElementMap(30952-6, ICVP.C5.DE.13, narrower)
  * insert ElementMap(30957-5, ICVP.C5.DE.16, equivalent)
  * insert ElementMap(30959-1, ICVP.C5.DE.18, equivalent)

// ----- SNOMED CT (GPS) -----
* group[+]
  * source = Canonical(ICVP.Core)
  * target = $SCT
  * insert ElementMap(ICVP.A9.DE.2, 184099003, equivalent)
  * insert ElementMap(ICVP.A9.DE.4, 248153007, equivalent)
  * insert ElementMap(ICVP.A9.DE.5, 248152002, equivalent)
  * insert ElementMap(ICVP.A9.DE.6, 32570691000036108, narrower)
  * insert ElementMap(ICVP.A9.DE.7, 184115007, equivalent)
  * insert ElementMap(ICVP.A9.DE.8, 223369002, wider)
  * insert ElementMap(ICVP.A9.DE.9, 900000000000474003, wider)
  * insert ElementMap(ICVP.A9.DE.10, 394619001, wider)
  * insert ElementMap(ICVP.C5.DE.11, 787859002, equivalent)
* group[+]
  * source = $SCT
  * target = Canonical(ICVP.Core)
  * insert ElementMap(184099003, ICVP.A9.DE.2, equivalent)
  * insert ElementMap(248153007, ICVP.A9.DE.4, equivalent)
  * insert ElementMap(248152002, ICVP.A9.DE.5, equivalent)
  * insert ElementMap(32570691000036108, ICVP.A9.DE.6, wider)
  * insert ElementMap(184115007, ICVP.A9.DE.7, equivalent)
  * insert ElementMap(223369002, ICVP.A9.DE.8, narrower)
  * insert ElementMap(900000000000474003, ICVP.A9.DE.9, narrower)
  * insert ElementMap(394619001, ICVP.A9.DE.10, narrower)
  * insert ElementMap(787859002, ICVP.C5.DE.11, equivalent)
