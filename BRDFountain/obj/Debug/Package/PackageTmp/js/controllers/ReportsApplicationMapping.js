ReportApp.controller('ReportsApplicationMappingController', ['$scope', '$rootScope', '$timeout', 'ApiCall', 'UserFactory', 'reportFactory', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', '$q', 'StrategyService', 'apiService','$sce', function ($scope, $rootScope, $timeout, ApiCall, UserFactory, reportFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder, $q, StrategyService, apiService,$sce) {
    $scope.data = [];
    $scope.showAddwindow = false;
    $scope.editMode = false;
    $scope.IsReadOnly = false;
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
   .withOption('rowCallback', rowCallback).withOption('scrollX', true);
    $scope.dtColumns = [
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
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        return '<a    class="test1"><img src="images/edit.png"></a> <a  ng-click="delete(' + data + ')"></a> <a  ng-click="delete(' + data + ')"><img src="images/delete.png"></a> ';
    }
    $scope.Showadd = function () {
        $scope.Id=  '';
        $scope.Button=  'Add';
        $scope.showAddwindow = true;
        binddata($scope.CountryMasterList);
    }
    $scope.GetAllLTAApplicationMaster = function () {
        var userid = $scope.userId;
        ApiCall.MakeApiCall("GetAllReportApplicationMapping?Id=", 'GET', '').success(function (data) {
            $scope.data = data;
            $scope.dtOptions.data = $scope.data

        }).error(function (error) {
            $scope.Error = error;
        });
        let GetUsers = UserFactory.GetUser('NA');
        let GetAllLTAApplicationCode = apiService.GetAllLTAApplicationCode()
        let GetAllThirdPartyAppList = apiService.GetAllThirdPartyAppList()
        let GetAllLTAStrategyCode = apiService.GetAllLTAStrategyCode()
        let GetAllParentID = apiService.GetAllParentID()
        let GetAllChildID = apiService.GetAllChildID()
        let GetAllApplicationCategory = apiService.GetAllApplicationCategory()
        let GetAllLTAApplicationName = apiService.GetAllLTAApplicationName()
        let GetAllRegion = apiService.GetuserRegionMapping(userid);
        let GetAllCountry = apiService.GetusercountryMapping(userid);
        let GetAllBusinessLine = apiService.GetBusinessMapping(userid)

       

        $q.all([
                GetAllLTAApplicationCode,
        GetAllThirdPartyAppList,
        GetAllParentID,
        GetAllChildID,
        GetAllApplicationCategory,
        GetAllLTAApplicationName,
        GetUsers,
        GetAllBusinessLine,
        GetAllCountry,
        GetAllRegion
        ]).then(function (resp) {
            $scope.LTAApplicationCodeList = resp[0].data;
            $scope.ThirdPartyList = resp[1].data;
            $scope.ParentIDList = resp[2].data;
            $scope.ChildIDList = resp[3].data;
            $scope.ApplicationCategoryList = resp[4].data;
            $scope.LTAApplicationNameList = resp[5].data;
            $scope.LTAApplicationOwnerList = resp[6].data;
            $scope.BusinessLineList = resp[7].data;
            $scope.CountryMasterList = resp[8].data;
            $scope.RegionMasterList = resp[9].data;
            
            binddata($scope.CountryMasterList);
        });
        $timeout(function () {
            StrategyService.HideLoader();
        }, 1000)
    };

    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
    
        $('.test1', nRow).unbind('click');
        $('.test1', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.edit(aData);
            });
        });
    

        return nRow;
    }

    $scope.edit=function(input)
    {
        $scope.Button=  'Update';
        $scope.showAddwindow = true;
        $scope.Id=  input.Id;
        $scope.selectModel={};
        //$scope.selectModel.LTAApplicationMappingId =input.Id;
        $scope.selectModel.LTAApplicationCode = getdynamicobject(input.LTAApplicationCodeId, "LTAApplicationCodeList")
        $scope.selectModel.LTAApplicationName = getdynamicobject(input.LTAApplicationNameId, "LTAApplicationNameList")
        $scope.selectModel.ChildID = getdynamicobject(input.ChildId, "ChildIDList")
        $scope.selectModel.ThirdPartyApp = getdynamicobject(input.ThirdPartyAppId, "ThirdPartyList");
        $scope.selectModel.ApplicationCategory = getdynamicobject(input.ApplicationCategoryId, "ApplicationCategoryList");
        $scope.selectModel.ParentID = getdynamicobject(input.ParentIDValue, "ParentIDList");
        $scope.selectModel.BusinessLine = getdynamicobject(input.BusinessLineId, "BusinessLineList");
        $scope.selectModel.Region = getdynamicobject(input.Region, "RegionMasterList");
        //$scope.selectModel.Country = getdynamicobject(input.Country, "CountryMasterList");
        $scope.selectModel.ThirdPartyApp = getdynamicobject(input.ThirdPartyAppId, "ThirdPartyList");
        var Region =input.Region;
        var BusinessLine = input.BusinessLineId;
        var userid =  input.ApplicationOwner;
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
        binddata($scope.CountryMasterList);

        assignUsers(input.Country.split(','));

    }

    var getdynamicobjectuserfilter = function (userId, type) {
        for (var i = 0; i < $scope[type].length; i++) {
            if ($scope[type][i].userId == userId) {
                return $scope[type][i];
            }
        }
    };
    var getdynamicobject = function (userId, type) {
        for (var i = 0; i < $scope[type].length; i++) {
            if ($scope[type][i].Id == userId) {
                return $scope[type][i];
            }
        }
    };
    $scope.Export = function () {
        var currency = { Country: '', Region: '', LTAApplicationCode: '', LTAStrategyCode: '', BusinessLine: '', LTAStrategyOwner: '', ApplicationCategory: '', Venuetype: '' };
      
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
        //}
        //else
        //    toaster.pop('warning', "Warning", 'Please apply report filter condition', null);
    };

    $scope.add = function (LTAApplicationMaster) {
        if (LTAApplicationMaster != null) {
            var idlist = '';
            var CountryNames = '';
            for (var i = 0; i < $scope.multiselect.selected.length; i++) {
                if(i==$scope.multiselect.selected.length-1)
                {
                    idlist += $scope.multiselect.selected[i].id ;
                    CountryNames += $scope.multiselect.selected[i].name;
                }
                else{
                    idlist += $scope.multiselect.selected[i].id + ',';
                    CountryNames += $scope.multiselect.selected[i].name + ',';
                }
            }
            if (LTAApplicationMaster.LTAApplicationName.LTAApplicationName && LTAApplicationMaster.LTAApplicationCode.LTAApplicationCode && LTAApplicationMaster.ChildID.ChildID && LTAApplicationMaster.ThirdPartyApp.Value && LTAApplicationMaster.BusinessLine && $scope.multiselect.selected.length >0 && LTAApplicationMaster.Region) {
                var input = {
                    Id:  $scope.Id,
                    LTAApplicationNameId: LTAApplicationMaster.LTAApplicationName.Id, LTAApplicationCodeId: LTAApplicationMaster.LTAApplicationCode.Id, ChildID: LTAApplicationMaster.ChildID.Id, ThirdPartyAppId: LTAApplicationMaster.ThirdPartyApp.Id,
                    ParentID: LTAApplicationMaster.ParentID.Id, ApplicationOwnerId: LTAApplicationMaster.LTAApplicationOwner.userId, ApplicationCategoryId: LTAApplicationMaster.ApplicationCategory.Id,
                    BusinessLineId: LTAApplicationMaster.BusinessLine.Id,
                    //   Country: LTAApplicationMaster.Country.Id,
                    Region: LTAApplicationMaster.Region.Id,
                    Country:idlist
                };

                ApiCall.MakeApiCall("AddReportMapping", 'POST', input).success(function (data) {
                    if (data.Error != undefined) {
                        toaster.pop('error', "Error", data.Error, null);
                    } else {
                        if (data == "success") {
                            $scope.LTAApplicationMaster = null;
                            $scope.GetAllLTAApplicationMaster();
                            $scope.editMode = false;

                            $scope.showAddwindow = false;
                            toaster.pop('success', "Success", 'Report Application Mapping added successfully', null);
                        }
                        else
                            toaster.pop('warning', "Warning", data, null);
                    }
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding LTAApplication ! " + data.ExceptionMessage;
                });
            }
            else {
                toaster.pop('warning', "Warning", 'Please enter LTAApplication', null);
            }
        }
        else {
            toaster.pop('warning', "Warning", 'Please enter LTAApplication', null);
        }
    };



    $scope.GetLTAApplicationMasterById = function (LTAApplicationMasterId) {
        ApiCall.MakeApiCall("GetAllLTAApplication?LTAApplicationId=" + LTAApplicationMasterId, 'GET', '').success(function (data) {
            $scope.editMode = true;
            $scope.showAddwindow = true;
            $scope.LTAApplicationMaster = data[0];
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding LTAApplication! " + data.ExceptionMessage;
        });
    };


    $scope.delete = function (id) {
        ApiCall.MakeApiCall("DeleteReportApplicationMapping?Id=" + id, 'GET', '').success(function (data) {
            if (data == "success") {
                $scope.LTAApplicationMaster = null;
                $scope.editMode = false;
                $scope.GetAllLTAApplicationMaster();
                $('#confirmModal').modal('hide');
                $scope.showAddwindow = false;
                toaster.pop('success', "Success", 'Report Application Mapping deleted successfully', null);
            }
            else
                toaster.pop('warning', "Warning", data, null);
        }).error(function (data) {
            $scope.error = "An Error has occured while deleting user! " + data.ExceptionMessage;
        });
    };

    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    $scope.showconfirm = function (data) {
        $scope.LTAApplicationMasterId = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.LTAApplicationMaster = null;
        $scope.editMode = false;
        $scope.showAddwindow = false;
        $('#confirmModal').modal('hide');
    };

    $scope.GetRightsList = function () {
        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            $scope.userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'LTAApplication Write') {
                            isRead = false;
                        }
                    })
                    if (!isRead) {
                        $scope.IsReadOnly = false;
                    }
                    $scope.GetAllLTAApplicationMaster();
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    };
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
    function assignUsers(data) {
        $scope.multiselect.selected=[];
        
        for (index = 0; index < data.length; index++) {

            for(k=0;k<$scope.multiselect.options.length;k++)
            {
                if($scope.multiselect.options[k].id==data[index].trim())
                {
                    $scope.multiselect.selected.push($scope.multiselect.options[k]);
                }
            }
        }
        // binddata($scope.CountryMasterList); 
    }
    function binddata(list) {
        $scope.multiselect.selected=[];
        $scope.multiselect.options = list.map(function (item) {
            return {
                name: item.CountryName,
                id: item.Id
            };
        });
    }



    $scope.GetRightsList();

}]);