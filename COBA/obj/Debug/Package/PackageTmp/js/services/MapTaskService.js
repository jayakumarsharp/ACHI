'use strict';
ReportApp.factory('MapTaskService', function ($http) {
    var MapTaskServiceURI = BaseURL + 'Main/';
    var MapTaskServiceFactory = {};

    MapTaskServiceFactory.Get_Mapped_Mail_Task = function (type) {
        var result = $http.get(MapTaskServiceURI + 'Get_Mapped_Mail_Task?Type=' + type);
        return result;
    }

    MapTaskServiceFactory.GetAllTask = function () {
        var result = $http.get(MapTaskServiceURI + 'GetMapTaskData');
        return result;
    }
    MapTaskServiceFactory.GetAllTaskById = function (clientid) {
        var result = $http.get(MapTaskServiceURI + 'GetMapTaskbyId?Id=' + clientid);
        return result;
    }

    MapTaskServiceFactory.UpdateMapTask = function (currencysheet) {
        return $http.post(MapTaskServiceURI + 'UpdateMapTask', currencysheet);
    }

    MapTaskServiceFactory.GetAllClientTask = function () {
        var result = $http.get(MapTaskServiceURI + 'GetAllClientTask');
        return result;
    }
    MapTaskServiceFactory.GetClientMappedTask = function (type) {
        var result = $http.get(MapTaskServiceURI + 'GetClientMappedTask?Type=' + type);
        return result;
    }

    MapTaskServiceFactory.UpdateClientMapTask = function (currencysheet) {
        return $http.post(MapTaskServiceURI + 'UpdateClientMapTask', currencysheet);
    }

    return MapTaskServiceFactory;
});

