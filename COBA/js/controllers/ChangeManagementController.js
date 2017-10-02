ReportApp.controller('TaskController', function ($scope, $rootScope, StrategyService, TaskService, $timeout, $filter, UserFactory, reportFactory, ApiCall) {
    $scope.errorinfo = '';
    $scope.CurrencyList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.ecurrency = {};

    $scope.selectModel = { Application: {}, Country: {}, ProductType: {}, BusinessSector: {}, Region: {} };

    $scope.GetRightsList = function () {

        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Change Management Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };

    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];
    $scope.Selcurrentversion = 0;
    $scope.GetAllStrategy = function () {
        StrategyService.GetAllCurrencyConversion().success(function (data) {
            $scope.Strategydata = data;
        })

        ApiCall.MakeApiCall("GetAllApplication?ApplicationId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.ApplicationMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllBusinessSector?BusinessSectorId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.BusinessSectorMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllCountry?CountryId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.CountryMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllProductType?ProductTypeId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.ProductMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })


        ApiCall.MakeApiCall("GetAllRegion?RegionId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.RegionMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

    };

    $scope.GetAllStrategy();

    $scope.GetVersions = function (data) {
        if (data != undefined) {
            StrategyService.GetStrategyDatabyStrategyId(data).success(function (data) {
                $scope.StrategyVersiondata = data;
                $scope.currency = $filter('orderBy')($scope.StrategyVersiondata, '-Version')[0];
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }
                $scope.CurrencyGrid.data = data;
            })
        }
    };


    $scope.notificationExist = false;
    $scope.notificationdata = [];

    $scope.GetCurrencyConversionForIdView = function (id, Version) {
        $scope.ViewData = [];
        StrategyService.GetStrategyApprovalById(id, Version).success(function (data) {
            $('#currencyModel1').modal('show');
            $scope.ViewData = data;

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };


    $scope.GetVersionDataview = function (id, RefNumber, Version) {
        $('#currencyModel').modal('show');

        $scope.GetCurrencyConversionForId(id);
        StrategyService.GetStrategyApprovalById(RefNumber, Version).success(function (data) {
            console.log(data);
            $scope.Availableusers = data;
            for (var i = 0; i < data.length; i++) {
                data[i].Id = i;
            }
            var adata = [{ RefNumber: '', Approver: 'Daniel', Id: 1 }, { RefNumber: '', Approver: 'George', Id: 2 }, { RefNumber: '', Approver: 'John', Id: 3 }, { RefNumber: '', Approver: 'Sivakumar', Id: 4 }, { RefNumber: '', Approver: 'Oliver', Id: 5 }]
            $scope.aEstimationProduct = adata;
            $scope.EstimationProduct = data;
            $scope.listB_Estimation = [];
            var temp = JSON.parse(JSON.stringify($scope.aEstimationProduct));
            for (i = 0; i < $scope.EstimationProduct.length; i++) {
                $scope.listB_Estimation.push({ 'Approver': $scope.EstimationProduct[i].Approver, 'Id': $scope.EstimationProduct[i].Id });
                var delId = arrayObjectEstimationProductIndexOf(temp, $scope.EstimationProduct[i].Approver);
                temp.splice(delId, 1);
            }
            $scope.listA_Estimation = temp;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

        StrategyService.GetStrategyApprovalByuser().success(function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].RefNumber == RefNumber && data[i].Version == Version) {
                    $scope.notificationdata = data[i];
                    $scope.notificationExist = true;
                }
            }

        }).error(function (error) {
            $scope.Error = error;
        });

    }

    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    var columnDefs = [{ name: 'RefNumber', displayName: 'RefNumber', },
        { name: 'Ver', displayName: 'Version', },
        {
            displayName: 'IsActive', name: 'IsActive'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsActive=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsActive=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },

        {
            name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetVersionDataview(row.entity.Id,row.entity.RefNumber,row.entity.Version)" ><i class="fa fa-edit" ></i></a ></div>'
               , visible: $scope.IsReadOnly
        },
        {
            field: 'Approvals', width: 70, cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForIdView(row.entity.RefNumber,row.entity.Version)" ><i class="fa fa-eye" ></i></a ></div>'

        }
    ];


    $scope.CurrencyGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs,

    };

    $scope.GetAllCurrency = function () {
        TaskService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.add = function (currency) {
        if (currency != null) {
            if ($scope.TaskActive)
                currency.IsActive = "Y";
            else
                currency.IsActive = "N";

            if ($scope.IsSignOff)
                currency.IsSignOff = "Y";
            else
                currency.IsSignOff = "N";
            TaskService.AddTask(currency).success(function (data) {
                if (data == "success") {
                    $scope.editMode = false;
                    //toaster.pop('success', "Success", "Currency rate updated successfully", null);
                    $('#currencyModel').modal('hide');
                    $scope.getallcurrencyconversions()
                }
                else
                    $scope.errorinfo = data;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        StrategyService.GetDatabyId(id).success(function (data) {

            $scope.currency = data[0];

            $scope.selectModel.Application = $scope.GetRoleFromUserID($scope.currency.ApplicationId, "ApplicationMasterList")
            $scope.selectModel.Country = $scope.GetRoleFromUserID($scope.currency.Country, "CountryMasterList")
            $scope.selectModel.ProductType = $scope.GetRoleFromUserID($scope.currency.ProductType, "ProductMasterList")
            $scope.selectModel.BusinessSector = $scope.GetRoleFromUserID($scope.currency.BusinessSector, "BusinessSectorMasterList")
            $scope.selectModel.Region = $scope.GetRoleFromUserID($scope.currency.Region, "RegionMasterList")



            $('#currencyModel').modal('show');
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };

    $scope.GetRoleFromUserID = function (userId, type) {
        if ("BusinessSectorMasterList" == type) {
            for (var i = 0; i < $scope.BusinessSectorMasterList.length; i++) {
                if ($scope.BusinessSectorMasterList[i].Id == userId) {
                    return $scope.BusinessSectorMasterList[i];
                }
            }
        }
        else if ("RegionMasterList" == type) {
            for (var i = 0; i < $scope.RegionMasterList.length; i++) {
                if ($scope.RegionMasterList[i].Id == userId) {
                    return $scope.RegionMasterList[i];
                }
            }
        }
        if ("ProductMasterList" == type) {
            for (var i = 0; i < $scope.ProductMasterList.length; i++) {
                if ($scope.ProductMasterList[i].Id == userId) {
                    return $scope.ProductMasterList[i];
                }
            }
        }
        if ("CountryMasterList" == type) {
            for (var i = 0; i < $scope.CountryMasterList.length; i++) {
                if ($scope.CountryMasterList[i].Id == userId) {
                    return $scope.CountryMasterList[i];
                }
            }
        }
        if ("ApplicationMasterList" == type) {
            for (var i = 0; i < $scope.ApplicationMasterList.length; i++) {
                if ($scope.ApplicationMasterList[i].Id == userId) {
                    return $scope.ApplicationMasterList[i];
                }
            }
        }
    };

    $scope.SaveNewversionStrategy = function (currency) {
        if ($scope.StrategyActive)
            currency.IsActive = "Y";
        else
            currency.IsActive = "N";

        if ($scope.IsSignOff)
            currency.IsSignOff = "Y";
        else
            currency.IsSignOff = "N";

        currency.ApplicationId = $scope.selectModel.Application.Id;
        currency.Country = $scope.selectModel.Country.Id;
        currency.ProductType = $scope.selectModel.ProductType.Id;
        currency.BusinessSector = $scope.selectModel.BusinessSector.Id;
        currency.Region = $scope.selectModel.Region.Id;

        if (currency != null) {
            StrategyService.SaveNewversionStrategy(currency).success(function (data) {
                var split = [];
                if (data != null && data != '') {
                    split = data.split('|');
                }
                if (split[0] == "success") {
                    $scope.listB_Estimation[0].RefNumber = currency.RefNumber;
                    $scope.listB_Estimation[0].Version = split[1];
                    StrategyService.InsertStrategyApprover($scope.listB_Estimation).success(function (data) {

                    });


                    $('#currencyModel').modal('hide');
                }
                else
                    $scope.errorinfo = data;
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };
    $scope.Availableusers = [];
    $scope.UpdateChange = function (model) {
        model.Page = "C";
        StrategyService.UpdateStrategy(model).success(function (data) {
            if (data == "success") {
                if ($scope.listB_Estimation != null && $scope.listB_Estimation.length > 0) {
                    $scope.listB_Estimation[0].RefNumber = model.RefNumber;
                    $scope.listB_Estimation[0].Version = model.Version;

                    StrategyService.InsertStrategyApprover($scope.listB_Estimation).success(function (data) {

                    });
                }

                var temp = [];
                for (var j = 0; j < $scope.Availableusers.length; j++) {
                    var delId = arrayObjectEstimationProductIndexOf($scope.listB_Estimation, $scope.Availableusers[j].Approver);
                    if (delId < 0)
                        temp.push($scope.Availableusers[j])
                }

                if (temp.length > 0) {
                    StrategyService.DeleteStrategyApprover(temp).success(function (data) {

                    });
                }

                $scope.editMode = false;
                $('#currencyModel').modal('hide');
                $scope.getallcurrencyconversions()
            }
            else
                $scope.errorinfo = data;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };


    var formatDate = function (indate) {
        if (indate != null) {
            indateTime = indate.split('T');
            var date = new Date(indateTime[0]);
            var time = indateTime[1].substring(0, 8);
            return date.getMonth() + 1 + "/" + date.getDate() + "/" + date.getFullYear() + " " + time;
        }
        else {
            return '';
        }
    };

    $scope.showconfirm = function (data) {
        $scope.Id = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.ecurrency = {};
        $('#currencyModel').modal('hide');
    };

    $scope.updatecancel = function (data) {
        TaskService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };

    $scope.SetCurrencyDescription = function (currencyId) {
        if (currencyId != null && currencyId != '' && currencyId != undefined) {
            var currDesc = '';
            angular.forEach($scope.Currency, function (value, key) {
                if (value.Id == currencyId) {
                    currDesc = value.CurrencyDescrition;
                }
            })
            $scope.ecurrency.CurrencyDescrition = currDesc;
        }
        else {
            $scope.ecurrency.CurrencyDescrition = '';
        }
    };



    $scope.selectedA_Estimation = [];
    $scope.selectedB_Estimation = [];

    $scope.listA_Estimation = [];
    $scope.listB_Estimation = [];

    $scope.checkedA_Estimation = false;
    $scope.checkedB_Estimation = false;

    $scope.AvailableUser_Estimation = [];

    $scope.userfilter = function () {
        try {
            var Country = $scope.selectModel.Country.Id;
            var BusinessSector = $scope.selectModel.BusinessSector.Id;
            var Region = $scope.selectModel.Region.Id;
            if (Country != "" && BusinessSector != "" && Region != "") {
                ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + Country + "&RegionId=" + Region + "&BusinessSectorId=" + BusinessSector, 'GET', '').success(function (data) {
                    console.log(data);
                    $scope.listA_Estimation = [];
                    $scope.listB_Estimation = [];
                    $scope.EstimationProduct = [];
                    for (var k = 0; k < data.length; k++) {
                        $scope.EstimationProduct.push({ Approver: data[k].userId });
                    }
                    //var data = [{ RefNumber: '', Approver: 'Daniel', Id: 1 }, { RefNumber: '', Approver: 'George', Id: 2 }, { RefNumber: '', Approver: 'John', Id: 3 }, { RefNumber: '', : 'Sivakumar', Id: 4 }, { RefNumber: '', Approver: 'Oliver', Id: 5 }]

                    var temp = JSON.parse(JSON.stringify($scope.EstimationProduct));
                    for (i = 0; i < $scope.AvailableUser_Estimation.length; i++) {
                        $scope.listB_Estimation.push({ 'Approver': $scope.AvailableUser_Estimation[i].Approver, 'Id': $scope.AvailableUser_Estimation[i].Id });
                        var delId = arrayObjectEstimationProductIndexOf(temp, $scope.AvailableUser_Estimation[i].Approver);
                        temp.splice(delId, 1);
                    }
                    $scope.listA_Estimation = temp;
                }).error(function (error) {
                    $scope.Error = error;
                })
            }
        }
        catch (e) {
        }
    }
    $scope.gettask = function () {
        try {
            //var Country = $scope.selectModel.Country.Id;
            //var BusinessSector = $scope.selectModel.BusinessSector.Id;
            //var Region = $scope.selectModel.Region.Id;
            //if (Country != "" && BusinessSector != "" && Region != "") {
            //    ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + Country + "&RegionId=" + Region + "&BusinessSectorId=" + BusinessSector, 'GET', '').success(function (data) {
            //        console.log(data);
            //        $scope.ApplicationMasterList = data;
            //    }).error(function (error) {
            //        $scope.Error = error;
            //    })
            //}


        }
        catch (e) {

        }
    };

    $scope.gettask();

    $scope.AlltoA_Estimation = function () {
        $scope.selectedB_Estimation = [];
        angular.forEach($scope.listB_Estimation, function (value, key) {
            $scope.selectedB_Estimation.push(value.Approver);
        })
        $scope.bToA_Estimation();
    }
    $scope.AlltoB_Estimation = function () {
        $scope.selectedA_Estimation = [];
        angular.forEach($scope.listA_Estimation, function (value, key) {
            $scope.selectedA_Estimation.push(value.Approver);
        })
        $scope.aToB_Estimation();
    }

    function arrayObjectEstimationProductIndexOf(myArray, searchTerm) {
        for (var i = 0, len = myArray.length; i < len; i++) {
            if (myArray[i].Approver == searchTerm) {
                return i;
            }
        }
        return -1;
    }

    $scope.aToB_Estimation = function () {
        var items = JSON.parse(JSON.stringify($scope.EstimationProduct));
        console.log('a to b');
        for (var i = 0; i < $scope.selectedA_Estimation.length; i++) {
            var moveId = arrayObjectEstimationProductIndexOf($scope.listA_Estimation, $scope.selectedA_Estimation[i]);
            $scope.listB_Estimation.push({ 'Approver': $scope.listA_Estimation[moveId].Approver, 'Id': $scope.listA_Estimation[moveId].Id });
            var delId = arrayObjectEstimationProductIndexOf($scope.listA_Estimation, $scope.selectedA_Estimation[i]);
            $scope.listA_Estimation.splice(delId, 1);
            console.log('list A count after: ' + $scope.listA_Estimation.length);
            console.log('list B count after: ' + $scope.listB_Estimation.length);
        }
        $scope.selectedA_Estimation = [];
    };

    $scope.bToA_Estimation = function () {
        console.log('b to a');
        for (var i = 0; i < $scope.selectedB_Estimation.length; i++) {
            var moveId = arrayObjectEstimationProductIndexOf($scope.EstimationProduct, $scope.selectedB_Estimation[i]);
            if (moveId != -1) {
                $scope.listA_Estimation.push($scope.EstimationProduct[moveId]);
            }
            var delId = arrayObjectEstimationProductIndexOf($scope.listB_Estimation, $scope.selectedB_Estimation[i]);
            $scope.listB_Estimation.splice(delId, 1);
            console.log('list B count after: ' + $scope.listB_Estimation.length);
            console.log('list A count after: ' + $scope.listA_Estimation.length);
        }

        $scope.selectedB_Estimation = [];
    };

    $scope.stateBChanged_Estimation = function (isChecked, rightID) {
        if (isChecked == true) {
            $scope.selectedB_Estimation.push(rightID);
        }
        else {
            var delId = arrayObjectEstimationProductIndexOf($scope.selectedB_Estimation, rightID);
            $scope.selectedB_Estimation.splice(delId, 1);
        }
    }
    $scope.stateAChanged_Estimation = function (isChecked, rightID) {
        if (isChecked == true) {
            $scope.selectedA_Estimation.push(rightID);
        }
        else {
            var delId = arrayObjectEstimationProductIndexOf($scope.selectedA_Estimation, rightID);
            $scope.selectedA_Estimation.splice(delId, 1);
        }
    }
    $scope.GetRightsList();
});