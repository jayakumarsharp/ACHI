﻿ReportApp.controller('ReportsController', ['$scope', '$rootScope', 'StrategyService', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', '$q', 'apiService', 'Upload', '$sce', '_', '$window', function ($scope, $rootScope, StrategyService, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder, $q, apiService, Upload, $sce, _, $window) {
    $scope.data = [];
    $scope.IsModelAlgopage = true;
    $scope.errorinfo = '';
    $scope.Strategydata = [];
    $scope.editMode = false;
    $scope.showfilter = true;
    $scope.IsReadOnly = true;
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.currency = {};

    function reset() {
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
        };

    }
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
        .withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID'),
        DTColumnBuilder.newColumn('FTAShortCode').withTitle('FTA Short Code'),
        DTColumnBuilder.newColumn('BusinessLine').withTitle('Business Line'),
        DTColumnBuilder.newColumn('FTAApplicationName').withTitle('FTA Application Name'),
        DTColumnBuilder.newColumn('FTAStrategyCode').withTitle('FTA Strategy Name'),
        DTColumnBuilder.newColumn('RegionName').withTitle('Region'),
        DTColumnBuilder.newColumn('FTAApplicationOwner').withTitle('FTA Owner'),
        //DTColumnBuilder.newColumn('StrategyStatus').withTitle('Strategy Status'),
        DTColumnBuilder.newColumn('ApplicationCategory').withTitle('Category'),
        DTColumnBuilder.newColumn('Priority').withTitle('Priority'),
        //DTColumnBuilder.newColumn('ParentID').withTitle('Parent CSI ID'),
         DTColumnBuilder.newColumn('SignOff').withTitle('SignOff').renderWith(actionsStatus),
            DTColumnBuilder.newColumn('DecomissionedDate').withTitle('Status').renderWith(activeStatus),

        //DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
        //    .renderWith(actionsHtml)
    ];

    function actionsStatus(data, type, full, meta) {
        if (data == "Yes")
            return '<a  class="dta-act">SignOff</a>';
        else
            return '<a  class="dta-act-not">Pending</a>';
    }

    function activeStatus(data, type, full, meta) {
        var date1 = moment(data, 'MM/DD/YYYY');
        var currentdate = moment();

        if (currentdate < date1)
            return '<a  class="dta-act">Active</a>';
        else
            return '<a  class="dta-act-not">InActive</a>';
    }
    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }

    function actionsHtml(data, type, full, meta) {
        return '<a  class="test"><img src="images/edit.png"></a> &nbsp;<a  class="test1"><img style="width:24px;height:24px;" src="images/eyeicon.png"></a>';
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

    $scope.getallalgodata = function () {
        StrategyService.ShowLoader();
        var URl = 'Main/';
        let GetAllCountry = apiService.GetAllCountry();
        let GetAllFTAApplicationCode = apiService.GetAllFTAApplicationCode()
        let GetAllThirdPartyAppList = apiService.GetAllThirdPartyAppList()
        let GetAllBusiness = apiService.GetAllBusiness()
        let GetAllFTAStrategyCode = apiService.GetAllFTAStrategyCode()
        let GetAllDiscretionaryCode = apiService.GetAllDiscretionaryCode()
        let GetAllBusinessSuffix = apiService.GetAllBusinessSuffix()
        let GetAllParentID = apiService.GetAllParentID()
        let GetAllChildID = apiService.GetAllChildID()
        let GetAllBusinessLine = apiService.GetAllBusinessLine()
        let GetAllApplicationCategory = apiService.GetAllApplicationCategory()
        let GetAllFTAApplicationName = apiService.GetAllFTAApplicationName()
        let GetAllFTAStrategyName = apiService.GetAllFTAStrategyName()
        let GetAllVenuetype = apiService.GetAllVenuetype()
        let GetAllStrategytype = apiService.GetAllStrategytype()
        let GetAllCapacity = apiService.GetAllCapacity()
        let GetAllRegion = apiService.GetAllRegion()

        $q.all([
        GetAllCountry,
        GetAllFTAApplicationCode,
        GetAllThirdPartyAppList,
        GetAllBusiness,
        GetAllFTAStrategyCode,
        GetAllDiscretionaryCode,
        GetAllBusinessSuffix,
        GetAllParentID,
        GetAllChildID,
        GetAllBusinessLine,
        GetAllApplicationCategory,
        GetAllFTAApplicationName,
        GetAllFTAStrategyName,
         GetAllVenuetype,
        GetAllStrategytype,
        GetAllCapacity,
        GetAllRegion
        ]).then(function (resp) {
            console.log(resp)
            $scope.CountryMasterList = resp[0].data;
            $scope.FTAApplicationCodeList = resp[1].data;
            $scope.ThirdPartyList = resp[2].data;
            $scope.BusinessList = resp[3].data;
            $scope.FTAStrategyCodeList = resp[4].data;
            $scope.DiscretionaryCodeList = resp[5].data;
            $scope.BusinessSuffixList = resp[6].data;
            $scope.ParentIDList = resp[7].data;
            $scope.ChildIDList = resp[8].data;
            $scope.BusinessLineList = resp[9].data;
            $scope.ApplicationCategoryList = resp[10].data;
            $scope.FTAApplicationNameList = resp[11].data;
            $scope.FTAStrategyNameList = resp[12].data;
            $scope.VenuetypeList = resp[13].data;
            $scope.StrategytypeList = resp[14].data;
            $scope.CapacityList = resp[15].data;
            $scope.RegionMasterList = resp[16].data;

            binddata($scope.CountryMasterList);
        });
        $timeout(function () {
            StrategyService.HideLoader();
        }, 1000)
    };

    $scope.getallalgodata();
    $scope.activateTab = function (tabid) {
        for (var i = 0; i < $scope.pageList.length; i++) {
            $scope.pageList[i].Page = false;
        }
        $scope.pageList[tabid].Page = true;
        $scope.pageList[tabid].IsValid = true;
    }

    $scope.removefilter = function () {
        reset();
    };

    $scope.showfiltercondition = function () {
        $scope.showfilter = true;
    };
    $scope.Export = function () {
        // StrategyService.DownLoadReportFile('5e08a3bc-e59a-4d7e-9bac-3afb08ad7b1f.xlsx').success(function (data) { });
        var currency = { Country: '', Region: '', FTAApplicationCode: '', FTAStrategyCode: '', BusinessLine: '', FTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel) {
            StrategyService.ShowLoader();
            if ($scope.selectModel.Country)
                currency.Country = $scope.selectModel.Country.Id
            if ($scope.selectModel.Region)
                currency.Region = $scope.selectModel.Region.Id;
            if ($scope.selectModel.FTAApplicationCode)
                currency.FTAApplicationCode = $scope.selectModel.FTAApplicationCode.Id;
            if ($scope.selectModel.FTAStrategyCode)
                currency.FTAStrategyCode = $scope.selectModel.FTAStrategyCode.Id;
            if ($scope.selectModel.BusinessLine)
                currency.BusinessLine = $scope.selectModel.BusinessLine.Id;
            if ($scope.selectModel.FTAStrategyOwner)
                currency.FTAStrategyOwner = $scope.selectModel.FTAStrategyOwner.userId;
            if ($scope.selectModel.ApplicationCategory)
                currency.ApplicationCategory = $scope.selectModel.ApplicationCategory.Id;
            if ($scope.selectModel.Venuetype)
                currency.VenuetypeId = $scope.selectModel.Venuetype.Id

            ApiCall.MakeApiCall("ExportReport", 'POST', currency).success(function (data) {
                if (data.Error != undefined) {
                    toaster.pop('error', "Error", data.Error, null);
                } else {
                    if (data != 'No Records') {
                        var url = BaseURL + 'Main/DownLoadReportFile?FileName=' + data;
                        $scope.downloadurl = url;
                        setTimeout(function () {
                            $('#downloadpdf')[0].click();
                        }, 1000);
                        //StrategyService.DownLoadReportFile(data);
                    }
                    //$scope.dtOptions.data = $scope.data;
                    StrategyService.HideLoader();
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding Capacity ! " + data.ExceptionMessage;
            });
        }
        else
            toaster.pop('warning', "Warning", 'Please apply report filter condition', null);
    };
    $scope.showreport = function () {
        $scope.showfilter = false;
        //var idlist = '';
        //for (var i = 0; i < $scope.multiselect.selected.length; i++) {
        //    idlist = $scope.multiselect.selected[i].id + ',';
        //}
        var currency = { Country: '', Region: '', FTAApplicationCode: '', FTAStrategyCode: '', BusinessLine: '', FTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel) {
            StrategyService.ShowLoader();
            if ($scope.selectModel.Country)
                currency.Country = $scope.selectModel.Country.Id
            if ($scope.selectModel.Region)
                currency.Region = $scope.selectModel.Region.Id;
            if ($scope.selectModel.FTAApplicationCode)
                currency.FTAApplicationCode = $scope.selectModel.FTAApplicationCode.Id;
            if ($scope.selectModel.FTAStrategyCode)
                currency.FTAStrategyCode = $scope.selectModel.FTAStrategyCode.Id;
            if ($scope.selectModel.BusinessLine)
                currency.BusinessLine = $scope.selectModel.BusinessLine.Id;
            if ($scope.selectModel.FTAStrategyOwner)
                currency.FTAStrategyOwner = $scope.selectModel.FTAStrategyOwner.userId;
            if ($scope.selectModel.ApplicationCategory)
                currency.ApplicationCategory = $scope.selectModel.ApplicationCategory.Id;
            if ($scope.selectModel.Venuetype)
                currency.VenuetypeId = $scope.selectModel.Venuetype.Id

            ApiCall.MakeApiCall("GetStrategyReport", 'POST', currency).success(function (data) {
                if (data.Error != undefined) {
                    toaster.pop('error', "Error", data.Error, null);
                } else {
                    $scope.data = data;
                    $scope.dtOptions.data = $scope.data;
                    StrategyService.HideLoader();
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding Capacity ! " + data.ExceptionMessage;
            });
        }
        else
            toaster.pop('warning', "Warning", 'Please apply report filter condition', null);


    };


    $scope.GetCurrencyConversionForId = function (id, Version, RefNumber) {
        $scope.showaction = true;
        $scope.ShowSignOff = false;
        StrategyService.ShowLoader();
        binddata($scope.CountryMasterList);
        StrategyService.GetDatabyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.selectModel = data[0];
            $scope.selectModel.GOLiveDate = $scope.selectModel.GOLiveDate;
            $scope.selectModel.DecomissionedDate = $scope.selectModel.DecomissionedDate;
            //$scope.selectModel.GOLiveDate = moment($scope.selectModel.GOLiveDate.split(' ')[0], 'DD/MM/YYYY').format('MM/DD/YYYY');
            //$scope.selectModel.DecomissionedDate = moment($scope.selectModel.DecomissionedDate.split(' ')[0], 'DD/MM/YYYY').format('MM/DD/YYYY');
            $scope.Prevvalue = angular.copy($scope.selectModel)
            $scope.multiselect.selected = JSON.parse($scope.selectModel.Country);
            //$scope.selectModel.Country = getdynamicobject($scope.selectModel.Country, "CountryMasterList")
            $scope.selectModel.Region = getdynamicobject($scope.selectModel.Region, "RegionMasterList")
            $scope.selectModel.FTAApplicationCode = getdynamicobject($scope.selectModel.FTAApplicationCodeId, "FTAApplicationCodeList")
            $scope.selectModel.FTAStrategyCode = getdynamicobject($scope.selectModel.FTAStrategyCodeId, "FTAStrategyCodeList")
            $scope.selectModel.DiscretionaryCode = getdynamicobject($scope.selectModel.DiscretionaryCodeId, "DiscretionaryCodeList")
            $scope.selectModel.ParentID = getdynamicobject($scope.selectModel.ParentID, "ParentIDList")
            $scope.selectModel.BusinessSuffix = getdynamicobject($scope.selectModel.BusinessSuffixId, "BusinessSuffixList");
            $scope.selectModel.BusinessLine = getdynamicobject($scope.selectModel.BusinessLineId, "BusinessLineList");
            $scope.selectModel.FTAApplicationName = getdynamicobject($scope.selectModel.FTAApplicationNameId, "FTAApplicationNameList")
            $scope.selectModel.FTAStrategyName = getdynamicobject($scope.selectModel.FTAStrategyNameId, "FTAStrategyNameList")
            $scope.selectModel.ApplicationCategory = getdynamicobject($scope.selectModel.ApplicationCategoryId, "ApplicationCategoryList")
            $scope.selectModel.Strategytype = getdynamicobject($scope.selectModel.StrategytypeId, "StrategytypeList")
            $scope.selectModel.Venuetype = getdynamicobject($scope.selectModel.VenueTypeId, "VenuetypeList")
            $scope.selectModel.Capacity = getdynamicobject($scope.selectModel.CapacityId, "CapacityList")
            $scope.selectModel.ChildID = getdynamicobject($scope.selectModel.ChildID, "ChildIDList");
            $scope.selectModel.ThirdPartyApp = getdynamicobject($scope.selectModel.ThirdPartyAppId, "ThirdPartyList");
            $scope.selectModel.Business = getdynamicobject($scope.selectModel.BusinessId, "BusinessList");
            $scope.selectModel.Description = $scope.selectModel.Description;
            $scope.userfilter(true);
            $scope.activateTab(0);
            for (var i = 0; i < $scope.pageList.length; i++) {
                $scope.pageList[i].IsValid = true;
            }
            assignUsers();
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

        StrategyService.GetStrategyApprovalById(RefNumber, Version).success(function (data) {
            $scope.UploadedSList = [];
            $scope.UploadedDList = [];
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    if (data[i].Status == "S")
                        $scope.UploadedSList.push(data[i]);
                    else
                        $scope.UploadedDList.push(data[i]);
                }
            }
        });

        $timeout(function () {
            StrategyService.HideLoader();
        }, 500)
    };
    $scope.openpopup = function (type) {
        $('#viewFiles').modal('show');
    }
    var getdynamicobject = function (userId, type) {
        for (var i = 0; i < $scope[type].length; i++) {
            if ($scope[type][i].Id == userId) {
                return $scope[type][i];
            }
        }
    };
    var getdynamicobjectuserfilter = function (userId, type) {
        for (var i = 0; i < $scope[type].length; i++) {
            if ($scope[type][i].userId == userId) {
                return $scope[type][i];
            }
        }
    };
    $scope.GetCurrencyConversionForIdView = function (id, Version) {
        $scope.ViewData = [];
        $scope.ViewListdata = false;
        $('#viewApprovals').modal('show');
        ApiCall.MakeApiCall("GetStrategyVersionLog?Id=" + id, 'GET', '').success(function (data) {
            $scope.Listdata = data;
            $scope.ViewListdata = true;
        }).error(function (error) {
            $scope.Error = error;
        })
    };


    $scope.showconfirm = function (data) {
        $scope.Id = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.selectModel = { Application: {}, Country: {}, ProductType: {}, BusinessSector: {}, Region: {} };
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

    $scope.userfilter = function (state) {
        try {
            var Region = $scope.selectModel.Region.Id;
            var BusinessLine = $scope.selectModel.BusinessLine.Id;

            if (Region != "" && BusinessLine != "" && BusinessLine != undefined && Region != undefined) {
                ApiCall.MakeApiCall("GetUserbyFilter?RegionId=" + Region + "&BusinessLineId=" + BusinessLine, 'GET', '').success(function (data) {
                    $scope.FTAApplicationOwnerList = data;
                    $scope.FTAStrategyOwnerList = data;
                    if (state) {
                        $scope.selectModel.FTAStrategyOwner = getdynamicobjectuserfilter($scope.selectModel.FTAStrategyOwnerId, "FTAStrategyOwnerList")
                        $scope.selectModel.FTAApplicationOwner = getdynamicobjectuserfilter($scope.selectModel.FTAApplicationOwnerId, "FTAApplicationOwnerList")
                        if ($scope.userId.toLowerCase() == $scope.selectModel.FTAStrategyOwnerId.toLowerCase())
                            $scope.ShowSignOff = true;

                    }
                }).error(function (error) {
                    $scope.Error = error;
                })
            }
            else {
                $scope.FTAApplicationOwnerList = [];
                $scope.FTAStrategyOwnerList = [];
            }
        }
        catch (e) {
        }
    }

    $scope.userfilter1 = function () {
        console.log($scope.selectModel)
        if ($scope.selectModel.FTAStrategyCode.FTAStrategyCode && $scope.selectModel.FTAApplicationCode.FTAApplicationCode && $scope.selectModel.DiscretionaryCode.DiscretionaryCode && $scope.selectModel.BusinessSuffix.BusinessSuffix) {
            $scope.selectModel.FTAShortCode = $scope.selectModel.FTAStrategyCode.FTAStrategyCode + $scope.selectModel.FTAApplicationCode.FTAApplicationCode + $scope.selectModel.DiscretionaryCode.DiscretionaryCode + $scope.selectModel.BusinessSuffix.BusinessSuffix;
        }
        else
            $scope.selectModel.FTAShortCode = '';
    }

    $scope.userfilter2 = function () {
        console.log($scope.selectModel)
        if ($scope.selectModel.Strategytype && $scope.selectModel.Venuetype && $scope.selectModel.Capacity) {
            $scope.selectModel.PriorityScore = parseInt($scope.selectModel.Strategytype.Strategytype) + parseInt($scope.selectModel.Venuetype.Venuetype) + parseInt($scope.selectModel.Capacity.Capacity);
        }
        else {
            $scope.selectModel.PriorityScore = '';
            $scope.selectModel.Priority = '';
        }
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

    $scope.userfilter3 = function () {
        try {
            var Business = $scope.selectModel.FTAApplicationName;
            if (Business != "" && Business != undefined) {
                ApiCall.MakeApiCall("GetAllFTAApplicationMappingbyId?Id=" + Business.Id, 'GET', '').success(function (data) {
                    console.log(data);
                    if (data.length > 0) {
                        $scope.selectModel.FTAApplicationMappingId = data[0].Id;
                        $scope.selectModel.FTAApplicationCode = getdynamicobject(data[0].FTAApplicationCodeId, "FTAApplicationCodeList")
                        $scope.selectModel.FTAApplicationName = getdynamicobject(data[0].FTAApplicationNameId, "FTAApplicationNameList")
                        $scope.selectModel.ChildID = getdynamicobject(data[0].ChildId, "ChildIDList")
                        $scope.selectModel.ThirdPartyApp = getdynamicobject(data[0].ThirdPartyAppId, "ThirdPartyList");
                        $scope.userfilter1();
                    }
                    else {
                        clearfilter3();
                    }

                }).error(function (error) {
                    $scope.Error = error;
                })
            }
            else {
                clearfilter3();
            }
        }
        catch (e) {
        }
    }

    function clearfilter3() {
        $scope.selectModel.FTAApplicationMappingId = 0;
        $scope.selectModel.FTAApplicationCode = {};
        //$scope.selectModel.FTAApplicationName = {};
        $scope.selectModel.ChildID = {};
        $scope.selectModel.ThirdPartyApp = {};
        $scope.userfilter1();
    }

    $scope.userfilter4 = function () {
        try {
            var Business = $scope.selectModel.FTAStrategyName;
            if (Business != "" && Business != undefined) {
                ApiCall.MakeApiCall("GetAllFTAStrategyMappingbyId?Id=" + Business.Id, 'GET', '').success(function (data) {
                    if (data.length > 0) {
                        $scope.selectModel.FTAStrategyMappingId = data[0].Id;
                        $scope.selectModel.FTAStrategyCode = getdynamicobject(data[0].FTAStrategyCodeId, "FTAStrategyCodeList")
                        $scope.userfilter1();
                    }
                    else {
                        clearfilter4();
                    }

                }).error(function (error) {
                    $scope.Error = error;
                });
            }
            else
                clearfilter4()

        }
        catch (e) {
        }
    }

    function clearfilter4() {
        $scope.selectModel.FTAStrategyCode = {};
        $scope.selectModel.FTAStrategyMappingId = 0;
    }

    $scope.userfilter5 = function () {
        try {
            var Business = $scope.selectModel.Business;
            if (Business != "" && Business != undefined) {
                ApiCall.MakeApiCall("GetAllBusinessMappingbyId?Id=" + Business.Id, 'GET', '').success(function (data) {
                    if (data.length > 0) {
                        $scope.selectModel.BusinessMappingId = data[0].Id;
                        $scope.selectModel.BusinessSuffix = getdynamicobject(data[0].BusinessSuffixId, "BusinessSuffixList");
                        $scope.userfilter1();
                    }
                    else
                        clearfilter5();

                }).error(function (error) {
                    $scope.Error = error;
                })
            }
            else
                clearfilter5();

        }
        catch (e) {
        }
    }

    function clearfilter5() {
        $scope.selectModel.BusinessSuffix = {};
        $scope.selectModel.BusinessMappingId = 0;
        $scope.userfilter1();
    }

    $scope.GetRightsList = function () {
        UserFactory.getloggedusername().success(function (data) {
            $scope.userId = data;
            if (data != '') {
                reportFactory.GetRightsList($scope.userId).success(function (data) {
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

    // $scope.GetRightsList();

    $scope.multiselect = {
        selected: [],
        options: [],
        config: {
            hideOnBlur: false,
            showSelected: false,
            itemTemplate: function (item) {
                return $sce.trustAsHtml(item.name);
            },
            labelTemplate: function (item) {
                return $sce.trustAsHtml(item.name);
            }
        }
    };

    $scope.displayUsers = function () {
        return $scope.multiselect.selected.map(function (each) {
            return each.CountryName;
        }).join(', ');
    };

    function assignUsers() {
        $scope.assignedUsers = [];
        var msUsers = $scope.multiselect.selected;
        var stacklist = $scope.CountryMasterList;
        for (index = 0; index < $scope.multiselect.selected.length; index++) {
            var remove = _.findWhere(stacklist, {
                Id: $scope.multiselect.selected[index].id
            })
            stacklist = _.without(stacklist, remove)
        }
        binddata(stacklist);
    }
    function binddata(list) {
        $scope.multiselect.options = list.map(function (item) {
            return {
                name: item.CountryName,
                id: item.Id
            };
        });
    }

}]);


