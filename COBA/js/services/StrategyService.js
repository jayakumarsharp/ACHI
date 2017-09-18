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
    StrategyServiceFactory.GetStrategyApprovalById = function (Strategyid, Version) {
        var result = $http.get('GetStrategyApprovalById?Strategynumber=' + Strategyid + '&Version=' + Version);
        return result;
    }


    StrategyServiceFactory.InsertStrategyApprover = function (currencysheet) {
        return $http.post('InsertStrategyApprover', currencysheet);
    }
    StrategyServiceFactory.InsertStrategy = function (currencysheet) {
        return $http.post('InsertStrategy', currencysheet);
    }

    StrategyServiceFactory.SaveNewversionStrategy = function (currencysheet) {
        return $http.post('SaveNewversionStrategy', currencysheet);
    }

    StrategyServiceFactory.UpdateStrategy = function (currencysheet) {
        return $http.post('UpdateStrategy', currencysheet);
    }

    StrategyServiceFactory.DeleteStrategyApprover = function (currencysheet) {
        return $http.post('DeleteStrategyApprover', currencysheet);
    }

    StrategyServiceFactory.UpdatecurrencyConversion = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'currency/ModifyCurrencyConversion', currencysheet);
    }


    //TransferSettings

    StrategyServiceFactory.GetTransfersetting = function () {
        var result = $http.get('GetTransferSettingByuser');
        return result;
    }

    StrategyServiceFactory.InsertTransferSetting = function (currencysheet) {
        return $http.post('InsertTransferSetting', currencysheet);
    }

    StrategyServiceFactory.DeleteTransferSetting = function () {
        return $http.get('DeleteTransferSetting');
    }


    StrategyServiceFactory.Get_ApprovaltransferByuser = function () {
        return $http.get('Get_ApprovaltransferByuser');
    }

    
    //TransferSettings



    return StrategyServiceFactory;
});

