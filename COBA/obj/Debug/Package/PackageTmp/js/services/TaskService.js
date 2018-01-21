'use strict';
ReportApp.factory('TaskService', function ($http) {
    var TaskServiceURI = BaseURL + 'Main/';
    var TaskServiceFactory = {};

    TaskServiceFactory.GetAllTask = function () {
        var result = $http.get(TaskServiceURI + 'GetTaskData');
        return result;
    }

    TaskServiceFactory.GetAllTaskById = function (Id) {
        var result = $http.get(TaskServiceURI + 'GetTaskbyId?Id=' + Id);
        return result;
    }
    TaskServiceFactory.AddTask = function (BaseSkill) {
        return $http.post(TaskServiceURI + 'InsertTask', BaseSkill);
    }

    TaskServiceFactory.UpdateTask = function (BaseSkill) {
        return $http.post(TaskServiceURI + 'UpdateTask', BaseSkill);
    }

    return TaskServiceFactory;
});

