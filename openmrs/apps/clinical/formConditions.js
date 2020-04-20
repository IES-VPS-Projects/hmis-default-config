Bahmni.ConceptSet.FormConditions.rules = {
    'Diastolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Systolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
   'Immunization, Child on Transit?' : function (formName, formFieldValues) {
        var data = formFieldValues['Immunization, Child on Transit?'];
        if (data) {
            return {
                enable: ["Immunization, Date of Next Appointment"]
            }
        } else {
            return {
                disable: ["Immunization, Date of Next Appointment"]
            }
        }
    },
    "Development milestone CWC":function(formName, formFieldValues) {
        var conditions = {
        show: [],
        hide: []
        };
        var conditionConcept = formFieldValues['Development milestone CWC'];
        if (conditionConcept == null){
            conditions.hide.push("CWC, Normal Limits");
        } else if (conditionConcept == "CWC, Social Smile"){
            conditions.hide.push("CWC, Normal Limits");
        } else {
            conditions.show.push("CWC, Normal Limits");
        }
        return conditions;
    }
};
