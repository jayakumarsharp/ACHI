'use strict';
ReportApp.factory('EmailService', function ($http) {
    var EmailServiceURI = BaseURL + 'Main/';
    var EmailServiceFactory = {};

    EmailServiceFactory.GetAllTask = function () {
        var result = $http.get(EmailServiceURI + 'GetOnboardingTaskData');
        return result;
    }
    EmailServiceFactory.GetAllTaskById = function (clientid) {
        var result = $http.get(EmailServiceURI + 'GetOnboardingTaskbyId?Id=' + clientid);
        return result;
    }

    EmailServiceFactory.UpdateOnboardingTask = function (currencysheet) {
        return $http.post(EmailServiceURI + 'UpdateOnboardingTask', currencysheet);
    }


    return EmailServiceFactory;
});

