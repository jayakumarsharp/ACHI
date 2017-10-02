ReportApp.controller('BusinessSectorMasterController', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster) {
    $scope.BusinessSectorMasterList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllBusinessSectorMaster = function () {
        ApiCall.MakeApiCall("GetAllBusinessSector?BusinessSectorId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.BusinessSectorMasterList = data;
            $scope.BusinessSectorMasterGrid.data = $scope.BusinessSectorMasterList;
        }).error(function (error) {
            $scope.Error = error;
        })
    };


    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.BusinessSectorMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.BusinessSectorMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: [],
    };

    $scope.add = function (BusinessSectorMaster) {
        if (BusinessSectorMaster != null) {
            if (BusinessSectorMaster.BusinessSectorName.trim()) {
                ApiCall.MakeApiCall("AddBusinessSector", 'POST', BusinessSectorMaster).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {

                        $scope.BusinessSectorMaster = null;
                        $scope.GetAllBusinessSectorMaster();
                        $scope.editMode = false;
                        toaster.pop('success', "Success", 'Business Sector added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding BusinessSectorMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter Business Sector', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Business Sector', null);
        }

    };

    $scope.GetBusinessSectorMasterById = function (BusinessSectorMasterId) {
        ApiCall.MakeApiCall("GetAllBusinessSector?BusinessSectorId=" + BusinessSectorMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.BusinessSectorMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding Business Sector! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteBusinessSector?BusinessSectorId=" + $scope.BusinessSectorMasterId, 'GET', '').success(function (data) {
            $scope.BusinessSectorMaster = null;
            $scope.editMode = false;
            $scope.GetAllBusinessSectorMaster();
            $('#confirmModal').modal('hide');
            toaster.pop('success', "Success", 'Business Sector deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting Business Sector! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateBusinessSectorMaster = function (model) {
        if (model != null) {
            if (model.BusinessSectorName.trim()) {
                ApiCall.MakeApiCall("ModifyBusinessSector", 'POST', model).success(function (data) {
                    $scope.editMode = false;
                    $scope.BusinessSectorMaster = null;
                    $scope.GetAllBusinessSectorMaster();
                    toaster.pop('success', "Success", 'Business Sector updated successfully', null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding BusinessSectorMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter Business Sector', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Business Sector', null);
        }
    };


    $scope.showconfirm = function (data) {
        $scope.BusinessSectorMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.BusinessSectorMaster = null;
        $scope.editMode = false;
    };

    $scope.GetRightsList = function () {

        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Business Sector Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }

                    var columnDefs = [{ name: 'Id', visible: false },
                        { name: 'BusinessSectorName' },
                        {
                            name: 'Action'
                            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetBusinessSectorMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'
                            , visible: !$scope.IsReadOnly
                        }];
                    $scope.BusinessSectorMasterGrid.columnDefs = columnDefs;

                    $scope.GetAllBusinessSectorMaster();

                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();


});