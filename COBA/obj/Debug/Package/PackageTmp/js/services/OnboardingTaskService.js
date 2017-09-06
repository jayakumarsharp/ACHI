'use strict';
ReportApp.factory('OnboardingTaskService', function ($http) {
    var OnboardingTaskServiceURI = BaseURL;
    var OnboardingTaskServiceFactory = {};

    OnboardingTaskServiceFactory.GetAllTask = function () {
        var result = $http.get('GetOnboardingTaskData');
        return result;
    }
    OnboardingTaskServiceFactory.GetAllTaskById = function (Strategyid) {
        var result = $http.get('GetOnboardingTaskbyId?Id=' + Strategyid);
        return result;
    }

    OnboardingTaskServiceFactory.UpdateOnboardingTask = function (currencysheet) {
        return $http.post('UpdateOnboardingTask', currencysheet);
    }

    OnboardingTaskServiceFactory.saveTutorial = function (tutorial) {
        return akFileUploaderService.saveModel("saveTutorial",tutorial);
    }

    return OnboardingTaskServiceFactory;
});

