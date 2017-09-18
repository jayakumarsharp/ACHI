ReportApp.controller('TaskController', function ($scope, $rootScope, TaskService, $timeout) {
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

        TaskService.GetAllTask().success(function (data) {
            console.log(data)
            $scope.CurrencyGrid.data=data;;
        })
    };
    $scope.getallcurrencyconversions();
    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    var columnDefs = [{  name: 'Id' },
        {  name: 'Name' },
        //{ headerName: 'Description', name: 'Description', width: 440 },
        //{
        //    headerName: 'SignOff Status', name: 'IsSignOff', width: 40, cellRenderer: function (params) {
        //        if (params.data.IsSignOff == "Y")
        //            return "<i class='fa fa-check btn-success btn-circle'></i>"
        //        else
        //            return "<i class='fa fa-close btn-danger btn-circle'></i>"
        //    }
        //},
        {
            headerName: 'IsActive', name: 'IsActive'
            ,cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsActive=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsActive=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },

        {
            name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'
            
        }
    ];


    $scope.CurrencyGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,
        
    };

    $scope.showadd = function () {
        $timeout(function () {
            $scope.TaskActive = false;
            $scope.IsSignOff = false;
        }, 100);
        $scope.errorinfo = '';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };

    $scope.GetAllCurrency = function () {
        TaskService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.add = function (currency) {
        if (currency != null) {
            if ($scope.TaskActive)
                currency.IsActive = "Y";
            else
                currency.IsActive = "N";

            if ($scope.IsSignOff)
                currency.IsSignOff = "Y";
            else
                currency.IsSignOff = "N";
            TaskService.AddTask(currency).success(function (data) {
                if (data == "success") {
                    $scope.editMode = false;
                    //toaster.pop('success', "Success", "Currency rate updated successfully", null);
                    $('#currencyModel').modal('hide');
                    $scope.getallcurrencyconversions()
                }
                else
                    $scope.errorinfo = data;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        TaskService.GetAllTaskById(id).success(function (data) {
            $scope.editMode = true;

            if (data[0].IsActive == "Y")
                $scope.TaskActive = true;
            else
                $scope.TaskActive = false;

            if (data[0].IsSignOff == "Y")
                $scope.IsSignOff = true;
            else
                $scope.IsSignOff = false;


            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };




    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;
        if ($scope.TaskActive)
            model.IsActive = "Y";
        else
            model.IsActive = "N";

        if ($scope.IsSignOff)
            model.IsSignOff = "Y";
        else
            model.IsSignOff = "N";
        TaskService.UpdateTask(model).success(function (data) {
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
        TaskService.GetCurrencyConversionbyId(id).success(function (data) {
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