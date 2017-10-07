ReportApp.controller('ApprovalsController', function ($scope, $rootScope, StrategyService, $timeout, $filter, UserFactory, reportFactory, toaster, TaskService) {
    $scope.errorinfo = '';
    $scope.CurrencyList = [];
    $scope.editMode = false;
    $scope.IsReadOnly = true;
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
    $scope.tab3 = false
    $scope.tab4 = false
    $scope.activatetab = function (id) {
        if (id == 1) {
            $scope.tab1 = true;
            $scope.tab2 = false;
            $scope.tab3 = false;
            $scope.tab4 = false;
        }
        else if (id == 2) {
            $scope.tab1 = false;
            $scope.tab2 = true;
            $scope.tab3 = false;
            $scope.tab4 = false;
        }
        else if (id == 3) {
            $scope.tab1 = false;
            $scope.tab2 = false;
            $scope.tab3 = true;
            $scope.tab4 = false;
        }
        else if (id == 4) {
            $scope.tab1 = false;
            $scope.tab2 = false;
            $scope.tab3 = false;
            $scope.tab4 = true;
        }
    }
    $scope.Strategydata = [];
    $scope.StrategyVersiondata = [];
    $scope.Selcurrentversion = 0;

    $scope.GetCurrencyConversionForId = function (RefNumber, Approver, Version, Comments, ApprovedDate, Status) {
        $('#LayoutModel1').modal('show');
        $scope.notificationExist = true;
        $scope.currency = { 'Comments': Comments, 'RefNumber': RefNumber, 'Approver': Approver, 'Version': Version, 'Comments': Comments, 'ApprovedDate': ApprovedDate, 'Status': Status };

        //if ($scope.currency.Status == "Y")
        //    $scope.Status = true;
        //else
        //    $scope.Status = false;
        //$scope.OStatus = angular.copy($scope.Status);

    };

    $scope.changestatus = function (status) {
        $timeout(function () { $scope.currency.Status = status; });
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

    $scope.PendingGriddata = [];
    $scope.CompletedGriddata = [];


    $scope.GetAlldata = function () {
        StrategyService.GetStrategyApprovalByuser().success(function (data) {
            $timeout(function () {
                debugger;
                $scope.PendingGriddata = [];
                $scope.CompletedGriddata = [];
                for (var i = 0; i < data.length; i++) {
                    console.log(data[i])
                    data[i].Ver = "Version - " + data[i].Version;
                    data[i].Version = data[i].Version;
                    if (data[i].Status == 'N' || data[i].Status == 'Y')
                        $scope.CompletedGriddata.push(data[i])
                    else
                        $scope.PendingGriddata.push(data[i])

                }

                $scope.PendingGrid.data = $scope.PendingGriddata;
                $scope.CompletedGrid.data = $scope.CompletedGriddata;
            }, 100)
        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAlldata();



    var PendingcolumnDefs = [
        { name: 'RefNumber', width: 140 },
        // { name: 'Name', displayName: 'Name', width: 100 },
        //{ name: 'BusinessSectorName', displayName: 'Business Sector', width: 120 },

        {
            name: 'Version', width: 140,
            cellTemplate: '<div class="ui-grid-cell-contents"> {{row.entity.Ver}}</div>'
        },


        {
            name: 'Action', width: '*'
            , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.RefNumber,row.entity.Approver,row.entity.Version,row.entity.Comments,row.entity.ApprovedDate,row.entity.Status)" ><i class="fa fa-edit" ></i></a ></div>'
            , visible: $scope.IsReadOnly
        },

    ];



    var CompletedcolumnDefs = [
        { name: 'RefNumber', width: 100 },
        // { name: 'Name', displayName: 'Name', width: 80 },
        //{ name: 'BusinessSectorName', displayName: 'Business Sector', width: 110 },
        {
            name: 'Version', width: 80,
            cellTemplate: '<div class="ui-grid-cell-contents"> {{row.entity.Ver}}</div>'
        },
        {
            name: 'Status', width: 80
            , cellTemplate: '<div class="ui-grid-cell-contents"> <input type="button" class="btn btn-success" ng-show={{row.entity.Status=="Y"}} value="Approved" /><input type="button" class="btn btn-danger" ng-show={{row.entity.Status=="N"}} value="Rejected" /></div>'
        },
         {
             name: 'Comments', width: 140

         },
        {
            name: 'ApprovedDate', displayName: 'Date', width: 80
        },


    ];


    $scope.PendingGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: PendingcolumnDefs,

    };

    $scope.CompletedGrid = {
        paginationPageSizes: [10, 20, 30, 40, 50, 60],
        paginationPageSize: 10,
        columnDefs: CompletedcolumnDefs,

    };


    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;
       
        TaskService.UpdateStrategyApprover(model).success(function (data) {
            if (data == "success") {
                $scope.editMode = false;

                if ($scope.currency.Status == "Y") {

                }
                else if ($scope.currency.Status == "N")
                {

                }

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

    $scope.showconfirm = function (data) {
        $scope.Id = data;
        $('#confirmModal').modal('show');
    };

    $scope.cancel = function () {
        $scope.currency = {};
        $scope.ecurrency = {};
        $('#LayoutModel1').modal('hide');
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