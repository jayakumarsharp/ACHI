ReportApp.controller('TaskController', ['$scope', '$rootScope', 'TaskService', '$timeout', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, TaskService, $timeout, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.errorinfo = '';
    $scope.showaction = false;
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.LockedPriceSheet = [];
    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };

    $scope.getAllTasks = function () {

        TaskService.GetAllTask().success(function (data) {
            console.log(data)
            $scope.dtOptions.data = data;;
        })
    };
    $scope.getAllTasks();
    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });
    $scope.dtOptions = DTOptionsBuilder.fromSource()
    .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('Name').withTitle('Name'),
        DTColumnBuilder.newColumn('Id').withTitle('Action').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        return '<a  ng-click="GetCurrencyConversionForId(' + data + ')"><img src="images/edit.png"></a> ';
    }

    $scope.showadd = function () {
        $scope.showaction = true;
        $timeout(function () {
            $scope.TaskActive = false;
            $scope.IsSignOff = false;
        }, 100);
        $scope.errorinfo = '';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.currency.CurrencyDescrition = '';
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
                    $scope.showaction = false;
                    $scope.getAllTasks()
                }
                else
                    $scope.errorinfo = data;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        $scope.showaction = true;
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
            $scope.currency = data[0];
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
                $scope.showaction = false;
                $scope.getAllTasks()
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
        $('#currencyModel').modal('hide');
        $scope.showaction = false;
    };

    $scope.updatecancel = function (data) {
        TaskService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.currency = data[0];
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
            $scope.currency.CurrencyDescrition = currDesc;
        }
        else {
            $scope.currency.CurrencyDescrition = '';
        }
    };

    $scope.GetRightsList();

}]);