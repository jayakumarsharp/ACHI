ReportApp.controller('MapTaskController', function ($scope, $rootScope, MapTaskService, TaskService, $timeout, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.errorinfo = '';
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.ecurrency = {};
    $scope.Mappedtask = 0;
    $scope.UnMappedtask = 0;

    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };
    $scope.selectedarea = "AllTask";
    $scope.getallcurrencyconversions = function () {

        $scope.GetMappingTask(false);
        $scope.GetUnMappingTask(false);
        MapTaskService.GetAllTask().success(function (data) {
            if (data != null && data.length > 0)
                $scope.totaltask = data.length;
            else
                $scope.totaltask = 0;
            $scope.dtOptions.data = data;;
        });
        $scope.selectedarea = "AllTask";
    };

    $scope.GetMappingTask = function (page) {
        $scope.selectedarea = "MapTask";
        MapTaskService.Get_Mapped_Mail_Task("Y").success(function (data) {
            console.log(data)
            if (data != null && data.length > 0)
                $scope.Mappedtask = data.length;
            else
                $scope.Mappedtask = 0;
            if (page)
                $scope.dtOptions.data = data;;
        })

    }
    $scope.GetUnMappingTask = function (page) {
        $scope.selectedarea = "UnMapTask";
        MapTaskService.Get_Mapped_Mail_Task("N").success(function (data) {
            if (data != null && data.length > 0)
                $scope.UnMappedtask = data.length;
            else
                $scope.UnMappedtask = 0;
            if (page)
                $scope.dtOptions.data = data;
        })
    }

    $scope.dtOptions = DTOptionsBuilder.fromSource()
   .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('ClientNumber').withTitle('ClientNumber'),
    DTColumnBuilder.newColumn('TaskName').withTitle('Task'),
    DTColumnBuilder.newColumn('EmailSubject').withTitle('Subject'),
    DTColumnBuilder.newColumn('EmailId').withTitle('EmailID'),
        DTColumnBuilder.newColumn('Id').withTitle('Action').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        return '<a  ng-click="GetCurrencyConversionForId(' + data + ')"><img src="images/edit.png"></a> ';
    }

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
            debugger;
            $scope.editMode = true;
            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };
    $scope.UpdatecurrencyConversion = function (model) {
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

    $scope.gettask = function () {
        TaskService.GetAllTask().success(function (data) {
            $scope.EstimationProduct = data;
        })
    };
    $scope.gettask();

});