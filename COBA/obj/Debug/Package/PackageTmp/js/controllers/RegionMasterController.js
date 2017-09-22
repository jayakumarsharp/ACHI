ReportApp.controller('RegionMasterController', function ($scope, $rootScope, $timeout, ApiCall) {
    $scope.RegionMasterList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllRegionMaster = function () {
        ApiCall.MakeApiCall("GetAllRegion?RegionId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.RegionMasterList = data;
            $scope.RegionMasterGrid.data = $scope.RegionMasterList;
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    var columnDefs = [{ name: 'Id' },
        //{ name: 'RegionId' },
        { name: 'RegionName' },

        {
            name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetRegionMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'

        },

    ];

    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.RegionMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.RegionMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,
    };

    $scope.add = function (RegionMaster) {
        if (RegionMaster != null) {
            //if (RegionMaster.TaskName.trim()) {
            ApiCall.MakeApiCall("AddRegion", 'POST', RegionMaster).success(function (data) {
                if (data.Error != undefined) {
                    //toaster.pop('error', "Error", data.Error, null);
                } else {

                    $scope.RegionMaster = null;
                    $scope.GetAllRegionMaster();
                    $scope.editMode = false;
                    //toaster.pop('success', "Success", 'RegionMaster added successfully', null);
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding RegionMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //    //toaster.pop('warning', "Warning", 'Please enter RegionMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter RegionMaster', null);
        }

    };

    $scope.GetRegionMasterById = function (RegionMasterId) {
        ApiCall.MakeApiCall("GetAllRegion?RegionId=" + RegionMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.RegionMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding RegionMaster! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteRegion?RegionId=" + $scope.RegionMasterId, 'GET', '').success(function (data) {
            $scope.RegionMaster = null;
            $scope.editMode = false;
            $scope.GetAllRegionMaster();
            $('#confirmModal').modal('hide');
            //toaster.pop('success', "Success", 'RegionMaster deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateRegionMaster = function (model) {
        if (model != null) {
            //if (model.TaskName.trim()) {
            ApiCall.MakeApiCall("ModifyRegion", 'POST', model).success(function (data) {
                $scope.editMode = false;
                $scope.RegionMaster = null;
                $scope.GetAllRegionMaster();
                //toaster.pop('success', "Success", 'RegionMaster updated successfully', null);
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding RegionMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //toaster.pop('warning', "Warning", 'Please enter RegionMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter RegionMaster', null);
        }
    };

    $scope.GetAllRegionMaster();

    $scope.showconfirm = function (data) {
        $scope.RegionMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.RegionMaster = null;
        $scope.editMode = false;
    };

});