ReportApp.controller('FTAApplicationMappingController', ['$scope', '$rootScope', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.data = [];
    $scope.showAddwindow = false;
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('FTAApplicationName').withTitle('FTAApplication Name'),
        DTColumnBuilder.newColumn('FTAApplicationCode').withTitle('FTAApplication Code'),
        DTColumnBuilder.newColumn('ChildIdValue').withTitle('ChildId'),
        DTColumnBuilder.newColumn('ThirdPartyAppName').withTitle('ThirdParty'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }



    function actionsHtml(data, type, full, meta) {
        return '<a  ng-click="delete(' + data + ')"><img src="images/delete.png"></a> ';
    }


    $scope.Showadd = function () {
        $scope.showAddwindow = true;
    }


    $scope.GetAllFTAApplicationMaster = function () {
        ApiCall.MakeApiCall("GetAllFTAApplicationMapping?FTAApplicationId=", 'GET', '').success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data

        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllFTAApplicationCode?FTAApplicationCodeId=", 'GET', '').success(function (data) {
            $scope.FTAApplicationCodeList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllChildID?ChildIDId=", 'GET', '').success(function (data) {
            $scope.ChildIDList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllFTAApplicationName?FTAApplicationNameId=", 'GET', '').success(function (data) {
            $scope.FTAApplicationNameList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllThirdPartyAppList?Id=", 'GET', '').success(function (data) {
            $scope.ThirdPartyList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
    };


    $scope.add = function (FTAApplicationMaster) {
        if (FTAApplicationMaster != null) {
            if (FTAApplicationMaster.FTAApplicationName.FTAApplicationName && FTAApplicationMaster.FTAApplicationCode.FTAApplicationCode && FTAApplicationMaster.ChildID.ChildID && FTAApplicationMaster.ThirdPartyApp.Value) {
                var input = { FTAApplicationNameId: FTAApplicationMaster.FTAApplicationName.Id, FTAApplicationCodeId: FTAApplicationMaster.FTAApplicationCode.Id, ChildID: FTAApplicationMaster.ChildID.Id, ThirdPartyAppId: FTAApplicationMaster.ThirdPartyApp.Id };

                ApiCall.MakeApiCall("AddFTAApplicationMapping", 'POST', input).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {
                        $scope.FTAApplicationMaster = null;
                        $scope.GetAllFTAApplicationMaster();
                        $scope.editMode = false;

                        $scope.showAddwindow = false;
                        toaster.pop('success', "Success", 'FTAApplication added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding FTAApplication ! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter FTAApplication', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter FTAApplication', null);
        }

    };

    $scope.GetFTAApplicationMasterById = function (FTAApplicationMasterId) {
        ApiCall.MakeApiCall("GetAllFTAApplication?FTAApplicationId=" + FTAApplicationMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.showAddwindow = true;
            $scope.FTAApplicationMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding FTAApplication! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function (id) {
        ApiCall.MakeApiCall("DeleteFTAApplicationMapping?Id=" + id, 'GET', '').success(function (data) {
            $scope.FTAApplicationMaster = null;
            $scope.editMode = false;
            $scope.GetAllFTAApplicationMaster();
            $('#confirmModal').modal('hide');
            $scope.showAddwindow = false;
            toaster.pop('success', "Success", 'FTAApplication deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    //$scope.UpdateFTAApplicationMaster = function (model) {
    //    if (model != null) {
    //        if (model.FTAApplication.trim() != "") {
    //            ApiCall.MakeApiCall("ModifyFTAApplication", 'POST', model).success(function (data) {
    //                $scope.editMode = false;
    //                $scope.FTAApplicationMaster = null;
    //                $scope.GetAllFTAApplicationMaster();
    //                $scope.showAddwindow = false;
    //                toaster.pop('success', "Success", 'FTAApplicationMaster updated successfully', null);
    //            }).error(function (data) {
    //                $scope.error = "An Error has occured while Adding FTAApplicationMaster! " + data.ExceptionMessage;
    //            });
    //        }
    //        else {
    //            toaster.pop('warning', "Warning", 'Please enter FTAApplication', null);
    //        }
    //    }
    //    else {
    //        toaster.pop('warning', "Warning", 'Please enter FTAApplication', null);
    //    }
    //};



    $scope.showconfirm = function (data) {
        $scope.FTAApplicationMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.FTAApplicationMaster = null;
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
                        if (value.RightName == 'FTAApplication Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                    $scope.GetAllFTAApplicationMaster();
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();

}]);