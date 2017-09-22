ReportApp.controller('ProductMasterController', function ($scope, $rootScope, $timeout, ApiCall) {
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

    var columnDefs = [{ name: 'Id' },
        //{ name: 'ProductId' },
        { name: 'ProductName' },

        {
            name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetProductMasterById(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'

        },

    ];

    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.ProductMasterGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.ProductMasterGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,
    };

    $scope.add = function (ProductMaster) {
        if (ProductMaster != null) {
            //if (ProductMaster.TaskName.trim()) {
            ApiCall.MakeApiCall("AddProductType", 'POST', ProductMaster).success(function (data) {
                if (data.Error != undefined) {
                    //toaster.pop('error', "Error", data.Error, null);
                } else {

                    $scope.ProductMaster = null;
                    $scope.GetAllProductMaster();
                    $scope.editMode = false;
                    //toaster.pop('success', "Success", 'ProductMaster added successfully', null);
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding ProductMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //    //toaster.pop('warning', "Warning", 'Please enter ProductMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter ProductMaster', null);
        }

    };

    $scope.GetProductMasterById = function (ProductMasterId) {
        ApiCall.MakeApiCall("GetAllProductType?ProductTypeId=" + ProductMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.ProductMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding ProductMaster! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        ApiCall.MakeApiCall("DeleteProductType?ProductTypeId=" + $scope.ProductMasterId, 'GET', '').success(function (data) {
            $scope.ProductMaster = null;
            $scope.editMode = false;
            $scope.GetAllProductMaster();
            $('#confirmModal').modal('hide');
            //toaster.pop('success', "Success", 'ProductMaster deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateProductMaster = function (model) {
        if (model != null) {
            //if (model.TaskName.trim()) {
            ApiCall.MakeApiCall("ModifyProductType", 'POST', model).success(function (data) {
                $scope.editMode = false;
                $scope.ProductMaster = null;
                $scope.GetAllProductMaster();
                //toaster.pop('success', "Success", 'ProductMaster updated successfully', null);
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding ProductMaster! " + data.ExceptionMessage;
            });
            //}
            //else {
            //toaster.pop('warning', "Warning", 'Please enter ProductMaster', null);
            //}
        }
        else {
            //toaster.pop('warning', "Warning", 'Please enter ProductMaster', null);
        }
    };

    $scope.GetAllProductMaster();

    $scope.showconfirm = function (data) {
        $scope.ProductMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.ProductMaster = null;
        $scope.editMode = false;
    };

});