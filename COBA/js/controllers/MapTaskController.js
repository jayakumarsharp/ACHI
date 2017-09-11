ReportApp.controller('MapTaskController', function ($scope, $rootScope, MapTaskService, StrategyService, TaskService, $timeout, $filter) {
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
    $scope.Mappedtask = 0;
    $scope.UnMappedtask = 0;
    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];

    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };

    $scope.getallcurrencyconversions = function () {
        $scope.GetMappingTask(false);
        $scope.GetUnMappingTask(false);
        MapTaskService.GetAllTask().success(function (data) {
            if (data != null && data.length > 0)
                $scope.totaltask = data.length;
            else
                $scope.totaltask = 0;
            $scope.CurrencyGrid.data = data;;
        })

        StrategyService.GetAllCurrencyConversion().success(function (data) {
            $scope.Strategydata = data;
        })
    };


    $scope.GetVersions = function (data) {
        if (data != "" && data != undefined) {
            StrategyService.GetStrategyDatabyStrategyId(data).success(function (data) {
                $scope.currency = $filter('orderBy')($scope.StrategyVersiondata, '-Version')[0];
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }

                $scope.StrategyVersiondata = data;
            })
        }
    };




    $scope.GetMappingTask = function (page) {

        MapTaskService.Get_Mapped_Mail_Task("Y").success(function (data) {
            console.log(data)
            if (data != null && data.length > 0)
                $scope.Mappedtask = data.length;
            else
                $scope.Mappedtask = 0;
            if (page)
                $scope.CurrencyGrid.data = data;;
        })

    }
    $scope.GetUnMappingTask = function (page) {

        MapTaskService.Get_Mapped_Mail_Task("N").success(function (data) {
            console.log(data)
            //$scope.CurrencyGrid.data=data;;
            if (data != null && data.length > 0)
                $scope.UnMappedtask = data.length;
            else
                $scope.UnMappedtask = 0;
            if (page)
                $scope.CurrencyGrid.data = data;;
        })

    }

    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    var columnDefs = [{ name: 'Id' },
    { name: 'RefNumber' },
    { name: 'Version' },
    { name: 'EmailSubject' },
    { name: 'EmailId' },

   {
       name: 'IsMappedToTask',
       cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsMappedToTask=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsMappedToTask=="Y"}}><i class="fa fa-check" ></i></a> </div>'
   },
        {
            name: 'IsActive',
            cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsActive=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsActive=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },
        {
            field: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'

        }
    ];


    $scope.CurrencyGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,

    };

    $scope.showadd = function () {
        $scope.errorinfo = '';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };

    $scope.GetAllCurrency = function () {
        MapTaskService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });

    };


    $scope.getallcurrencyconversions();
    $scope.add = function (currency) {
        if (currency != null) {
            currency.IsActive = "Y";
            currency.IsSignOff = "Y";
            currency.IsSignOff = (currency.IsSignOff == "checked" ? "Y" : 'N');
            MapTaskService.AddTask(currency).success(function (data) {
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        MapTaskService.GetAllTaskById(id).success(function (data) {
            $scope.editMode = true;
            $scope.GetVersions(data[0].RefNumber)
            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $timeout(function () {
                $scope.ecurrency = data[0];
                $('#currencyModel').modal('show');
            },1000)
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };



    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;

        //var result = selectedA_Estimation.map(function (val) {
        //    return val.Id;
        //}).join(',');
        //if (selectedA_Estimation.length > 0)
        //{
        //    model.TaskId = result;
        //    model.IsMappedToTask = "Y";
        //}
        //else
        //{
        //    model.TaskId = result;
        //    model.IsMappedToTask = "N";

        //}

        model.IsMappedToTask = "Y"

        MapTaskService.UpdateMapTask(model).success(function (data) {
            $scope.editMode = false;
            //toaster.pop('success', "Success", "Currency rate updated successfully", null);
            $('#currencyModel').modal('hide');
            $scope.getallcurrencyconversions()
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
        MapTaskService.GetCurrencyConversionbyId(id).success(function (data) {
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