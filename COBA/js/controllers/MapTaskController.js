ReportApp.controller('MapTaskController', function ($scope, $rootScope, MapTaskService, TaskService, $timeout) {
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
    { name: 'StrategyNumber' },
    { name: 'TaskName' },
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
            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');
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



    $scope.selectedA_Estimation = [];
    $scope.selectedB_Estimation = [];

    $scope.listA_Estimation = [];
    $scope.listB_Estimation = [];

    $scope.checkedA_Estimation = false;
    $scope.checkedB_Estimation = false;

    $scope.AvailableUser_Estimation = [];

    $scope.gettask = function () {

        TaskService.GetAllTask().success(function (data) {
            console.log(data);
            $scope.EstimationProduct = data;

            $scope.listA_Estimation = [];
            $scope.listB_Estimation = [];
            var temp = JSON.parse(JSON.stringify($scope.EstimationProduct));

            for (i = 0; i < $scope.AvailableUser_Estimation.length; i++) {
                $scope.listB_Estimation.push({ 'Name': $scope.AvailableUser_Estimation[i].Name, 'Id': $scope.AvailableUser_Estimation[i].Id });
                var delId = arrayObjectEstimationProductIndexOf(temp, $scope.AvailableUser_Estimation[i].Name);
                temp.splice(delId, 1);
            }
            //alert('ss1s :' + JSON.stringify(temp));
            $scope.listA_Estimation = temp;

        })
    };

    $scope.gettask();

    $scope.AlltoA_Estimation = function () {
        $scope.selectedB_Estimation = [];
        angular.forEach($scope.listB_Estimation, function (value, key) {
            $scope.selectedB_Estimation.push(value.Name);
        })
        $scope.bToA_Estimation();
    }
    $scope.AlltoB_Estimation = function () {
        $scope.selectedA_Estimation = [];
        angular.forEach($scope.listA_Estimation, function (value, key) {
            $scope.selectedA_Estimation.push(value.Name);
        })
        $scope.aToB_Estimation();
    }

    function arrayObjectEstimationProductIndexOf(myArray, searchTerm) {
        //debugger;
        for (var i = 0, len = myArray.length; i < len; i++) {
            if (myArray[i].Name == searchTerm) {
                return i;
            }
        }
        return -1;
    }


    $scope.aToB_Estimation = function () {
        var items = JSON.parse(JSON.stringify($scope.EstimationProduct));
        console.log('a to b');
        for (var i = 0; i < $scope.selectedA_Estimation.length; i++) {
            var moveId = arrayObjectEstimationProductIndexOf($scope.EstimationProduct, $scope.selectedA_Estimation[i]);
            $scope.listB_Estimation.push({ 'Name': $scope.EstimationProduct[moveId].Name, 'Id': $scope.EstimationProduct[moveId].Id });
            var delId = arrayObjectEstimationProductIndexOf($scope.listA_Estimation, $scope.selectedA_Estimation[i]);
            $scope.listA_Estimation.splice(delId, 1);
            console.log('list A count after: ' + $scope.listA_Estimation.length);
            console.log('list B count after: ' + $scope.listB_Estimation.length);
        }
        $scope.selectedA_Estimation = [];
    };

    $scope.bToA_Estimation = function () {
        console.log('b to a');
        for (var i = 0; i < $scope.selectedB_Estimation.length; i++) {
            var moveId = arrayObjectEstimationProductIndexOf($scope.EstimationProduct, $scope.selectedB_Estimation[i]);
            if (moveId != -1) {
                $scope.listA_Estimation.push($scope.EstimationProduct[moveId]);
            }
            var delId = arrayObjectEstimationProductIndexOf($scope.listB_Estimation, $scope.selectedB_Estimation[i]);
            $scope.listB_Estimation.splice(delId, 1);
            console.log('list B count after: ' + $scope.listB_Estimation.length);
            console.log('list A count after: ' + $scope.listA_Estimation.length);
        }

        $scope.selectedB_Estimation = [];
    };

    $scope.stateBChanged_Estimation = function (isChecked, rightID) {
        if (isChecked == true) {
            $scope.selectedB_Estimation.push(rightID);
        }
        else {
            var delId = arrayObjectEstimationProductIndexOf($scope.selectedB_Estimation, rightID);
            $scope.selectedB_Estimation.splice(delId, 1);
        }
    }
    $scope.stateAChanged_Estimation = function (isChecked, rightID) {
        if (isChecked == true) {
            $scope.selectedA_Estimation.push(rightID);
        }
        else {
            var delId = arrayObjectEstimationProductIndexOf($scope.selectedA_Estimation, rightID);
            $scope.selectedA_Estimation.splice(delId, 1);
        }
    }

    function reset_Estimation() {
        $scope.toggle = 0;
    }



});