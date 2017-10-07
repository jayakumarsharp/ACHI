ReportApp.controller('CountryMasterController', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster) {
    $scope.CountryMasterList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllCountryMaster = function () {
        ApiCall.MakeApiCall("GetAllCountry?CountryId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.CountryMasterList = data;
            $scope.CountryMasterGrid.data = $scope.CountryMasterList;
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.CountryMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.CountryMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: [],
    };

    $scope.add = function (CountryMaster) {
        if (CountryMaster != null) {
            if (CountryMaster.CountryName.trim() != "") {
                ApiCall.MakeApiCall("AddCountry", 'POST', CountryMaster).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {

                        $scope.CountryMaster = null;
                        $scope.GetAllCountryMaster();
                        $scope.editMode = false;
                        toaster.pop('success', "Success", 'Country added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Country ! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter Country', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Country', null);
        }

    };

    $scope.GetCountryMasterById = function (CountryMasterId) {
        ApiCall.MakeApiCall("GetAllCountry?CountryId=" + CountryMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.CountryMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding Country! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteCountry?CountryId=" + $scope.CountryMasterId, 'GET', '').success(function (data) {
            $scope.CountryMaster = null;
            $scope.editMode = false;
            $scope.GetAllCountryMaster();
            $('#confirmModal').modal('hide');
            toaster.pop('success', "Success", 'Country deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateCountryMaster = function (model) {
        if (model != null) {
            if (model.CountryName.trim() != "") {
                ApiCall.MakeApiCall("ModifyCountry", 'POST', model).success(function (data) {
                    $scope.editMode = false;
                    $scope.CountryMaster = null;
                    $scope.GetAllCountryMaster();
                    toaster.pop('success', "Success", 'CountryMaster updated successfully', null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding CountryMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter Country', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Country', null);
        }
    };



    $scope.showconfirm = function (data) {
        $scope.CountryMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.CountryMaster = null;
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
                        if (value.RightName == 'Country Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }

                    var columnDefs = [{ name: 'Id', visible: false },
                        { name: 'CountryName', displayName: 'Country Name', width: '*' },
                        {
                            name: 'Action'
                            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCountryMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'
                            , visible: !$scope.IsReadOnly, width: 150
                        }];


                    $scope.CountryMasterGrid.columnDefs = columnDefs;
                    $scope.GetAllCountryMaster();
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();


});