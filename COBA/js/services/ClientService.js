'use strict';
ReportApp.factory('ClientService', function ($http) {
    var ClientServiceURI = BaseURL+'Main/';
    var ClientServiceFactory = {};

    ClientServiceFactory.GetAllCurrencyConversion = function () {
        var result = $http.get(ClientServiceURI + 'GetData');
        return result;
    }
    ClientServiceFactory.GetDatabyId = function (clientid) {
        var result = $http.get(ClientServiceURI + 'GetDatabyId?clientnumber=' + clientid);
        return result;
    }

    ClientServiceFactory.InsertClient = function (currencysheet) {
        return $http.post(ClientServiceURI + 'InsertClient', currencysheet);
    }

    ClientServiceFactory.UpdateClient = function (currencysheet) {
        return $http.post(ClientServiceURI + 'UpdateClient', currencysheet);
    }


    return ClientServiceFactory;
});

