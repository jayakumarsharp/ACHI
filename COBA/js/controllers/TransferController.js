ReportApp.controller('TransfersController', function ($scope, $rootScope, StrategyService, TaskService, $timeout, $filter, UserFactory, reportFactory, toaster) {
    $scope.errorinfo = '';
    $scope.CurrencyList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.SBU = [];
    $scope.Region = [];
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.ecurrency = {};
    $scope.LockedPriceSheet = [];
    $scope.GetRightsList = function () {

        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Approvals Write') {
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

    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];
    $scope.Selcurrentversion = 0;

    $scope.GetCurrencyConversionForId = function (RefNumber, Approver, Version, Comments, ApprovedDate, Status) {
        $('#LayoutModel1').modal('show');
        $scope.notificationExist = true;
        $scope.currency = { 'Comments': Comments, 'RefNumber': RefNumber, 'Approver': Approver, 'Version': Version, 'Comments': Comments, 'ApprovedDate': ApprovedDate, 'Status': Status };
        debugger
        if ($scope.currency.Status == "Y")
            $scope.Status = true;
        else
            $scope.Status = false;
        $scope.OStatus = angular.copy($scope.Status);

    };

    $scope.changestatus = function (status) {
        $timeout(function () { $scope.Status = status; });
    }

    $scope.notificationExist = false;
    $scope.notificationdata = [];

    $scope.GetCurrencyConversionForIdView = function (id, Version) {
        $scope.ViewData = [];
        StrategyService.GetStrategyApprovalById(id, Version).success(function (data) {
            $('#currencyModel1').modal('show');

            $scope.ViewData = data;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };



    $scope.GetAlldata = function () {
        StrategyService.Get_ApprovaltransferByuser().success(function (data) {
            $timeout(function () {
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }
                $scope.CurrencyGrid.data = data;
            }, 100)
        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAlldata();


    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    

    $scope.GetAllCurrency = function () {
        TaskService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;
        if ($scope.Status)
            model.Status = "Y";
        else
            model.Status = "N";
        TaskService.UpdateStrategyApprover(model).success(function (data) {
            if (data == "success") {
                $scope.editMode = false;
                toaster.pop('success', "Success", " updated successfully", null);
                $timeout(function () {
                    $scope.GetAlldata();
                })

                $('#LayoutModel1').modal('hide');
            }
            else
                $scope.errorinfo = data;

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };

    $scope.showconfirm = function (data) {
        $scope.Id = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.ecurrency = {};
        $('#LayoutModel1').modal('hide');
    };
});