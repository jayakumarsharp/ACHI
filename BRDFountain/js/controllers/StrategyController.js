ReportApp.controller('StrategyController', ['$scope', '$rootScope', 'StrategyService', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, StrategyService, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.data = [];
    $scope.IsModelAlgopage = true;
    $scope.errorinfo = '';
    $scope.Strategydata = [];
    $scope.editMode = false;
    $scope.showaction = false;
    $scope.IsReadOnly = true;
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.currency = {};

    $scope.selectModel = {
        Country: {},
        Region: {},
        FTAApplicationCode: {},
        BusinessSuffix: {},
        ChildID: {},
        FTAStrategyName: {},
        Strategytype: {},
        GOLiveDate: '',
        FTAStrategyCode: {},
        FTAShortCode: {},
        BusinessLine: {},
        FTAApplicationName: {},
        FTAStrategyOwner: {},
        ApplicationCategory: {},
        Venuetype: {},
        DecomissionedDate: {},
        DiscretionaryCode: {},
        ParentID: {},
        FTAApplicationOwner: {},
        PriorityScore: '',
        Priority: '',
        Capacity: {},
        Strategytype: {},

    };

    $scope.pageList = [{ Page: true, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }];

    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
        .withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID'),
        DTColumnBuilder.newColumn('FTAShortCode').withTitle('FTA Short Code'),
        DTColumnBuilder.newColumn('BusinessLine').withTitle('Business Line'),
        DTColumnBuilder.newColumn('FTAApplicationName').withTitle('FTA Application Name'),
        DTColumnBuilder.newColumn('FTAStrategyName').withTitle('FTA Strategy Name'),
        DTColumnBuilder.newColumn('RegionName').withTitle('Region'),
        DTColumnBuilder.newColumn('FTAApplicationOwner').withTitle('FTA Owner'),
        //DTColumnBuilder.newColumn('StrategyStatus').withTitle('Strategy Status'),
        DTColumnBuilder.newColumn('ApplicationCategory').withTitle('Category'),
        DTColumnBuilder.newColumn('Priority').withTitle('Priority'),
        DTColumnBuilder.newColumn('ParentID').withTitle('Parent CSI ID'),
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
        return '<a  class="test"><img src="../images/edit.png"></a> &nbsp;<a  class="test1"><img style="width:24px;height:24px;" src="../images/eyeicon.png"></a>';
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
    $scope.activateTab = function (tabid) {
        for (var i = 0; i < $scope.pageList.length; i++) {
            $scope.pageList[i].Page = false;
        }
        $scope.pageList[tabid].Page = true;
        $scope.pageList[tabid].IsValid = true;
    }
    function getallgriddata() {
        StrategyService.GetAllCurrencyConversion().success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data;
        });
    }

    $scope.getallalgodata = function () {
        getallgriddata();
        ApiCall.MakeApiCall("GetAllApplication?ApplicationId=", 'GET', '').success(function (data) {
            $scope.ApplicationMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllBusinessSector?BusinessSectorId=", 'GET', '').success(function (data) {
            $scope.BusinessSectorMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllCountry?CountryId=", 'GET', '').success(function (data) {
            $scope.CountryMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllProductType?ProductTypeId=", 'GET', '').success(function (data) {
            $scope.ProductMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllFTAApplicationCode?FTAApplicationCodeId=", 'GET', '').success(function (data) {
            $scope.FTAApplicationCodeList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllFTAStrategyCode?FTAStrategyCodeId=", 'GET', '').success(function (data) {
            $scope.FTAStrategyCodeList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllDiscretionaryCode?DiscretionaryCodeId=", 'GET', '').success(function (data) {
            $scope.DiscretionaryCodeList = data;
        }).error(function (error) {
            $scope.Error = error;
        });
        ApiCall.MakeApiCall("GetAllBusinessSuffix?BusinessSuffixId=", 'GET', '').success(function (data) {
            $scope.BusinessSuffixList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllFTAShortCode?FTAShortCodeId=", 'GET', '').success(function (data) {
            $scope.FTAShortCodeList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllParentID?ParentIDId=", 'GET', '').success(function (data) {
            $scope.ParentIDList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllChildID?ChildIDId=", 'GET', '').success(function (data) {
            $scope.ChildIDList = data;
        }).error(function (error) {
            $scope.Error = error;
        })


        ApiCall.MakeApiCall("GetAllBusinessLine?BusinessLineId=", 'GET', '').success(function (data) {
            $scope.BusinessLineList = data;
        }).error(function (error) {
            $scope.Error = error;
        });
        ApiCall.MakeApiCall("GetAllApplicationCategory?ApplicationCategoryId=", 'GET', '').success(function (data) {
            $scope.ApplicationCategoryList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllFTAApplicationName?FTAApplicationNameId=", 'GET', '').success(function (data) {
            $scope.FTAApplicationNameList = data;
        }).error(function (error) {
            $scope.Error = error;
        })
        ApiCall.MakeApiCall("GetAllFTAApplicationOwner?FTAApplicationOwnerId=", 'GET', '').success(function (data) {
            $scope.FTAApplicationOwnerList = data;
        }).error(function (error) {
            $scope.Error = error;
        });
        //ApiCall.MakeApiCall("GetAllPriorityScore?PriorityScoreId=", 'GET', '').success(function (data) {
        //    $scope.PriorityScoreList = data;
        //}).error(function (error) {
        //    $scope.Error = error;
        //})
        ApiCall.MakeApiCall("GetAllFTAStrategyName?FTAStrategyNameId=", 'GET', '').success(function (data) {
            $scope.FTAStrategyNameList = data;
        }).error(function (error) {
            $scope.Error = error;
        });

        ApiCall.MakeApiCall("GetAllFTAStrategyOwner?FTAStrategyOwnerId=", 'GET', '').success(function (data) {
            $scope.FTAStrategyOwnerList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllVenuetype?VenuetypeId=", 'GET', '').success(function (data) {
            $scope.VenuetypeList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

        ApiCall.MakeApiCall("GetAllStrategytype?StrategytypeId=", 'GET', '').success(function (data) {
            $scope.StrategytypeList = data;
        }).error(function (error) {
            $scope.Error = error;
        });
        ApiCall.MakeApiCall("GetAllCapacity?CapacityId=", 'GET', '').success(function (data) {
            $scope.CapacityList = data;
        }).error(function (error) {
            $scope.Error = error;
        });

        ApiCall.MakeApiCall("GetAllRegion?RegionId=", 'GET', '').success(function (data) {
            $scope.RegionMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        });

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

        $scope.selectModel = { Application: "", Country: "", ProductType: "", BusinessSector: "", Region: "" };
        $scope.activateTab(0);
        $('#currencyModel').modal('show');
    };
    $scope.InsertStrategy = function () {
        console.log($scope.selectModel);
        debugger;
        var currency = {};
        if ($scope.listB_Estimation.length > 0) {
            currency.Country = $scope.selectModel.Country.Id;
            currency.Region = $scope.selectModel.Region.Id;
            currency.FTAApplicationCodeId = $scope.selectModel.FTAApplicationCode.Id;
            currency.BusinessSuffixId = $scope.selectModel.BusinessSuffix.Id;
            currency.ChildIDValue = $scope.selectModel.ChildID.Id;
            currency.FTAStrategyNameId = $scope.selectModel.FTAStrategyName.Id;
            currency.StrategytypeId = $scope.selectModel.Strategytype.Id;
            currency.GOLiveDate = $scope.selectModel.GOLiveDate;
            currency.FTAStrategyCodeId = $scope.selectModel.FTAStrategyCode.Id;
            currency.FTAShortCodeId = $scope.selectModel.FTAShortCode;
            currency.BusinessLineId = $scope.selectModel.BusinessLine.Id
            currency.FTAApplicationNameId = $scope.selectModel.FTAApplicationName.Id
            currency.FTAStrategyOwnerId = $scope.selectModel.FTAStrategyOwner.Id
            currency.ApplicationCategoryId = $scope.selectModel.ApplicationCategory.Id
            currency.VenuetypeId = $scope.selectModel.Venuetype.Id
            currency.DecomissionedDate = $scope.selectModel.DecomissionedDate
            currency.DiscretionaryCodeId = $scope.selectModel.DiscretionaryCode.Id
            currency.ParentIDValue = $scope.selectModel.ParentID.Id
            currency.FTAApplicationOwnerId = $scope.selectModel.FTAApplicationOwner.Id
            currency.PriorityScore = $scope.selectModel.PriorityScore;
            currency.Priority = $scope.selectModel.Priority;
            currency.CapacityId = $scope.selectModel.Capacity.Id

            if (currency != null) {
                StrategyService.InsertStrategy(currency).success(function (data) {
                    var splitdata = data.split('-');
                    if (splitdata[0] == "success") {
                        $scope.listB_Estimation[0].RefNumber = splitdata[1];
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
            $scope.selectModel = data[0];
            console.log($scope.selectModel.Country);
            $scope.selectModel.Country = getdynamicobject($scope.selectModel.Country, "CountryMasterList")
            $scope.selectModel.Region = getdynamicobject($scope.selectModel.Region, "RegionMasterList")
            $scope.selectModel.FTAApplicationCode = getdynamicobject($scope.selectModel.FTAApplicationCodeId, "FTAApplicationCodeList")
            $scope.selectModel.FTAStrategyCode = getdynamicobject($scope.selectModel.FTAStrategyCodeId, "FTAStrategyCodeList")
            $scope.selectModel.DiscretionaryCode = getdynamicobject($scope.selectModel.DiscretionaryCodeId, "DiscretionaryCodeList")
            $scope.selectModel.ParentID = getdynamicobject($scope.selectModel.ParentID, "ParentIDList")
            $scope.selectModel.BusinessSuffix = getdynamicobject($scope.selectModel.BusinessSuffixId, "BusinessSuffixList")
            $scope.selectModel.BusinessLine = getdynamicobject($scope.selectModel.BusinessLineId, "BusinessLineList")
            $scope.selectModel.FTAApplicationName = getdynamicobject($scope.selectModel.FTAApplicationNameId, "FTAApplicationNameList")
            $scope.selectModel.FTAApplicationOwner = getdynamicobject($scope.selectModel.FTAApplicationOwnerId, "FTAApplicationOwnerList")
            $scope.selectModel.FTAStrategyName = getdynamicobject($scope.selectModel.FTAStrategyNameId, "FTAStrategyNameList")
            $scope.selectModel.FTAStrategyOwner = getdynamicobject($scope.selectModel.FTAStrategyOwnerId, "FTAStrategyOwnerList")
            $scope.selectModel.ApplicationCategory = getdynamicobject($scope.selectModel.ApplicationCategoryId, "ApplicationCategoryList")
            $scope.selectModel.Strategytype = getdynamicobject($scope.selectModel.StrategytypeId, "StrategytypeList")
            $scope.selectModel.Venuetype = getdynamicobject($scope.selectModel.VenueTypeId, "VenuetypeList")
            $scope.selectModel.Capacity = getdynamicobject($scope.selectModel.CapacityId, "CapacityList")
            $scope.selectModel.ChildID = getdynamicobject($scope.selectModel.ChildID, "CapacityList")

            $scope.activateTab(0);
            for (var i = 0; i < $scope.pageList.length; i++) {
                $scope.pageList[i].IsValid = true;
            }
            StrategyService.GetStrategyApprovalById(RefNumber, Version).success(function (data) {
                $scope.Availableusers = data;
                for (var i = 0; i < data.length; i++) {
                    data[i].Id = i;
                }
                ApiCall.MakeApiCall("GetUserbyFilter?RegionId=" + $scope.selectModel.Region.Id + "&BusinessLineId=" + $scope.selectModel.BusinessLine.Id, 'GET', '').success(function (adata) {
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
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };


    var getdynamicobject = function (userId, type) {
        for (var i = 0; i < $scope[type].length; i++) {
            if ($scope[type][i].Id == userId) {
                return $scope[type][i];
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
            var BusinessLine = $scope.selectModel.BusinessLine.Id;

            if (Region != "" && BusinessLine != "" && BusinessLine != undefined && Region != undefined) {
                ApiCall.MakeApiCall("GetUserbyFilter?RegionId=" + Region + "&BusinessLineId=" + BusinessLine, 'GET', '').success(function (data) {
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


    $scope.userfilter1 = function () {
        console.log($scope.selectModel)
        if ($scope.selectModel.FTAStrategyCode && $scope.selectModel.FTAApplicationCode && $scope.selectModel.DiscretionaryCode && $scope.selectModel.BusinessSuffix) {
            $scope.selectModel.FTAShortCode = $scope.selectModel.FTAStrategyCode.FTAStrategyCode + $scope.selectModel.FTAApplicationCode.FTAApplicationCode + $scope.selectModel.DiscretionaryCode.DiscretionaryCode + $scope.selectModel.BusinessSuffix.BusinessSuffix;
        }
        else
            $scope.selectModel.FTAShortCode = '';

    }


    $scope.userfilter2 = function () {
        console.log($scope.selectModel)
        if ($scope.selectModel.Strategytype && $scope.selectModel.Venuetype && $scope.selectModel.Capacity) {
            $scope.selectModel.PriorityScore = $scope.selectModel.Strategytype.Strategytype + $scope.selectModel.Venuetype.Venuetype + $scope.selectModel.Capacity.Capacity;
        }
        else
            $scope.selectModel.PriorityScore = '';

        if (!isNaN($scope.selectModel.PriorityScore)) {
            var priorityvalue = parseInt($scope.selectModel.PriorityScore)
            if (priorityvalue >= 10 && priorityvalue <= 10)
                $scope.selectModel.Priority = 1;
            if (priorityvalue >= 6 && priorityvalue <= 9)
                $scope.selectModel.Priority = 2;
            if (priorityvalue >= 5)
                $scope.selectModel.Priority = 3;
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