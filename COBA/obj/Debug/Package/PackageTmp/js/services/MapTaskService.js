'use strict';
ReportApp.factory('MapTaskService', function ($http) {
    var MapTaskServiceURI = BaseURL;
    var MapTaskServiceFactory = {};

    

    MapTaskServiceFactory.Get_Mapped_Mail_Task = function (type) {
        var result = $http.get('Get_Mapped_Mail_Task?Type=' + type);
        return result;
    }

    MapTaskServiceFactory.GetAllTask = function () {
        var result = $http.get('GetMapTaskData');
        return result;
    }
    MapTaskServiceFactory.GetAllTaskById = function (Strategyid) {
        var result = $http.get('GetMapTaskbyId?Id=' + Strategyid);
        return result;
    }

    MapTaskServiceFactory.UpdateMapTask = function (currencysheet) {
        return $http.post('UpdateMapTask', currencysheet);
    }


    return MapTaskServiceFactory;
});

