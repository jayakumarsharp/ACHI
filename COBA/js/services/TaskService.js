'use strict';
ReportApp.factory('TaskService', function ($http) {
    var TaskServiceURI = BaseURL;
    var TaskServiceFactory = {};

    TaskServiceFactory.GetAllTask = function () {
        var result = $http.get('GetTaskData');
        return result;
    }

    TaskServiceFactory.GetAllTaskById = function (Id) {
        var result = $http.get('GetTaskbyId?Id=' + Id);
        return result;
    }
    TaskServiceFactory.AddTask = function (inputdata) {
        return $http.post('InsertTask', inputdata);
    }

    TaskServiceFactory.UpdateTask = function (inputdata) {
        return $http.post('UpdateTask', inputdata);
    }

    TaskServiceFactory.UpdateStrategyApprover = function (inputdata) {
        return $http.post('UpdateStrategyApprover', inputdata);
    }
    
    return TaskServiceFactory;
});

