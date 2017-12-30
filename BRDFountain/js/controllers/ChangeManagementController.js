ReportApp.controller('ChangeManagementController', ['$scope', '$rootScope', 'StrategyService', 'TaskService', '$timeout', '$filter', 'UserFactory', 'reportFactory', 'ApiCall', 'toaster', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', function ($scope, $rootScope, StrategyService, TaskService, $timeout, $filter, UserFactory, reportFactory, ApiCall, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];
    $scope.Selcurrentversion = 0;

    $scope.IsModelAlgopage = false;

    $scope.pageList = [{ Page: false, isValid: false }, { Page: false, isValid: false }, { Page: false, isValid: false, isValid: false }, { Page: true, isValid: false }];
    $scope.errorinfo = '';
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.showaction = false;


    $scope.activateTab = function (tabid) {
        for (var i = 0; i < $scope.pageList.length; i++) {
            $scope.pageList[i].Page = false;
        }
        $scope.pageList[tabid].Page = true;
    }

    $scope.selectModel = { Application: {}, Country: {}, ProductType: {}, BusinessSector: {}, Region: {} };

    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
      .withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('RefNumber').withTitle('RefNumber'),
        DTColumnBuilder.newColumn('Name').withTitle('Name'),
        DTColumnBuilder.newColumn('BusinessSectorName').withTitle('Business Sector'),
        DTColumnBuilder.newColumn('Ver').withTitle('Version'),
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
        return '<a class="test" ><img src="images/edit.png"></a>' +
        '&nbsp;<a  class="test1"><img style="width:24px;height:24px;" src="images/eyeicon.png"></a>';
    }

    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.test', nRow).unbind('click');
        $('.test', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.GetVersionDataview(aData.Id, aData.RefNumber, aData.Version);
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

    $scope.GetCurrencyConversionForIdView = function (id, Version) {
        $scope.ViewData = [];
        StrategyService.GetStrategyApprovalById(id, Version).success(function (data) {
            $('#viewApprovals').modal('show');
            $scope.ViewData = data;
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });

    };

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
    $scope.Gridata = [];
    $scope.GetVersions = function (data) {
        if (data != undefined) {
            StrategyService.GetStrategyDatabyStrategyId(data).success(function (data) {
                $scope.StrategyVersiondata = data;
                $scope.currency = $filter('orderBy')($scope.StrategyVersiondata, '-Version')[0];
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }
                $scope.data = data;
                $scope.dtOptions.data = $scope.data
            })
        }
    };



    $scope.GetVersionDataview = function (id, RefNumber, Version) {
        $scope.activateTab(3);
        $scope.showaction = true;
        $scope.GetCurrencyConversionForId(id);
        StrategyService.GetStrategyApprovalById(RefNumber, Version).success(function (data) {
            console.log(data);
            $scope.Availableusers = data;
            for (var i = 0; i < data.length; i++) {
                data[i].Id = i;
            }
            ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + $scope.selectModel.Country.Id + "&RegionId=" + $scope.selectModel.BusinessSector.Id + "&BusinessSectorId=" + $scope.selectModel.Region.Id, 'GET', '').success(function (adata) {
                $scope.aEstimationProduct = [];
                for (var k = 0; k < adata.length; k++) {
                    $scope.aEstimationProduct.push({ RefNumber: '', Approver: adata[k].userId, Id: adata[k].Id });
                }
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
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    }

    $scope.GetCurrencyConversionForId = function (id) {
        StrategyService.GetDatabyId(id).success(function (data) {
            $scope.currency = data[0];
            $scope.selectModel.Application = getdynamicobjectgetdynamicobject($scope.currency.ApplicationId, "ApplicationMasterList")
            $scope.selectModel.Country = getdynamicobject($scope.currency.Country, "CountryMasterList")
            $scope.selectModel.ProductType = getdynamicobject($scope.currency.ProductType, "ProductMasterList")
            $scope.selectModel.BusinessSector = getdynamicobject($scope.currency.BusinessSector, "BusinessSectorMasterList")
            $scope.selectModel.Region = getdynamicobject($scope.currency.Region, "RegionMasterList")

            $('#currencyModel').modal('show');
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

    $scope.SaveNewversionStrategy = function (currency) {
        //if ($scope.StrategyActive)
        //    currency.IsActive = "Y";
        //else
        //    currency.IsActive = "N";

        //if ($scope.IsSignOff)
        //    currency.IsSignOff = "Y";
        //else
        //    currency.IsSignOff = "N";

        if ($scope.listB_Estimation.length > 0) {
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
                            toaster.pop('success', "Success", "Model/Algo new version added successfully", null);
                            $scope.GetVersions($scope.RefNumber);
                        });
                        $scope.showaction = false;

                        $('#currencyModel').modal('hide');
                    }
                    else
                        $scope.errorinfo = data;
                }).error(function (data) {
                    $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
                });
            }
        }
        else
            toaster.pop('warning', "Warning", "Please select approvers", null);
    };

    $scope.Availableusers = [];

    $scope.UpdateChange = function (model) {
        model.Page = "C";
        if ($scope.listB_Estimation.length > 0) {
            StrategyService.UpdateStrategy(model).success(function (data) {
                if (data == "success") {
                    if ($scope.listB_Estimation != null && $scope.listB_Estimation.length > 0) {
                        $scope.listB_Estimation[0].RefNumber = model.RefNumber;
                        $scope.listB_Estimation[0].Version = model.Version;

                        StrategyService.InsertStrategyApprover($scope.listB_Estimation).success(function (data) {
                            toaster.pop('success', "Success", "Model/Algo updated successfully", null);
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
                    //$('#currencyModel').modal('hide');
                    $scope.showaction = false;
                    $scope.getallcurrencyconversions()
                }
                else
                    $scope.errorinfo = data;
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
        $scope.ecurrency = {};
        //$('#currencyModel').modal('hide');
        $scope.showaction = false;
        $('#confirmModal').modal('hide');
    };

    $scope.updatecancel = function (data) {
        TaskService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
            $scope.ecurrency = data[0];
            $scope.showaction = true;

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
            if (Country != "" && BusinessSector != "" && Region != "") {
                ApiCall.MakeApiCall("GetUserbyFilter?CountryId=" + Country + "&RegionId=" + Region + "&BusinessSectorId=" + BusinessSector, 'GET', '').success(function (data) {
                    console.log(data);
                    $scope.listA_Estimation = [];
                    $scope.listB_Estimation = [];
                    $scope.EstimationProduct = [];
                    for (var k = 0; k < data.length; k++) {
                        $scope.EstimationProduct.push({ Approver: data[k].userId, Id: data[k].Id });
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
    $scope.GetRightsList();

    $scope.upload = function () {
        if ($scope.upload_form.file.$valid && $scope.file) { //check if from is valid
            var uploaddata = $scope.ecurrency;
            //uploaddata.Attachment = $scope.file;
            uploaddata.filename = $scope.file[0].name;
            Upload.upload({
                url: 'UpdateOnboardingTask', //webAPI exposed to upload the file
                data: { Id: $scope.ecurrency.Id, TaskComments: $scope.ecurrency.TaskComments, ClientNumber: $scope.ecurrency.ClientNumber, ExisitingFiles: $scope.ecurrency.TaskAttachment, obj: $scope.file }//pass file as data, should be user ng-model
            }).then(function (resp) { //upload function returns a promise
                if (resp.data.error_code === 0) { //validate success
                    console.log(resp.data)


                } else {
                    $window.alert('an error occured');
                }
            }, function (resp) { //catch error
                console.log('Error status: ' + resp.status);
                $window.alert('Error status: ' + resp.status);
            }, function (evt) {
                console.log(evt);
                var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                console.log('progress: ' + progressPercentage + '% ' + evt.config.data.name);
                $scope.progress = 'progress: ' + progressPercentage + '% '; // capture upload progress
            });
        };

    }
}]);