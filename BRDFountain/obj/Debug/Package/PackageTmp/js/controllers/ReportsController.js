ReportApp.controller('ReportsController', ['$scope', '$rootScope', 'StrategyService', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', '$q', 'apiService', 'Upload', '$sce', '_', '$window', function ($scope, $rootScope, StrategyService, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder, $q, apiService, Upload, $sce, _, $window) {
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
            LTAApplicationCode: {},
            BusinessSuffix: {},
            ChildID: {},
            LTAStrategyName: {},
            Strategytype: {},
            GOLiveDate: '',
            LTAStrategyCode: {},
            LTAShortCode: {},
            BusinessLine: {},
            LTAApplicationName: {},
            ApplicationCategory: {},
            Venuetype: {},
            DecomissionedDate: {},
            DiscretionaryCode: {},
            ParentID: {},
            LTAApplicationOwner: {},
            PriorityScore: '',
            Priority: '',
            Capacity: {},
        };

    }
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
        .withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        //DTColumnBuilder.newColumn('Id').withTitle('ID'),
        DTColumnBuilder.newColumn('LTAShortCode').withTitle('LTA Short Code'),
        DTColumnBuilder.newColumn('BusinessLine').withTitle('Business Line'),
        DTColumnBuilder.newColumn('LTAApplicationName').withTitle('LTA Application Name'),
        DTColumnBuilder.newColumn('LTAStrategyCode').withTitle('LTA Strategy Name'),
        DTColumnBuilder.newColumn('RegionName').withTitle('Region'),
        DTColumnBuilder.newColumn('LTAApplicationOwner').withTitle('LTA Owner'),
        //DTColumnBuilder.newColumn('StrategyStatus').withTitle('Strategy Status'),
        DTColumnBuilder.newColumn('ApplicationCategory').withTitle('Category'),
        DTColumnBuilder.newColumn('Priority').withTitle('Priority'),
        //DTColumnBuilder.newColumn('ParentID').withTitle('Parent CSI ID'),
        DTColumnBuilder.newColumn('Attest').withTitle('Attest').renderWith(actionsStatus),
        //DTColumnBuilder.newColumn('DecomissionedDate').withTitle('Status').renderWith(activeStatus),
        DTColumnBuilder.newColumn('Status').withTitle('Status'),
        //DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
        //    .renderWith(actionsHtml)
    ];

    function actionsStatus(data, type, full, meta) {
        if (data == "Pending")
            return '<a  class="dta-act-not">Pending</a>';

        else
            return '<a  class="dta-act">Attested</a>';
    }

    function activeStatus(data, type, full, meta) {
        var GOLiveDate = moment(full.GOLiveDate, 'MM/DD/YYYY');
        if (full.DecomissionedDate)
            var DecomissionedDate = moment(full.DecomissionedDate, 'MM/DD/YYYY');
        else
            var DecomissionedDate = full.DecomissionedDate;
        var currentdate = moment();
        if (DecomissionedDate != '') {
            if ((currentdate >= GOLiveDate && currentdate <= DecomissionedDate) || (currentdate >= DecomissionedDate && currentdate <= GOLiveDate)) // false
                return '<a  class="dta-act">Active</a>';
            else if (GOLiveDate >= currentdate)//&& DecomissionedDate <= currentdate)
                return '<a  class="dta-sign">PipeLine</a>';
            else if (DecomissionedDate < currentdate)
                return '<a  class="dta-act-not">InActive</a>';
        }
        else {
            if (GOLiveDate < currentdate)
                return '<a  class="dta-act-not">InActive</a>';
            else if (GOLiveDate > currentdate)
                return '<a  class="dta-sign">PipeLine</a>';
            else
                return '<a  class="dta-act-not">InActive</a>';
        }
    }

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }

    function actionsHtml(data, type, full, meta) {
        if ($scope.IsReadOnly) {
            return "-";
        }
        else {
            return '<a  class="test"><img src="images/edit.png"></a> &nbsp;<a  class="test1"><img style="width:24px;height:24px;" src="images/eyeicon.png"></a>';
        }
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


    $scope.getallalgodata = function (userid) {
        StrategyService.ShowLoader();
        var URl = 'Main/';
        //let GetAllCountry = apiService.GetAllCountry();
        let GetAllLTAApplicationCode = apiService.GetAllLTAApplicationCode()
        let GetAllThirdPartyAppList = apiService.GetAllThirdPartyAppList()
        let GetAllBusiness = apiService.GetAllBusiness()
        let GetAllLTAStrategyCode = apiService.GetAllLTAStrategyCode()
        let GetAllDiscretionaryCode = apiService.GetAllDiscretionaryCode()
        let GetAllBusinessSuffix = apiService.GetAllBusinessSuffix()
        let GetAllParentID = apiService.GetAllParentID()
        let GetAllChildID = apiService.GetAllChildID()
        //let GetAllBusinessLine = apiService.GetAllBusinessLine()
        let GetAllApplicationCategory = apiService.GetAllApplicationCategory()
        let GetAllLTAApplicationName = apiService.GetAllLTAApplicationName()
        let GetAllLTAStrategyName = apiService.GetAllLTAStrategyName()
        let GetAllVenuetype = apiService.GetAllVenuetype();
        let GetAllStrategytype = apiService.GetAllStrategytype();
        let GetAllCapacity = apiService.GetAllCapacity();
        //let GetAllRegion = apiService.GetAllRegion();
        let GetUsers = UserFactory.GetUser('NA');
        let GetAllStatusType = apiService.GetAllStatusType();
        let GetAllBusinessLine = apiService.GetBusinessMapping(userid)
        let GetAllRegion = apiService.GetuserRegionMapping(userid);
        let GetAllCountry = apiService.GetAllCountry();
        $q.all([
            //GetAllCountry,
            GetAllLTAApplicationCode,
            GetAllThirdPartyAppList,
            GetAllBusiness,
            GetAllLTAStrategyCode,
            GetAllDiscretionaryCode,
            GetAllBusinessSuffix,
            GetAllParentID,
            GetAllChildID,
            //GetAllBusinessLine,
            GetAllApplicationCategory,
            GetAllLTAApplicationName,
            GetAllLTAStrategyName,
            GetAllVenuetype,
            GetAllStrategytype,
            GetAllCapacity,
            //GetAllRegion,
            GetUsers,
            GetAllStatusType,
            GetAllBusinessLine,
            GetAllRegion,
            GetAllCountry,
        ]).then(function (resp) {
            $scope.LTAApplicationCodeList = resp[0].data;
            $scope.ThirdPartyList = resp[1].data;
            $scope.BusinessList = resp[2].data;
            $scope.LTAStrategyCodeList = resp[3].data;
            $scope.DiscretionaryCodeList = resp[4].data;
            $scope.BusinessSuffixList = resp[5].data;
            $scope.ParentIDList = resp[6].data;
            $scope.ChildIDList = resp[7].data;
            $scope.ApplicationCategoryList = resp[8].data;
            $scope.LTAApplicationNameList = resp[9].data;
            $scope.LTAStrategyNameList = resp[10].data;
            $scope.VenuetypeList = resp[11].data;
            $scope.StrategytypeList = resp[12].data;
            $scope.CapacityList = resp[13].data;
            //$scope.RegionMasterList = resp[16].data;
            $scope.LTAStrategyOwnerList = resp[14].data;
            $scope.StrategyStatusType = resp[15].data;
            $scope.BusinessLineList = resp[16].data;
            $scope.RegionMasterList = resp[17].data;
            $scope.CountryMasterList = resp[18].data;

            binddatabusiness($scope.BusinessList);
            binddatabusinessline($scope.BusinessLineList);
            binddataltaapplication($scope.LTAApplicationNameList)
            binddataltastrategyname($scope.LTAStrategyNameList);
            binddataltastrategyowner($scope.LTAStrategyOwnerList);
            binddataregion($scope.RegionMasterList);


            StrategyService.HideLoader();
        });
    };



    $scope.removefilter = function () {
        reset();
    };
    $scope.showfiltercondition = function () {
        $scope.showfilter = true;
    };
    $scope.Export = function () {

        var currency = { Country: '', Region: '', LTAApplicationCode: '', LTAStrategyCode: '', BusinessLine: '', LTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel || $scope.multiselectBusiness.selected.length > 0 || $scope.multiselectBusinessLine.selected.length > 0 || $scope.multiselectLTAApplication.selected.length > 0 || $scope.multiselectLTAStrategy.selected.length > 0 || $scope.multiselectLTAStrategyOwner.selected.length > 0 || $scope.multiselectRegion.selected.length > 0) {
            var idlist = '';
            StrategyService.ShowLoader();
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusiness.selected.length; i++) {
                if (i == $scope.multiselectBusiness.selected.length - 1) {
                    idlist += $scope.multiselectBusiness.selected[i].id;
                    // CountryNames += $scope.multiselectBusiness.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusiness.selected[i].id + ',';
                    // CountryNames += $scope.multiselectBusiness.selected[i].name + ',';
                }
            }
            currency.Business = idlist;



            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusinessLine.selected.length; i++) {
                if (i == $scope.multiselectBusinessLine.selected.length - 1) {
                    idlist += $scope.multiselectBusinessLine.selected[i].id;
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusinessLine.selected[i].id + ',';
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name + ',';
                }
            }
            currency.BusinessLine = idlist;


            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAApplication.selected.length; i++) {
                if (i == $scope.multiselectLTAApplication.selected.length - 1) {
                    idlist += $scope.multiselectLTAApplication.selected[i].id;
                    // CountryNames += $scope.multiselectLTAApplication.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectLTAApplication.selected[i].id + ',';
                    // CountryNames += $scope.multiselectLTAApplication.selected[i].name + ',';
                }
            }
            currency.LTAApplicationName = idlist;




            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAStrategy.selected.length; i++) {
                if (i == $scope.multiselectLTAStrategy.selected.length - 1) {
                    idlist += $scope.multiselectLTAStrategy.selected[i].id;
                    // CountryNames += $scope.multiselectLTAStrategy.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectLTAStrategy.selected[i].id + ',';
                    //   CountryNames += $scope.multiselectLTAStrategy.selected[i].name + ',';
                }
            }
            currency.LTAStrategyName = idlist;

            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAStrategyOwner.selected.length; i++) {
                if (i == $scope.multiselectLTAStrategyOwner.selected.length - 1) {
                    idlist += "'" + $scope.multiselectLTAStrategyOwner.selected[i].id + "'";
                }
                else {
                    idlist += "'" + $scope.multiselectLTAStrategyOwner.selected[i].id + "'" + ',';
                }
            }
            currency.LTAStrategyOwnerId = idlist;


            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectRegion.selected.length; i++) {
                if (i == $scope.multiselectRegion.selected.length - 1) {
                    idlist += $scope.multiselectRegion.selected[i].id;
                    //   CountryNames += $scope.multiselectRegion.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectRegion.selected[i].id + ',';
                    //  CountryNames += $scope.multiselectRegion.selected[i].name + ',';
                }
            }
            currency.Region = idlist;
            if ($scope.selectModel) {
                if ($scope.selectModel.Status)
                    currency.StatusId = $scope.selectModel.Status.Id;
                currency.Priority = $scope.selectModel.Priority;
            }


            ApiCall.MakeApiCall("ExportReport", 'POST', currency).success(function (data) {
                if (data.Error != undefined) {
                    toaster.pop('error', "Error", data.Error, null);
                } else {
                    if (data != 'No Records') {
                        var url = BaseURL + 'Main/DownLoadReportFile?FileName=' + data + '&Page=Report';
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

        var currency = { Country: '', Region: '', LTAApplicationCode: '', LTAStrategyCode: '', BusinessLine: '', LTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel || $scope.multiselectBusiness.selected.length > 0 || $scope.multiselectBusinessLine.selected.length > 0 || $scope.multiselectLTAApplication.selected.length > 0 || $scope.multiselectLTAStrategy.selected.length > 0 || $scope.multiselectLTAStrategyOwner.selected.length > 0 || $scope.multiselectRegion.selected.length > 0) {
            StrategyService.ShowLoader();
            //if ($scope.selectModel.Country)
            //    currency.Country = $scope.selectModel.Country.Id

            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusiness.selected.length; i++) {
                if (i == $scope.multiselectBusiness.selected.length - 1) {
                    idlist += $scope.multiselectBusiness.selected[i].id;
                    // CountryNames += $scope.multiselectBusiness.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusiness.selected[i].id + ',';
                    // CountryNames += $scope.multiselectBusiness.selected[i].name + ',';
                }
            }
            currency.Business = idlist;



            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusinessLine.selected.length; i++) {
                if (i == $scope.multiselectBusinessLine.selected.length - 1) {
                    idlist += $scope.multiselectBusinessLine.selected[i].id;
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusinessLine.selected[i].id + ',';
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name + ',';
                }
            }
            currency.BusinessLine = idlist;


            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAApplication.selected.length; i++) {
                if (i == $scope.multiselectLTAApplication.selected.length - 1) {
                    idlist += $scope.multiselectLTAApplication.selected[i].id;
                    // CountryNames += $scope.multiselectLTAApplication.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectLTAApplication.selected[i].id + ',';
                    // CountryNames += $scope.multiselectLTAApplication.selected[i].name + ',';
                }
            }
            currency.LTAApplicationName = idlist;




            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAStrategy.selected.length; i++) {
                if (i == $scope.multiselectLTAStrategy.selected.length - 1) {
                    idlist += $scope.multiselectLTAStrategy.selected[i].id;
                    // CountryNames += $scope.multiselectLTAStrategy.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectLTAStrategy.selected[i].id + ',';
                    //   CountryNames += $scope.multiselectLTAStrategy.selected[i].name + ',';
                }
            }
            currency.LTAStrategyName = idlist;

            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectLTAStrategyOwner.selected.length; i++) {
                if (i == $scope.multiselectLTAStrategyOwner.selected.length - 1) {
                    idlist += "'" + $scope.multiselectLTAStrategyOwner.selected[i].id + "'";
                }
                else {
                    idlist += "'" + $scope.multiselectLTAStrategyOwner.selected[i].id + "'" + ',';
                }
            }
            currency.LTAStrategyOwnerId = idlist;


            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectRegion.selected.length; i++) {
                if (i == $scope.multiselectRegion.selected.length - 1) {
                    idlist += $scope.multiselectRegion.selected[i].id;
                    //   CountryNames += $scope.multiselectRegion.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectRegion.selected[i].id + ',';
                    //  CountryNames += $scope.multiselectRegion.selected[i].name + ',';
                }
            }
            currency.Region = idlist;
            if ($scope.selectModel) {
                if ($scope.selectModel.Status)
                    currency.StatusId = $scope.selectModel.Status.Id;
                currency.Priority = $scope.selectModel.Priority;
            }
            //if ($scope.selectModel.LTAApplicationCode)
            //    currency.LTAApplicationCode = $scope.selectModel.LTAApplicationCode.Id;
            //if ($scope.selectModel.LTAStrategyCode)
            //    currency.LTAStrategyCode = $scope.selectModel.LTAStrategyCode.Id;
            //if ($scope.selectModel.BusinessLine)
            //    currency.BusinessLine = $scope.selectModel.BusinessLine.Id;
            //if ($scope.selectModel.LTAApplicationOwner)
            //    currency.LTAApplicationOwner = $scope.selectModel.LTAApplicationOwner.userId;
            //if ($scope.selectModel.ApplicationCategory)
            //    currency.ApplicationCategory = $scope.selectModel.ApplicationCategory.Id;
            //if ($scope.selectModel.Venuetype)
            //    currency.VenuetypeId = $scope.selectModel.Venuetype.Id;
            //if ($scope.selectModel.LTAApplicationName)
            //    currency.LTAApplicationNameId = $scope.selectModel.LTAApplicationName.Id;
            //if ($scope.selectModel.ChildID)
            //    currency.ChildID = $scope.selectModel.ChildID.Id;
            //if ($scope.selectModel.ParentID)
            //    currency.ParentID = $scope.selectModel.ParentID.Id;
            //if ($scope.selectModel.ThirdPartyApp)
            //    currency.ThirdPartyAppId = $scope.selectModel.ThirdPartyApp.Id;

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
                    $scope.LTAApplicationOwnerList = data;
                    if (state) {
                        $scope.selectModel.LTAApplicationOwner = getdynamicobjectuserfilter($scope.selectModel.LTAApplicationOwnerId, "LTAApplicationOwnerList")
                    }
                }).error(function (error) {
                    $scope.Error = error;
                })
            }
            else {
                $scope.LTAApplicationOwnerList = [];
            }
        }
        catch (e) {
        }
    }



    $scope.userfilter3 = function () {
        try {
            var Business = $scope.selectModel.LTAApplicationName;

            if (Business != "" && Business != undefined) {
                ApiCall.MakeApiCall("GetAllReportApplicationAutofill?Id=" + Business.Id, 'GET', '').success(function (data) {
                    if (data.length > 0) {
                        $scope.selectModel.LTAApplicationMappingId = data[0].Id;
                        $scope.selectModel.LTAApplicationCode = getdynamicobject(data[0].LTAApplicationCodeId, "LTAApplicationCodeList")
                        $scope.selectModel.LTAApplicationName = getdynamicobject(data[0].LTAApplicationNameId, "LTAApplicationNameList")
                        $scope.selectModel.ChildID = getdynamicobject(data[0].ChildId, "ChildIDList")
                        $scope.selectModel.ThirdPartyApp = getdynamicobject(data[0].ThirdPartyAppId, "ThirdPartyList");
                        $scope.selectModel.ApplicationCategory = getdynamicobject(data[0].ApplicationCategoryId, "ApplicationCategoryList");
                        $scope.selectModel.ParentID = getdynamicobject(data[0].ParentIDValue, "ParentIDList");
                        $scope.selectModel.BusinessLine = getdynamicobject(data[0].BusinessLineId, "");
                        $scope.selectModel.Region = getdynamicobject(data[0].Region, "RegionMasterList");
                        $scope.selectModel.Country = getdynamicobject(data[0].Country, "CountryMasterList");
                        $scope.selectModel.ThirdPartyApp = getdynamicobject(data[0].ThirdPartyAppId, "ThirdPartyList");
                        assignUsers(data[0].Country.split(','));

                        if (Region != "" && BusinessLine != "" && BusinessLine != undefined && Region != undefined) {
                            ApiCall.MakeApiCall("GetUserbyFilter?RegionId=" + Region + "&BusinessLineId=" + BusinessLine, 'GET', '').success(function (data) {
                                $scope.LTAApplicationOwnerList = data;
                                $scope.selectModel.LTAApplicationOwner = getdynamicobjectuserfilter(userid, "LTAApplicationOwnerList")
                            }).error(function (error) {
                                $scope.Error = error;
                            })
                        }
                        else {
                            $scope.LTAApplicationOwnerList = [];
                        }
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
        $scope.selectModel.LTAApplicationMappingId = 0;
        $scope.selectModel.LTAApplicationCode = {};
        //$scope.selectModel.LTAApplicationName = {};
        $scope.selectModel.ChildID = {};
        $scope.selectModel.ThirdPartyApp = {};
        $scope.userfilter1();
    }

    $scope.userfilter4 = function () {
        try {
            var Business = $scope.selectModel.LTAStrategyName;
            if (Business != "" && Business != undefined) {
                ApiCall.MakeApiCall("GetAllLTAStrategyMappingbyId?Id=" + Business.Id, 'GET', '').success(function (data) {
                    if (data.length > 0) {
                        $scope.selectModel.LTAStrategyMappingId = data[0].Id;
                        $scope.selectModel.LTAStrategyCode = getdynamicobject(data[0].LTAStrategyCodeId, "LTAStrategyCodeList")
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
        $scope.selectModel.LTAStrategyCode = {};
        $scope.selectModel.LTAStrategyMappingId = 0;
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
            $scope.getallalgodata(data);
            if (data != '') {
                reportFactory.GetRightsList($scope.userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'Report') {
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

    $scope.multiselectBusinessLine = {
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


    $scope.multiselectRegion = {
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

    $scope.multiselectBusiness = {
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

    $scope.multiselectLTAApplication = {
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


    $scope.multiselectLTAStrategy = {
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

    $scope.multiselectLTAStrategyOwner = {
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

    function assignbusiness(data) {
        $scope.multiselectBusiness.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectBusiness.options.length; k++) {
                if ($scope.multiselectBusiness.options[k].id == data[index].trim()) {
                    $scope.multiselectBusiness.selected.push($scope.multiselectBusiness.options[k]);
                }
            }
        }

    }

    function binddatabusiness(list) {
        $scope.multiselectBusiness.selected = [];

        $scope.multiselectBusiness.options = list.map(function (item) {
            return {
                name: item.Business,
                id: item.Id
            };
        });
    }




    //test

    function assignbusinessline(data) {
        $scope.multiselectBusinessLine.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectBusinessLine.options.length; k++) {
                if ($scope.multiselectBusinessLine.options[k].id == data[index].trim()) {
                    $scope.multiselectBusinessLine.selected.push($scope.multiselectBusinessLine.options[k]);
                }
            }
        }

    }

    function binddatabusinessline(list) {

        $scope.multiselectBusinessLine.selected = [];
        $scope.multiselectBusinessLine.options = list.map(function (item) {
            return {
                name: item.BusinessLine,
                id: item.Id
            };
        });
    }





    function assignltastrategyname(data) {
        $scope.multiselectLTAStrategy.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectLTAStrategy.options.length; k++) {
                if ($scope.multiselectLTAStrategy.options[k].id == data[index].trim()) {
                    $scope.multiselectLTAStrategy.selected.push($scope.multiselectLTAStrategy.options[k]);
                }
            }
        }

    }

    function binddataltastrategyname(list) {
        $scope.multiselectLTAStrategy.selected = [];

        $scope.multiselectLTAStrategy.options = list.map(function (item) {
            return {
                name: item.LTAStrategyName,
                id: item.Id
            };
        });
    }


    function assignltastrategyowner(data) {
        $scope.multiselectLTAStrategyOwner.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectLTAStrategyOwner.options.length; k++) {
                if ($scope.multiselectLTAStrategyOwner.options[k].id == data[index].trim()) {
                    $scope.multiselectLTAStrategyOwner.selected.push($scope.multiselectLTAStrategyOwner.options[k]);
                }
            }
        }

    }

    function binddataltastrategyowner(list) {
        $scope.multiselectLTAStrategyOwner.selected = [];

        $scope.multiselectLTAStrategyOwner.options = list.map(function (item) {
            return {
                name: item.userId,
                id: item.userId
            };
        });
    }



    function assignregion(data) {
        $scope.multiselectRegion.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectRegion.options.length; k++) {
                if ($scope.multiselectRegion.options[k].id == data[index].trim()) {
                    $scope.multiselectRegion.selected.push($scope.multiselectRegion.options[k]);
                }
            }
        }

    }

    function binddataregion(list) {
        $scope.multiselectRegion.selected = [];

        $scope.multiselectRegion.options = list.map(function (item) {
            return {
                name: item.RegionName,
                id: item.Id
            };
        });
    }


    function assignltaapplication(data) {
        $scope.multiselectLTAApplication.selected = [];

        for (index = 0; index < data.length; index++) {

            for (k = 0; k < $scope.multiselectLTAApplication.options.length; k++) {
                if ($scope.multiselectLTAApplication.options[k].id == data[index].trim()) {
                    $scope.multiselectLTAApplication.selected.push($scope.multiselectLTAApplication.options[k]);
                }
            }
        }

    }

    function binddataltaapplication(list) {
        $scope.multiselectLTAApplication.selected = [];

        $scope.multiselectLTAApplication.options = list.map(function (item) {
            return {
                name: item.LTAApplicationName,
                id: item.Id
            };
        });
    }

    $scope.reset = function () {
        binddatabusiness($scope.BusinessList);
        binddatabusinessline($scope.BusinessLineList);
        binddataltaapplication($scope.LTAApplicationNameList)
        binddataltastrategyname($scope.LTAStrategyNameList);
        binddataltastrategyowner($scope.LTAStrategyOwnerList);
        binddataregion($scope.RegionMasterList);

    }

    /*....*/

    $scope.dtOptions1 = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
        .withOption('rowCallback', rowCallback).withOption('scrollX', true);
    $scope.dtColumns1 = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('LTAApplicationName').withTitle('LTA Application Name'),
        DTColumnBuilder.newColumn('LTAApplicationCode').withTitle('LTA AApplication Code'),
        DTColumnBuilder.newColumn('ChildIdValue').withTitle('Child ID'),
        DTColumnBuilder.newColumn('ThirdPartyAppName').withTitle('Third Party Application'),
        DTColumnBuilder.newColumn('ParentID').withTitle('Parent ID'),
        DTColumnBuilder.newColumn('ApplicationCategory').withTitle('Application Category'),
        DTColumnBuilder.newColumn('ApplicationOwnerId').withTitle('Application Owner'),
        DTColumnBuilder.newColumn('BusinessLine').withTitle('Business Line'),
        DTColumnBuilder.newColumn('RegionName').withTitle('Region'),
        DTColumnBuilder.newColumn('CountryName').withTitle('Country'),
    ];


    $scope.Export1 = function () {
        var currency = { Country: '', Region: '', LTAApplicationCode: '', LTAStrategyCode: '', BusinessLine: '', LTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel || $scope.multiselectBusinessLine.selected.length > 0 || $scope.multiselectRegion.selected.length > 0) {
            StrategyService.ShowLoader();
            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusinessLine.selected.length; i++) {
                if (i == $scope.multiselectBusinessLine.selected.length - 1) {
                    idlist += $scope.multiselectBusinessLine.selected[i].id;
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusinessLine.selected[i].id + ',';
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name + ',';
                }
            }
            currency.BusinessLine = idlist;

            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectRegion.selected.length; i++) {
                if (i == $scope.multiselectRegion.selected.length - 1) {
                    idlist += $scope.multiselectRegion.selected[i].id;
                    //   CountryNames += $scope.multiselectRegion.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectRegion.selected[i].id + ',';
                    //  CountryNames += $scope.multiselectRegion.selected[i].name + ',';
                }
            }
            currency.Region = idlist;
            if ($scope.selectModel) {
                if ($scope.selectModel.Status)
                    currency.StatusId = $scope.selectModel.Status.Id;
                currency.Priority = $scope.selectModel.Priority;

                if ($scope.selectModel.LTAApplicationOwner)
                    currency.LTAApplicationOwner = $scope.selectModel.LTAApplicationOwner;
            }
            if ($scope.selectModel.ApplicationCategory)
                currency.ApplicationCategory = $scope.selectModel.ApplicationCategory.Id;
            if ($scope.selectModel.ThirdPartyApp)
                currency.ThirdPartyAppId = $scope.selectModel.ThirdPartyApp.Id;
            currency.ISREPORTPAGE = "Y";
            ApiCall.MakeApiCall("ExportReportFilter", 'POST', currency).success(function (data) {
                if (data.Error != undefined) {
                    toaster.pop('error', "Error", data.Error, null);
                } else {
                    if (data != 'No Records') {
                        var url = BaseURL + 'Main/DownLoadReportFile?FileName=' + data + '&Page=Mapping';
                        $scope.downloadurl = url;
                        setTimeout(function () {
                            $('#downloadpdf')[0].click();
                        }, 1000);
                        //StrategyService.DownLoadReportFile(data);
                    }
                    else {
                        toaster.pop('warning', "Warning", "No records available.", null);
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




    $scope.removefilter1 = function () {
        reset();
    };
    $scope.showfiltercondition1 = function () {
        $scope.showfilter1 = true;
    };
    $scope.showfilter1 = true;
    $scope.showreport1 = function () {
        $scope.showfilter1 = false;

        var currency = { Country: '', Region: '', LTAApplicationCode: '', LTAStrategyCode: '', BusinessLine: '', LTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
        if ($scope.selectModel || $scope.multiselectBusinessLine.selected.length > 0 || $scope.multiselectRegion.selected.length > 0) {
            StrategyService.ShowLoader();
            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectBusinessLine.selected.length; i++) {
                if (i == $scope.multiselectBusinessLine.selected.length - 1) {
                    idlist += $scope.multiselectBusinessLine.selected[i].id;
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectBusinessLine.selected[i].id + ',';
                    //CountryNames += $scope.multiselectBusinessLine.selected[i].name + ',';
                }
            }
            currency.BusinessLine = idlist;


            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselectRegion.selected.length; i++) {
                if (i == $scope.multiselectRegion.selected.length - 1) {
                    idlist += $scope.multiselectRegion.selected[i].id;
                    //   CountryNames += $scope.multiselectRegion.selected[i].name;
                }
                else {
                    idlist += $scope.multiselectRegion.selected[i].id + ',';
                    //  CountryNames += $scope.multiselectRegion.selected[i].name + ',';
                }
            }
            currency.Region = idlist;
            if ($scope.selectModel) {
                if ($scope.selectModel.Status)
                    currency.StatusId = $scope.selectModel.Status.Id;
                currency.Priority = $scope.selectModel.Priority;
            }
            if ($scope.selectModel) {
                if ($scope.selectModel.LTAApplicationOwner)
                    currency.LTAApplicationOwner = $scope.selectModel.LTAApplicationOwner;
                if ($scope.selectModel.ApplicationCategory)
                    currency.ApplicationCategory = $scope.selectModel.ApplicationCategory.Id;
                if ($scope.selectModel.ThirdPartyApp)
                    currency.ThirdPartyAppId = $scope.selectModel.ThirdPartyApp.Id;
            }
            ApiCall.MakeApiCall("GetApplicationReport", 'POST', currency).success(function (data) {
                if (data.Error != undefined) {
                    toaster.pop('error', "Error", data.Error, null);
                } else {
                    $scope.dtOptions1.data = data;
                    StrategyService.HideLoader();
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding Capacity ! " + data.ExceptionMessage;
            });
        }
        else
            toaster.pop('warning', "Warning", 'Please apply report filter condition', null);


    };

}]);



