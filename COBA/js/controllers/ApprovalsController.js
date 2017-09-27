ReportApp.controller('ApprovalsController', function ($scope, $rootScope, StrategyService, TaskService, $timeout, $filter) {
    $scope.errorinfo = '';
    $scope.CurrencyList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.SBU = [];
    $scope.Region = [];
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.ecurrency = {};
    $scope.LockedPriceSheet = [];
    
    
    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };
    $scope.tab1 = true;
    $scope.tab2 = false
    $scope.activatetab = function (id) {
        if(id==1)
        {
            $scope.tab1 = true;
            $scope.tab2 = false;
        }
        else
        {
            $scope.tab1 = false;
            $scope.tab2 = true;
        }
    }
    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];
    $scope.Selcurrentversion = 0;

    $scope.GetCurrencyConversionForId = function (RefNumber, Approver, Version, Comments, ApprovedDate, Status) {
        $('#LayoutModel1').modal('show');
        $scope.notificationExist = true;
        $scope.currency = { 'Comments': Comments, 'RefNumber': RefNumber, 'Approver': Approver, 'Version': Version, 'Comments': Comments, 'ApprovedDate': ApprovedDate, 'Status': Status };
        debugger
        if ($scope.currency.Status == "Y")
            $scope.Status = true;
        else
            $scope.Status = false;
        $scope.OStatus = angular.copy($scope.Status);

    };

    $scope.changestatus = function (status) {
        $timeout(function () { $scope.Status = status; });
    }

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



    $scope.GetAlldata = function () {
        StrategyService.GetStrategyApprovalByuser().success(function (data) {
            $timeout(function () {
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }
                $scope.CurrencyGrid.data = data;
            }, 100)
        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAlldata();


    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    var columnDefs = [
        { name: 'RefNumber' },
        {
            name: 'Version',
            cellTemplate: '<div class="ui-grid-cell-contents"> {{row.entity.Ver}}</div>'
        },

        //{ headerName: 'Description', name: 'Description', width: 440 },
        //{
        //    headerName: 'SignOff Status', name: 'IsSignOff', width: 40, cellRenderer: function (params) {
        //        if (params.data.IsSignOff == "Y")
        //            return "<i class='fa fa-check btn-success btn-circle'></i>"
        //        else
        //            return "<i class='fa fa-close btn-danger btn-circle'></i>"
        //    }
        //},
        {
            name: 'Status'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.Status=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.Status=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },

        {
            name: 'Action'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.RefNumber,row.entity.Approver,row.entity.Version,row.entity.Comments,row.entity.ApprovedDate,row.entity.Status)" ><i class="fa fa-edit" ></i></a ></div>'
            , visible: $scope.IsReadOnly
        },
        //{
        //    field: 'Approvals', width: 70, cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForIdView(row.entity.RefNumber,row.entity.Version)" ><i class="fa fa-eye" ></i></a ></div>'

        //}
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


    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;
        if ($scope.Status)
            model.Status = "Y";
        else
            model.Status = "N";
        TaskService.UpdateStrategyApprover(model).success(function (data) {
            if (data == "success") {
                $scope.editMode = false;
                //toaster.pop('success', "Success", "Currency rate updated successfully", null);
                $timeout(function () {
                    $scope.GetAlldata();
                })

                $('#LayoutModel1').modal('hide');
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
        $('#LayoutModel1').modal('hide');
    };

    var columnDefs1 = [
        { name: 'Approver' },
        { name: 'RefNumber' },
        {
            name: 'Version',
            cellTemplate: '<div class="ui-grid-cell-contents"> {{row.entity.Ver}}</div>'
        },

        //{ headerName: 'Description', name: 'Description', width: 440 },
        //{
        //    headerName: 'SignOff Status', name: 'IsSignOff', width: 40, cellRenderer: function (params) {
        //        if (params.data.IsSignOff == "Y")
        //            return "<i class='fa fa-check btn-success btn-circle'></i>"
        //        else
        //            return "<i class='fa fa-close btn-danger btn-circle'></i>"
        //    }
        //},
        {
            name: 'Status'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.Status=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.Status=="Y"}}><i class="fa fa-check" ></i></a> </div>'
        },

           //{
        //    field: 'Approvals', width: 70, cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForIdView(row.entity.RefNumber,row.entity.Version)" ><i class="fa fa-eye" ></i></a ></div>'

        //}
    ];


    $scope.TransferGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: columnDefs1,

    };


    $scope.GetAlltransdata = function () {
        StrategyService.Get_ApprovaltransferByuser().success(function (data) {
            $timeout(function () {
                for (var i = 0; i < data.length; i++) {
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                }
                $scope.TransferGrid.data = data;
            }, 100)
        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAlltransdata();


});