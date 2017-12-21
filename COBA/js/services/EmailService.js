'use strict';
ReportApp.factory('EmailService', function ($http) {
    var EmailServiceURI = BaseURL;
    var EmailServiceFactory = {};

    EmailServiceFactory.GetAllTask = function () {
        var result = $http.get('GetOnboardingTaskData');
        return result;
    }
    EmailServiceFactory.GetAllTaskById = function (clientid) {
        var result = $http.get('GetOnboardingTaskbyId?Id=' + clientid);
        return result;
    }

    EmailServiceFactory.UpdateOnboardingTask = function (currencysheet) {
        return $http.post('UpdateOnboardingTask', currencysheet);
    }


    return EmailServiceFactory;
});

