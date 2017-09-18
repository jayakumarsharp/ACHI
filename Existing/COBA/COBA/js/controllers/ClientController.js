ReportApp.controller('ClientController', function ($scope, $rootScope, ClientService, $timeout) {

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
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };

    $scope.getallcurrencyconversions = function () {

        ClientService.GetAllCurrencyConversion().success(function (data) {
            console.log(data);
            $scope.CurrencyGrid.data = data;
        })
    };

    $scope.getallcurrencyconversions();
    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    $scope.CurrencyGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        //enableFiltering: true,
        //angularCompileRows: true,
        columnDefs: [{ name: 'Id' },
        { name: 'ClientNumber' },
        { name: 'ObligorName' },
        { name: 'OriginalLender' },
        { name: 'LCompanyName' },
        { name: 'BCompanyName' },
        {
            name: 'IsSignOff', width: 70,
            cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsSignOff=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsSignOff=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },
        {
            name: 'IsActive',
            cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsActive=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsActive=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },
        {
            field: 'Action', width: 70
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.ClientNumber)" ><i class="fa fa-edit" ></i></a ></div>'
            
        }
        ],

    };

    $scope.showadd = function () {
        $timeout(function () {
            $scope.errorinfo = '';
            $scope.ClientActive = false;
            $scope.IsSignOff = false;
        }, 100);


        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };

    $scope.GetAllCurrency = function () {
        ClientService.GetAllCurrency().success(function (data) {
            //$scope.Currency = data;
            $scope.CurrencyGrid.data = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.InsertClient = function (currency) {
        if ($scope.ClientActive)
            currency.IsActive = "Y";
        else
            currency.IsActive = "N";

        if ($scope.IsSignOff)
            currency.IsSignOff = "Y";
        else
            currency.IsSignOff = "N";
        if (currency != null) {
            ClientService.InsertClient(currency).success(function (data) {
                if (data == "success") {
                    $scope.GetAllCurrency();
                    $('#currencyModel').modal('hide');
                }
                else
                    $scope.errorinfo = data;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        ClientService.GetDatabyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.ecurrency = data[0];

            if (data[0].IsActive == "Y")
                $scope.ClientActive = true;
            else
                $scope.ClientActive = false;

            if (data[0].IsSignOff == "Y")
                $scope.IsSignOff = true;
            else
                $scope.IsSignOff = false;

            $('#currencyModel').modal('show');

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        var crc = { Id: $scope.Id };
        ClientService.DeletecurrencyConversion(crc).success(function (data) {
            $scope.editMode = false;
            $scope.getallcurrencyconversions();
            $('#confirmModal').modal('hide');
            toaster.pop('success', "Success", "Currency rate deleted successfully", null);
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };



    $scope.UpdatecurrencyConversion = function (model) {
        model.UpdatedBy = $rootScope.UserInfo.user.userId;
        ClientService.UpdatecurrencyConversion(model).success(function (data) {
            if (data == "success") {
                $scope.editMode = false;
                //toaster.pop('success', "Success", "Currency rate updated successfully", null);
                $('#currencyModel').modal('hide');
                $scope.getallcurrencyconversions()
            }
            else
                $scope.errorinfo = data;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };

    var formatDate = function (indate) {
        if (indate != null) {
            indateTime = indate.split('T');
            var date = new Date(indateTime[0]);
            var time = indateTime[1].substring(0, 8);
            return date.getMonth() + 1 + "/" + date.getDate() + "/" + date.getFullYear() + " " + time;
        }
        else {
            return '';
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

    $scope.updatecancel = function (data) {
        ClientService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };

    $scope.SetCurrencyDescription = function (currencyId) {
        if (currencyId != null && currencyId != '' && currencyId != undefined) {
            var currDesc = '';
            angular.forEach($scope.Currency, function (value, key) {
                if (value.Id == currencyId) {
                    currDesc = value.CurrencyDescrition;
                }
            })
            $scope.ecurrency.CurrencyDescrition = currDesc;
        }
        else {
            $scope.ecurrency.CurrencyDescrition = '';
        }
    };

    $scope.GetRightsList();

});