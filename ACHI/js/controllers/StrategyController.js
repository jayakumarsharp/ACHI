﻿ReportApp.controller('StrategyController', ['$scope', '$rootScope', 'StrategyService', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, StrategyService, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.data = [];
    $scope.IsModelAlgopage = true;

    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
        .withOption('rowCallback', rowCallback);

    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID'),
        DTColumnBuilder.newColumn('RefNumber').withTitle('RefNumber'),
        DTColumnBuilder.newColumn('Name').withTitle('Name'),
        DTColumnBuilder.newColumn('BusinessSectorName').withTitle('Business Sector'),
        DTColumnBuilder.newColumn('Type').withTitle('Type'),
        DTColumnBuilder.newColumn('CountryName').withTitle('Country'),
        DTColumnBuilder.newColumn('RegionName').withTitle('Region'),
        DTColumnBuilder.newColumn('ProductTypeName').withTitle('Product Type'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }

    function actionsHtml(data, type, full, meta) {
        return '<a  class="test"><img src="../images/edit.png"></a>' +
        '&nbsp;<a  class="test1"><img style="width:24px;height:24px;" src="../images/eyeicon.png"></a>';
    }

    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.test', nRow).unbind('click');
        $('.test', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.GetCurrencyConversionForId(aData.Id, aData.Version, aData.RefNumber);
            });
        });
        $('.test1', nRow).unbind('click');
        $('.test1', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.GetCurrencyConversionForIdView(aData.RefNumber, aData.Version);
            });
        });
        return nRow;
    }

    $scope.errorinfo = '';
    $scope.Strategydata = [];
    $scope.editMode = false;
    $scope.showaction = false;

    $scope.pageList = [{ Page: true, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }];

    $scope.activateTab = function (tabid) {
        for (var i = 0; i < $scope.pageList.length; i++) {
            $scope.pageList[i].Page = false;
        }
        $scope.pageList[tabid].Page = true;
        $scope.pageList[tabid].IsValid = true;
    }

    $scope.IsReadOnly = true;
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.currency = {};
    $scope.LockedPriceSheet = [];

    $scope.selectModel = { Application: {}, Country: {}, ProductType: {}, BusinessSector: {}, Region: {} };

    function getallgriddata() {
        StrategyService.GetAllCurrencyConversion().success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data;
        });
    }

    $scope.getallalgodata = function () {
        getallgriddata();
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
    $scope.getallalgodata();

    $scope.showadd = function () {
        $scope.showaction = true;
        $timeout(function () {
            $scope.errorinfo = '';
            $scope.StrategyActive = false;
            $scope.IsSignOff = false;
        }, 100);
        $scope.editMode = false;
        $scope.currency = {};
        $scope.selectModel = { Application: "", Country: "", ProductType: "", BusinessSector: "", Region: "" };
        $scope.activateTab(0);
        $('#currencyModel').modal('show');
    };
    $scope.InsertStrategy = function (currency) {
        if ($scope.listB_Estimation.length > 0) {
            currency.ApplicationId = $scope.selectModel.Application.Id;
            currency.Country = $scope.selectModel.Country.Id;
            currency.ProductType = $scope.selectModel.ProductType.Id;
            currency.BusinessSector = $scope.selectModel.BusinessSector.Id;
            currency.Region = $scope.selectModel.Region.Id;

            if (currency != null) {
                StrategyService.InsertStrategy(currency).success(function (data) {
                    if (data == "success") {
                        $scope.listB_Estimation[0].RefNumber = currency.RefNumber;
                        $scope.listB_Estimation[0].Version = 1;
                        $scope.showaction = false;
                        StrategyService.InsertStrategyApprover($scope.listB_Estimation).success(function (data) {
                            toaster.pop('success', "Success", "Model/Algo added successfully", null);
                        });
                        $('#currencyModel').modal('hide');
                    }
                    else
                        $scope.errorinfo = data;
                    getallgriddata();
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
                });
            }
        }
        else
            toaster.pop('warning', "Warning", "Please select approvers", null);
    };


    $scope.Availableusers = [];

    $scope.GetCurrencyConversionForId = function (id, Version, RefNumber) {
        $scope.showaction = true;
        StrategyService.GetDatabyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.currency = data[0];
            $scope.selectModel.Application = $scope.GetRoleFromUserID($scope.currency.ApplicationId, "ApplicationMasterList")
            $scope.selectModel.Country = $scope.GetRoleFromUserID($scope.currency.Country, "CountryMasterList")
            $scope.selectModel.ProductType = $scope.GetRoleFromUserID($scope.currency.ProductType, "ProductMasterList")
            $scope.selectModel.BusinessSector = $scope.GetRoleFromUserID($scope.currency.BusinessSector, "BusinessSectorMasterList")
            $scope.selectModel.Region = $scope.GetRoleFromUserID($scope.currency.Region, "RegionMasterList")

            $scope.activateTab(0);
            for (var i = 0; i < $scope.pageList.length; i++) {
                $scope.pageList[i].IsValid = true;
            }

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

        StrategyService.GetStrategyApprovalById(RefNumber, Version).success(function (data) {

            $scope.Availableusers = data;
            for (var i = 0; i < data.length; i++) {
                data[i].Id = i;
            }

            ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + $scope.currency.Country + "&RegionId=" + $scope.currency.Region + "&BusinessSectorId=" + $scope.currency.BusinessSector, 'GET', '').success(function (adata) {
                $scope.aEstimationProduct = [];
                for (var k = 0; k < adata.length; k++) {
                    $scope.aEstimationProduct.push({ RefNumber: '', Approver: adata[k].userId, Id: adata[k].Id });
                }

                $scope.EstimationProduct = data;

                $scope.listA_Estimation = [];
                $scope.listB_Estimation = [];
                var temp = JSON.parse(JSON.stringify($scope.aEstimationProduct));

                for (i = 0; i < $scope.EstimationProduct.length; i++) {
                    $scope.listB_Estimation.push({ 'Approver': $scope.EstimationProduct[i].Approver, 'Id': $scope.EstimationProduct[i].Id });
                    var delId = arrayObjectEstimationProductIndexOf(temp, $scope.EstimationProduct[i].Approver);
                    temp.splice(delId, 1);
                }
                $scope.listA_Estimation = temp;
            });

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


    $scope.GetCurrencyConversionForIdView = function (id, Version) {
        $scope.ViewData = [];
        StrategyService.GetStrategyApprovalById(id, Version).success(function (data) {
            $('#viewApprovals').modal('show');
            $scope.ViewData = data;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };


    $scope.UpdateStrategy = function (model) {
        model.Page = "S";
        if ($scope.listB_Estimation.length > 0) {

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
                    $scope.showaction = false;
                    $scope.editMode = false;
                    $('#currencyModel').modal('hide');

                    toaster.pop('success', "Success", "Model/Algo updated successfully", null);
                    $scope.getallalgodata()
                }
                else
                    $scope.errorinfo = data;
                getallgriddata();
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
            });
        }
        else
            toaster.pop('warning', "Warning", "Please select approvers", null);
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
        $scope.selectModel = { Application: {}, Country: {}, ProductType: {}, BusinessSector: {}, Region: {} };
        //$('#currencyModel').modal('hide');
        $scope.showaction = false;
        $('#confirmModal').modal('hide');
    };

    $scope.updatecancel = function (data) {
        StrategyService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.currency = data[0];
            $('#currencyModel').modal('show');

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

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
            if (Country != "" && BusinessSector != "" && Region != "" && Country != undefined && BusinessSector != undefined && Region != undefined) {
                ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + Country + "&RegionId=" + Region + "&BusinessSectorId=" + BusinessSector, 'GET', '').success(function (data) {
                    console.log(data);
                    $scope.listA_Estimation = [];
                    $scope.listB_Estimation = [];
                    $scope.EstimationProduct = [];
                    for (var k = 0; k < data.length; k++) {
                        $scope.EstimationProduct.push({ RefNumber: '', Approver: data[k].userId, Id: data[k].Id });
                    }

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
            else {
                $scope.listA_Estimation = [];
                $scope.listB_Estimation = [];
            }
        }
        catch (e) {
        }
    }


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

    $scope.GetRightsList = function () {
        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Application Write') {
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



    $scope.GetRightsList();


}]);