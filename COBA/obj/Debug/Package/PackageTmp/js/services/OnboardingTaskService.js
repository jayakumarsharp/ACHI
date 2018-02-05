'use strict';
ReportApp.factory('OnboardingTaskService', ['$http', function ($http) {
    var OnboardingTaskServiceURI = BaseURL + 'Main/';
    var OnboardingTaskServiceFactory = {};

    OnboardingTaskServiceFactory.GetAllTask = function () {
        var result = $http.get(OnboardingTaskServiceURI + 'GetOnboardingTaskData');
        return result;
    }
    OnboardingTaskServiceFactory.GetAllTaskById = function (clientid) {
        var result = $http.get(OnboardingTaskServiceURI + 'GetOnboardingTaskbyId?Id=' + clientid);
        return result;
    }

    OnboardingTaskServiceFactory.UpdateOnboardingTask = function (currencysheet) {
        return $http.post(OnboardingTaskServiceURI + 'UpdateOnboardingTask', currencysheet);
    }

    OnboardingTaskServiceFactory.saveTutorial = function (tutorial) {
        return akFileUploaderService.saveModel(OnboardingTaskServiceURI + "saveTutorial", tutorial);
    }

    return OnboardingTaskServiceFactory;
}]);

