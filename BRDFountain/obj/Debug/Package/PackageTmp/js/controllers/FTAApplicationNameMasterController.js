ReportApp.controller('LTAApplicationNameMasterController', ['$scope', '$rootScope', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', 'StrategyService', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder, StrategyService) {
    $scope.data = [];
    $scope.showAddwindow = false;
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('LTAApplicationName').withTitle('LTA Application Name'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        if ($scope.IsReadOnly) {
            return "-";
        }
        else {
            $scope.data = data;
            return '<a  ng-click="GetLTAApplicationNameMasterById(' + data + ')"><img src="images/edit.png"></a> ';
            //+'<button class="btn btn-danger" ng-click="delete(' + data + ')" )"="">' +
            //'   <i class="fa fa-trash-o"></i>' +
            //'</button>';
        }
    }

    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.Showadd = function () {
        $scope.showAddwindow = true;
    }


    $scope.GetAllLTAApplicationNameMaster = function () {
        ApiCall.MakeApiCall("GetAllLTAApplicationName?LTAApplicationNameId=", 'GET', '').success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data;
            StrategyService.HideLoader();
        }).error(function (error) {
            $scope.Error = error;
        })
    };


    $scope.add = function (LTAApplicationNameMaster) {
        if (LTAApplicationNameMaster != null) {
            if (LTAApplicationNameMaster.LTAApplicationName.trim() != "") {
                ApiCall.MakeApiCall("AddLTAApplicationName", 'POST', LTAApplicationNameMaster).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {
                        if (data == "success") {
                            $scope.LTAApplicationNameMaster = null;
                            $scope.GetAllLTAApplicationNameMaster();
                            $scope.editMode = false;

                            $scope.showAddwindow = false;
                            toaster.pop('success', "Success", 'LTA Application Name added successfully', null);
                        }
                        else
                            toaster.pop('warning', "Warning", data, null);

                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding LTA ApplicationName ! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter LTA Application Name', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter LTA Application Name', null);
        }

    };

    $scope.GetLTAApplicationNameMasterById = function (LTAApplicationNameMasterId) {
        ApiCall.MakeApiCall("GetAllLTAApplicationName?LTAApplicationNameId=" + LTAApplicationNameMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.showAddwindow = true;
            $scope.LTAApplicationNameMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding LTAApplicationName! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteLTAApplicationName?LTAApplicationNameId=" + $scope.LTAApplicationNameMasterId, 'GET', '').success(function (data) {
            $scope.LTAApplicationNameMaster = null;
            $scope.editMode = false;
            $scope.GetAllLTAApplicationNameMaster();
            $('#confirmModal').modal('hide');
            $scope.showAddwindow = false;
            toaster.pop('success', "Success", 'LTA Application Name deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    $scope.UpdateLTAApplicationNameMaster = function (model) {
        if (model != null) {
            if (model.LTAApplicationName.trim() != "") {
                ApiCall.MakeApiCall("ModifyLTAApplicationName", 'POST', model).success(function (data) {
                    if (data == "success") {
                        $scope.editMode = false;
                        $scope.LTAApplicationNameMaster = null;
                        $scope.GetAllLTAApplicationNameMaster();
                        $scope.showAddwindow = false;
                        toaster.pop('success', "Success", 'LTA Application Name updated successfully', null);
                    }
                    else
                        toaster.pop('warning', "Warning", data, null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding LTA Application Name Master! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter LTA Application Name', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter LTA ApplicationName', null);
        }
    };



    $scope.showconfirm = function (data) {
        $scope.LTAApplicationNameMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.LTAApplicationNameMaster = null;
        $scope.editMode = false;
        $scope.showAddwindow = false;
        $('#confirmModal').modal('hide');
    };

    $scope.GetRightsList = function () {
        StrategyService.ShowLoader();
        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        //if (value.RightName == 'LTAApplicationName Write') {
                        if (value.RightName == 'Master Data Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                    $scope.GetAllLTAApplicationNameMaster();
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();

}]);