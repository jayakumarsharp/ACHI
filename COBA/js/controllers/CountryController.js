ReportApp.controller('CountryController', function ($scope, $rootScope, CountryService, toaster, $timeout) {
    $scope.CountryList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = false;

    $scope.GetAllCountry = function () {
        CountryService.GetAllCountry().success(function (data) {

            for (var j = 0; j < data.length; j++) {
                try {
                    if (data[j].TaskName == 'NA') {
                        data.splice(j, 1);
                        break;
                    }
                }
                catch (e) {
                    console.log('some error while sending data to server')
                }
            }

            $scope.CountryList = data;
            $scope.CountryGrid.api.setRowData($scope.CountryList);
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    var columnDefs = [{ headerName: '', hide: true, field: 'CountryId', width: 1 },
        { headerName: 'TaskName', field: 'TaskName', width: 305 },
        {
            headerName: 'Action', cellStyle: { 'text-align': 'center', 'display': 'flex', 'align-items': 'center' }, cellRenderer: function (params) {
                if (params.data.TaskName != 'NA')
                    return "</span><a data-ng-click=\"GetCountryById('" + params.data.CountryId + "')\" href=\"javascript:;\" ng-show=\"!IsReadOnly\"> Edit</a>   &nbsp;&nbsp;| &nbsp;&nbsp;</span><a data-ng-click=\"showconfirm('" + params.data.CountryId + "')\" href=\"javascript:;\" ng-show=\"!IsReadOnly\"> Delete</a>";
                    //return "</span><a data-ng-click=\"GetAllCountry()\" href=\"javascript:;\" ng-show=\"!IsReadOnly\"> Edit</a>   &nbsp;&nbsp;| &nbsp;&nbsp;</span><a data-ng-click=\"showconfirm('" + params.data.CountryId + "')\" href=\"javascript:;\" ng-show=\"!IsReadOnly\"> Delete</a>";
                else
                    return '';
            }
        }];

    $rootScope.$on("toggle", function () {
        //jay
        $timeout(function () {
            $scope.CountryGrid.api.sizeColumnsToFit();
        }, 1000);
    });


    $scope.CountryGrid = {
        angularCompileRows: true,
        columnDefs: columnDefs,
        rowData: $scope.CountryList,
        suppressCellSelection: true,
        suppressHorizontalScroll: true,
        onGridReady: function (event) {
            $scope.GetAllCountry();
            $scope.CountryGrid.api.sizeColumnsToFit();
        },
    };

    $scope.add = function (Country) {
        if (Country != null) {
            if (Country.TaskName.trim()) {
                CountryService.AddCountry(Country).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {

                        $scope.Country = null;
                        $scope.GetAllCountry();
                        $scope.editMode = false;
                        toaster.pop('success', "Success", 'Country added successfully', null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Country! " + data.ExceptionMessage;
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

    $scope.GetCountryById = function (CountryId) {
        CountryService.GetAllCountryById(CountryId).success(function (data) {
            $scope.editMode = true;
            $scope.Country = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding Country! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function () {
        var crc = { CountryId: $scope.CountryId };
        CountryService.DeleteCountry(crc).success(function (data) {
            $scope.Country = null;
            $scope.editMode = false;
            $scope.GetAllCountry();
            $('#confirmModal').modal('hide');
            toaster.pop('success', "Success", 'Country deleted successfully', null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.UpdateCountry= function (model) {
        if (model != null) {
            if (model.TaskName.trim()) {
                CountryService.ModifyCountry(model).success(function (data) {
                    $scope.editMode = false;
                    $scope.Country = null;
                    $scope.GetAllCountry();
                    toaster.pop('success', "Success", 'Country updated successfully', null);
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding Country! " + data.ExceptionMessage;
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
        $scope.CountryId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.Country = null;
        $scope.editMode = false;
    };

});