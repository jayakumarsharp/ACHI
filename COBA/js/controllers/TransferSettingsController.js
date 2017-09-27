ReportApp.controller('TransferSettingsController', function ($scope, $rootScope, StrategyService, $timeout) {
    $scope.status = false;
    $scope.IsReadOnly = true;
    $scope.changeStatus = function () {
        if (!$scope.IsReadOnly)
            $scope.status = !$scope.status;
    }
    $scope.userlist = [{ RefNumber: '', Approver: 'Daniel', Id: 1 }, { RefNumber: '', Approver: 'George', Id: 2 }, { RefNumber: '', Approver: 'John', Id: 3 }, { RefNumber: '', Approver: 'Sivakumar', Id: 4 }, { RefNumber: '', Approver: 'Oliver', Id: 5 }]
    $scope.transfer = {};

    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Transfer Settings Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };
    $scope.getallcurrencyconversions = function () {
        StrategyService.GetTransfersetting().success(function (data) {
            //console.log(data);
            if (data != null && data.length > 0) {
                console.log(data);
                $scope.status = true;
                //coodata[0];

                $scope.TransferTo = data[0].TransferTo;
                $scope.TransferFrom = data[0].TransferFrom;
                $scope.Transferuser = data[0].Transferuser;
            }
            else {
                $scope.TransferTo = '';
                $scope.TransferFrom = '';
                $scope.TransferTo = '';
            }
        })
    };

    $scope.getallcurrencyconversions();

    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.getallcurrencyconversions();

    $scope.showadd = function () {
        $timeout(function () {
            $scope.errorinfo = '';
            $scope.EmailActive = false;
        }, 100);

        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');
    };

    $scope.GetAllCurrency = function () {
        EmailService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.update = function () {
        if ($scope.status) {
            if ($scope.Transferuser != '' && $scope.TransferFrom != '' && $scope.TransferTo != '')
                var currency = { Transferuser: $scope.Transferuser, TransferFrom: $scope.TransferFrom, TransferTo: $scope.TransferTo }
            StrategyService.InsertTransferSetting(currency).success(function (data) {
                if (data == "success") {
                    $scope.getallcurrencyconversions()
                    $('#currencyModel').modal('hide');
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });

        }
        else {
            StrategyService.DeleteTransferSetting().success(function (data) {
                if (data == "success") {
                    $scope.getallcurrencyconversions()
                    $('#currencyModel').modal('hide');
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }


    };

    $scope.showconfirm = function (data) {
        $scope.Id = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.ecurrency = {};
        $('#currencyModel').modal('hide');
    };

    $scope.GetRightsList();

});