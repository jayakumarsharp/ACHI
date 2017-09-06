'use strict';
ReportApp.factory('EmailService', function ($http) {
    var EmailServiceURI = BaseURL;
    var EmailServiceFactory = {};

    EmailServiceFactory.GetAllTask = function () {
        var result = $http.get('GetOnboardingTaskData');
        return result;
    }
    EmailServiceFactory.GetAllTaskById = function (Strategyid) {
        var result = $http.get('GetOnboardingTaskbyId?Id=' + Strategyid);
        return result;
    }

    EmailServiceFactory.UpdateOnboardingTask = function (currencysheet) {
        return $http.post('UpdateOnboardingTask', currencysheet);
    }


    return EmailServiceFactory;
});

