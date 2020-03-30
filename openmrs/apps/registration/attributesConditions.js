var showOrHideByAge = function (patient) {
    var returnValues = {
        show: [],
        hide: []
    };
    if (patient["age"].years > 5) {
        returnValues.show.push('otherDetails');
    } else {
        returnValues.hide.push('otherDetails');
    }
    return returnValues
};

Bahmni.Registration.AttributesConditions.rules = {
    'age': function (patient) {
        return showOrHideByAge(patient);
    },
 
    'birthdate': function (patient) {
        return showOrHideByAge(patient);
    },
    'isAboveFive': function(patient) {
        var returnValues = {
            show: [],
            hide: []
        };
        if (patient["isAboveFive"]) {
            returnValues.show.push('otherDetails');
        } else {
            returnValues.hide.push('otherDetails');
        }
        return returnValues;
    }
};
