ReportApp.controller('ApplicationMasterController', function ($scope, $rootScope, $timeout, ApiCall) {
    $scope.ApplicationMasterList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllApplicationMaster = function () {
        ApiCall.MakeApiCall("GetAllApplication?ApplicationId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.ApplicationMasterList = data;
            $scope.ApplicationMasterGrid.data = $scope.ApplicationMasterList;
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    var columnDefs = [{ name: 'Id', visible: $scope.IsReadOnly },
        { name: 'ApplicationId' },
        { name: 'ApplicationName' },
                {
                    name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetApplicationMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'

                },

    ];

    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.ApplicationMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.ApplicationMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,
    };

    $scope.add = function (ApplicationMaster) {
        if (ApplicationMaster != null) {
            //if (ApplicationMaster.TaskName.trim()) {
            ApiCall.MakeApiCall("AddApplication", 'POST', ApplicationMaster).success(function (data) {
                if (data.Error != undefined) {
                    //toaster.pop('error', "Error", data.Error, null);
                } else {

                    $scope.ApplicationMaster = null;
                    $scope.GetAllApplicationMaster();
                    $scope.editMode = false;
                    //toaster.pop('success', "Success", 'ApplicationMaster added successfully', null);
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding ApplicationMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //    //toaster.pop('warning', "Warning", 'Please enter ApplicationMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter ApplicationMaster', null);
        }

    };

    $scope.GetApplicationMasterById = function (ApplicationMasterId) {
        ApiCall.MakeApiCall("GetAllApplication?ApplicationId=" + ApplicationMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.ApplicationMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding ApplicationMaster! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteApplication?ApplicationId=" + $scope.ApplicationMasterId, 'GET', '').success(function (data) {
            $scope.ApplicationMaster = null;
            $scope.editMode = false;
            $scope.GetAllApplicationMaster();
            $('#confirmModal').modal('hide');
            //toaster.pop('success', "Success", 'ApplicationMaster deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateApplicationMaster = function (model) {
        if (model != null) {
            //if (model.TaskName.trim()) {
            ApiCall.MakeApiCall("ModifyApplication", 'POST', model).success(function (data) {
                $scope.editMode = false;
                $scope.ApplicationMaster = null;
                $scope.GetAllApplicationMaster();
                //toaster.pop('success', "Success", 'ApplicationMaster updated successfully', null);
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding ApplicationMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //toaster.pop('warning', "Warning", 'Please enter ApplicationMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter ApplicationMaster', null);
        }
    };

    $scope.GetAllApplicationMaster();

    $scope.showconfirm = function (data) {
        $scope.ApplicationMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.ApplicationMaster = null;
        $scope.editMode = false;
    };

    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Application Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };
    $scope.GetRightsList();
});