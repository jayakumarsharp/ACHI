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




ReportApp.service('ApiCall', ['$http', function ($http) {

    var result;
    this.MakeApiCall = function (Url, type, jsondata) {
        //var Jsondata = JSON.stringify(data);

        if (type == 'GET') {

            //return $http.get(Url, jsondata);

            return $http({
                url: Url,
                method: type,
                params: jsondata
            });
        } else if (type == 'POST') {
            return $http.post(Url, jsondata);

            //return $http({
            //    url: Url,
            //    method: type,
            //    data: jsondata
            //});
        }
    };
}]);