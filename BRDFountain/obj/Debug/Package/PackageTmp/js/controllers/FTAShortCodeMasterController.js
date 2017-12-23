ReportApp.controller('FTAShortCodeMasterController', ['$scope', '$rootScope', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.data = [];
    $scope.showAddwindow = false;
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('FTAShortCode').withTitle('FTAShortCode'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
    }



    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        return '<a  ng-click="GetFTAShortCodeMasterById(' + data + ')"><img src="../images/edit.png"></a> ';
        //+'<button class="btn btn-danger" ng-click="delete(' + data + ')" )"="">' +
        //'   <i class="fa fa-trash-o"></i>' +
        //'</button>';
    }

    $scope.editMode = false;
    $scope.IsReadOnly = false;
    $scope.Showadd = function () {
        $scope.showAddwindow = true;
    }


    $scope.GetAllFTAShortCodeMaster = function () {
        ApiCall.MakeApiCall("GetAllFTAShortCode?FTAShortCodeId=", 'GET', '').success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data
        }).error(function (error) {
            $scope.Error = error;
        })
    };


    $scope.add = function (FTAShortCodeMaster) {
        if (FTAShortCodeMaster != null) {
            if (FTAShortCodeMaster.FTAShortCode.trim() != "") {
                ApiCall.MakeApiCall("AddFTAShortCode", 'POST', FTAShortCodeMaster).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {
                        $scope.FTAShortCodeMaster = null;
                        $scope.GetAllFTAShortCodeMaster();
                        $scope.editMode = false;

                        $scope.showAddwindow = false;
                        toaster.pop('success', "Success", 'FTAShortCode added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding FTAShortCode ! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter FTAShortCode', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter FTAShortCode', null);
        }

    };

    $scope.GetFTAShortCodeMasterById = function (FTAShortCodeMasterId) {
        ApiCall.MakeApiCall("GetAllFTAShortCode?FTAShortCodeId=" + FTAShortCodeMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.showAddwindow = true;
            $scope.FTAShortCodeMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding FTAShortCode! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteFTAShortCode?FTAShortCodeId=" + $scope.FTAShortCodeMasterId, 'GET', '').success(function (data) {
            $scope.FTAShortCodeMaster = null;
            $scope.editMode = false;
            $scope.GetAllFTAShortCodeMaster();
            $('#confirmModal').modal('hide');
            $scope.showAddwindow = false;
            toaster.pop('success', "Success", 'FTAShortCode deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    $scope.UpdateFTAShortCodeMaster = function (model) {
        if (model != null) {
            if (model.FTAShortCode.trim() != "") {
                ApiCall.MakeApiCall("ModifyFTAShortCode", 'POST', model).success(function (data) {
                    $scope.editMode = false;
                    $scope.FTAShortCodeMaster = null;
                    $scope.GetAllFTAShortCodeMaster();
                    $scope.showAddwindow = false;
                    toaster.pop('success', "Success", 'FTAShortCodeMaster updated successfully', null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding FTAShortCodeMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter FTAShortCode', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter FTAShortCode', null);
        }
    };



    $scope.showconfirm = function (data) {
        $scope.FTAShortCodeMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.FTAShortCodeMaster = null;
        $scope.editMode = false;
        $scope.showAddwindow = false;
        $('#confirmModal').modal('hide');
    };

    $scope.GetRightsList = function () {
        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'FTAShortCode Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                    $scope.GetAllFTAShortCodeMaster();
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();

}]);