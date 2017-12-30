'use strict';
ReportApp.factory('StrategyService', ['$http', function ($http) {
    var StrategyServiceURI = BaseURL+'Main/';
    var StrategyServiceFactory = {};


    StrategyServiceFactory.GetStrategyApprovalByuser = function () {
        var result = $http.get(StrategyServiceURI + 'GetStrategyApprovalByuser');
        return result;
    }


    StrategyServiceFactory.GetDelegatedApprovalByuser = function () {
        var result = $http.get(StrategyServiceURI + 'GetDelegatedApprovalByuser');
        return result;
    }


    StrategyServiceFactory.GetAllCurrencyConversion = function () {
        var result = $http.get(StrategyServiceURI + 'GetData');
        return result;
    }
    StrategyServiceFactory.GetDatabyId = function (Strategyid) {
        var result = $http.get(StrategyServiceURI + 'GetDatabyId?Strategynumber=' + Strategyid);
        return result;
    }
    StrategyServiceFactory.GetStrategyDatabyStrategyId = function (Strategyid) {
        var result = $http.get(StrategyServiceURI + 'GetStrategyDatabyStrategyId?Strategynumber=' + Strategyid);
        return result;
    }
    StrategyServiceFactory.GetStrategyApprovalById = function (Strategyid, Version) {
        var result = $http.get(StrategyServiceURI + 'GetStrategyApprovalById?Strategynumber=' + Strategyid + '&Version=' + Version);
        return result;
    }


    StrategyServiceFactory.InsertStrategyApprover = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'InsertStrategyApprover', currencysheet);
    }
    StrategyServiceFactory.InsertStrategy = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'InsertStrategy', currencysheet);
    }

    StrategyServiceFactory.SaveNewversionStrategy = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'SaveNewversionStrategy', currencysheet);
    }

    StrategyServiceFactory.UpdateStrategy = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'UpdateStrategy', currencysheet);
    }

    StrategyServiceFactory.DeleteStrategyApprover = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'DeleteStrategyApprover', currencysheet);
    }

    StrategyServiceFactory.UpdatecurrencyConversion = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'currency/ModifyCurrencyConversion', currencysheet);
    }


    //TransferSettings

    StrategyServiceFactory.GetTransfersetting = function () {
        var result = $http.get(StrategyServiceURI + 'GetTransferSettingByuser');
        return result;
    }

    StrategyServiceFactory.InsertTransferSetting = function (currencysheet) {
        return $http.post(StrategyServiceURI + 'InsertTransferSetting', currencysheet);
    }

    StrategyServiceFactory.DeleteTransferSetting = function () {
        return $http.get(StrategyServiceURI + 'DeleteTransferSetting');
    }


    StrategyServiceFactory.Get_ApprovaltransferByuser = function () {
        return $http.get(StrategyServiceURI + 'Get_ApprovaltransferByuser');
    }


    //TransferSettings


    StrategyServiceFactory.ShowLoader = function () {
        angular.element(document.querySelector('#loader')).removeClass('hide');
    };


    StrategyServiceFactory.HideLoader = function () {
        angular.element(document.querySelector('#loader')).addClass('hide');
    };
    return StrategyServiceFactory;
}]);

