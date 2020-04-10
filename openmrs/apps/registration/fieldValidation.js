Bahmni.Registration.customValidator = {
    "age.days": {
        method: function (name, value) {
            return value >= 0;
        },
        errorMessage: "REGISTRATION_AGE_ERROR_KEY"
    },
    "Telephone Number": {
        method: function (name, value, personAttributeDetails) {
            return value && value.length> 6;
        },
        errorMessage: "REGISTRATION_TELEPHONE_NUMBER_ERROR_KEY"
    },
    "caste": {
        method: function (name, value, personAttributeDetails) {
            return value.match(/^\w+$/);
        },
        errorMessage: "REGISTRATION_CASTE_TEXT_ERROR_KEY"
    },
    "nextOfKinIdentifier": {
        method: function (name, value, personAttributeDetails) {
            return value && value.length === 8;
        },
        errorMessage: "NOK_ID_NUMBER_FIELD_ERROR"
    },
    "mobileNo": {
        method: function (name, value, personAttributeDetails) {
            return value && value.length >=10 && value.length <= 13 ;
        },
        errorMessage: "REGISTRATION_MOBILE_NO_ERROR"
    },
    "nextOfKinPhoneNumber": {
        method: function (name, value, personAttributeDetails) {
            return value && value.length >=10 && value.length <= 13 ;
        },
        errorMessage: "REGISTRATION_NOK_MOBILE_NO_ERROR"
    }
};
