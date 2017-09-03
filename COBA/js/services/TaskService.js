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
    TaskServiceFactory.AddTask = function (BaseSkill) {
        return $http.post('InsertTask', BaseSkill);
    }

    TaskServiceFactory.UpdateTask = function (BaseSkill) {
        return $http.post('UpdateTask', BaseSkill);
    }

    return TaskServiceFactory;
});

