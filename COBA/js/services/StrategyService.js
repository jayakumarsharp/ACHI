'use strict';
ReportApp.factory('StrategyService', function ($http) {
    var StrategyServiceURI = BaseURL;
    var StrategyServiceFactory = {};

    
    StrategyServiceFactory.GetStrategyApprovalByuser = function () {
        var result = $http.get('GetStrategyApprovalByuser');
        return result;
    }
    StrategyServiceFactory.GetAllCurrencyConversion = function () {
        var result = $http.get('GetData');
        return result;
    }
    StrategyServiceFactory.GetDatabyId = function (Strategyid) {
        var result = $http.get('GetDatabyId?Strategynumber=' + Strategyid);
        return result;
    }
    StrategyServiceFactory.GetStrategyDatabyStrategyId = function (Strategyid) {
        var result = $http.get('GetStrategyDatabyStrategyId?Strategynumber=' + Strategyid);
        return result;
    }
    StrategyServiceFactory.GetStrategyApprovalById = function (Strategyid,Version) {
        var result = $http.get('GetStrategyApprovalById?Strategynumber=' + Strategyid+'&Version='+Version);
        return result;
    }
    
    
    StrategyServiceFactory.InsertStrategyApprover = function (currencysheet) {
        return $http.post('InsertStrategyApprover', currencysheet);
    }
    StrategyServiceFactory.InsertStrategy = function (currencysheet) {
        return $http.post('InsertStrategy', currencysheet);
    }

    StrategyServiceFactory.UpdatecurrencyConversion = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'currency/ModifyCurrencyConversion', currencysheet);
    }


    return StrategyServiceFactory;
});

