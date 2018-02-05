ReportApp.controller('MapClientTaskController', ['$scope', '$rootScope', 'MapTaskService', 'TaskService', '$timeout', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', '$sce', '_', function ($scope, $rootScope, MapTaskService, TaskService, $timeout, $compile, DTOptionsBuilder, DTColumnBuilder, $sce, _) {
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
        TaskService.GetAllTask().success(function (data) {
            $scope.TaskMasterdata = data;
            bindRegiondata(data);
        })
        $scope.GetMappingTask(false);
        $scope.GetUnMappingTask(false);
        MapTaskService.GetAllClientTask().success(function (data) {
            if (data != null && data.length > 0)
                $scope.totaltask = data.length;
            else
                $scope.totaltask = 0;
            $scope.dtOptions.data = data;
        });
        $scope.selectedarea = "AllTask";
    };

    $scope.GetMappingTask = function (page) {
        $scope.selectedarea = "MapTask";
        MapTaskService.GetClientMappedTask("Y").success(function (data) {
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
        MapTaskService.GetClientMappedTask("N").success(function (data) {
            if (data != null && data.length > 0)
                $scope.UnMappedtask = data.length;
            else
                $scope.UnMappedtask = 0;
            if (page)
                $scope.dtOptions.data = data;
        })

    }
    $scope.dtOptions = DTOptionsBuilder.fromSource()
       .withPaginationType('full_numbers').withOption('createdRow', createdRow).withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('TaskId').withTitle('TaskId').notVisible(),
        DTColumnBuilder.newColumn('ClientNumber').withTitle('ClientNumber'),
        DTColumnBuilder.newColumn('TaskName').withTitle('Task'),
        DTColumnBuilder.newColumn('Id').withTitle('Action').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        //  return '<a  ng-click="GetCurrencyConversionForId(' + data + ')"><img src="images/edit.png"></a> ';
        return '<a  class="test"><img src="images/edit.png"></a> ';
    }

    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.test', nRow).unbind('click');
        $('.test', nRow).bind('click', function () {
            $scope.$apply(function () {
                console.log(aData);
                $scope.GetCurrencyConversionForId(aData.ClientNumber, aData.TaskId);
            });
        });
    }
    $scope.showadd = function () {
        $scope.errorinfo = '';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };



    $scope.getallcurrencyconversions();

    $scope.GetCurrencyConversionForId = function (clientNumber, taskid) {
        //MapTaskService.GetAllTaskById(id).success(function (data) {
        $scope.editMode = true;
        // data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
        $scope.ecurrency.ClientNumber = clientNumber;
        $scope.multiselectRegion.selected = [];
        if (taskid) {
            assignRegion(taskid.split(','));
        }


        $('#currencyModel').modal('show');
        //}).error(function (data) {
        //    $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        //});
    };



    $scope.UpdatecurrencyConversion = function (model) {
        model.IsMappedToTask = "Y";
        model.TaskmasterList = $scope.multiselectRegion.selected;
        MapTaskService.UpdateClientMapTask(model).success(function (data) {
            $scope.editMode = false;
            //toaster.pop('success', "Success", "Currency rate updated successfully", null);
            $('#currencyModel').modal('hide');
            $scope.getallcurrencyconversions()
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.ecurrency = {};
        $('#currencyModel').modal('hide');
    };

    $scope.GetRightsList();



    $scope.multiselectRegion = {
        selected: [],
        options: [],
        config: {
            hideOnBlur: false,
            showSelected: false,
            itemTemplate: function (item) {
                return $sce.trustAsHtml(item.name);
            },
            labelTemplate: function (item) {
                return $sce.trustAsHtml(item.name);
            }
        }
    };

    //  user.RegionList = $scope.multiselectRegion.selected;
    // $scope.multiselectRegion.selected = [];

    function assignRegion(data) {
        for (var i = 0; i < data.length > 0; i++) {
            var row = _.findWhere($scope.TaskMasterdata, {
                Id: parseInt(data[i])
            })

            $scope.multiselectRegion.selected.push({ id: row.Id, name: row.Name })
        }
        bindRegiondata($scope.TaskMasterdata);
    }

    function bindRegiondata(list) {
        $scope.multiselectRegion.options = list.map(function (item) {
            return {
                name: item.Name,
                id: item.Id
            };
        });
    }

}]);