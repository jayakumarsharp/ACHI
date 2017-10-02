ReportApp.controller('TransferSettingsController', function ($scope, $rootScope, StrategyService, $timeout, UserFactory, reportFactory, toaster) {
    $scope.status = false;
    $scope.IsReadOnly = true;
    $scope.changeStatus = function () {
        if (!$scope.IsReadOnly)
            $scope.status = !$scope.status;
    }
    $scope.userlist = [{ RefNumber: '', Approver: 'Daniel', Id: 1 }, { RefNumber: '', Approver: 'George', Id: 2 }, { RefNumber: '', Approver: 'John', Id: 3 }, { RefNumber: '', Approver: 'Sivakumar', Id: 4 }, { RefNumber: '', Approver: 'Oliver', Id: 5 }]
    $scope.transfer = {};

    $scope.GetRightsList = function () {

        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Delegate Settings Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });

    };
    $scope.getallcurrencyconversions = function () {
        StrategyService.GetTransfersetting().success(function (data) {
            //console.log(data);
            if (data != null && data.length > 0) {
                console.log(data);
                $scope.status = true;
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

    $scope.update = function () {
        if ($scope.status) {
            if ($scope.Transferuser != '' && $scope.TransferFrom != '' && $scope.TransferTo != '')
                var currency = { Transferuser: $scope.Transferuser, TransferFrom: $scope.TransferFrom, TransferTo: $scope.TransferTo }
            StrategyService.InsertTransferSetting(currency).success(function (data) {
                if (data == "success") {
                    $scope.getallcurrencyconversions()
                    toaster.pop('success', "Success", 'Delegate setting updated successfully', null);
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });

        }
        else {
            StrategyService.DeleteTransferSetting().success(function (data) {
                if (data == "success") {
                    $scope.getallcurrencyconversions()
                    toaster.pop('success', "Success", 'Delegate setting updated successfully', null);
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