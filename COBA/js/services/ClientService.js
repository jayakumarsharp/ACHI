'use strict';
ReportApp.factory('ClientService', function ($http) {
    var ClientServiceURI = BaseURL;
    var ClientServiceFactory = {};

    ClientServiceFactory.GetAllCurrencyConversion = function () {
        var result = $http.get('GetData');
        return result;
    }
    ClientServiceFactory.GetDatabyId = function (clientid) {
        var result = $http.get('GetDatabyId?clientnumber=' + clientid);
        return result;
    }

    ClientServiceFactory.InsertClient = function (currencysheet) {
        return $http.post('InsertClient', currencysheet);
    }

    ClientServiceFactory.UpdatecurrencyConversion = function (currencysheet) {
        return $http.post(ClientServiceURI + 'currency/ModifyCurrencyConversion', currencysheet);
    }


    return ClientServiceFactory;
});

