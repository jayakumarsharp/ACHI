ReportApp.controller('ProductMasterController', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster) {
    $scope.ProductMasterList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllProductMaster = function () {
        ApiCall.MakeApiCall("GetAllProductType?ProductTypeId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.ProductMasterList = data;
            $scope.ProductMasterGrid.data = $scope.ProductMasterList;
        }).error(function (error) {
            $scope.Error = error;
        })
    };



    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.ProductMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.ProductMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: [],
    };

    $scope.add = function (ProductMaster) {
        if (ProductMaster != null) {
            if (ProductMaster.ProductName.trim() != "") {
                ApiCall.MakeApiCall("AddProductType", 'POST', ProductMaster).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {

                        $scope.ProductMaster = null;
                        $scope.GetAllProductMaster();
                        $scope.editMode = false;
                        toaster.pop('success', "Success", 'Product added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding ProductMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter Product', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Product', null);
        }

    };

    $scope.GetProductMasterById = function (ProductMasterId) {
        ApiCall.MakeApiCall("GetAllProductType?ProductTypeId=" + ProductMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.ProductMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding Product! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteProductType?ProductTypeId=" + $scope.ProductMasterId, 'GET', '').success(function (data) {
            $scope.ProductMaster = null;
            $scope.editMode = false;
            $scope.GetAllProductMaster();
            $('#confirmModal').modal('hide');
            toaster.pop('success', "Success", 'ProductMaster deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateProductMaster = function (model) {
        if (model != null) {
            if (model.ProductName.trim() != "") {
                ApiCall.MakeApiCall("ModifyProductType", 'POST', model).success(function (data) {
                    $scope.editMode = false;
                    $scope.ProductMaster = null;
                    $scope.GetAllProductMaster();
                    toaster.pop('success', "Success", 'Product updated successfully', null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding ProductMaster! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter ProductMaster', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter Product', null);
        }
    };


    $scope.showconfirm = function (data) {
        $scope.ProductMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.ProductMaster = null;
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
                        if (value.RightName == 'Product Type Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                    var columnDefs = [{ name: 'Id', visible: false }, { name: 'ProductName' }, {
                        name: 'Action'
                       , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetProductMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'
                       , visible: !$scope.IsReadOnly
                    }];
                    $scope.ProductMasterGrid.columnDefs = columnDefs;
                    $scope.GetAllProductMaster();

                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
    $scope.GetRightsList();



});