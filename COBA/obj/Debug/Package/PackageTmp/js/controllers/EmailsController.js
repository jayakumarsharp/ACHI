ReportApp.controller('EmailController', function ($scope, $rootScope, EmailService, $timeout, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.errorinfo = '';
    $scope.checked = true;
    $scope.test = { item: 'true' };
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.SBU = [];
    $scope.Region = [];
    $scope.Currency = [];
    $scope.LegalEntity = [];
    $scope.ecurrency = {};
    $scope.LockedPriceSheet = [];
    $scope.GetRightsList = function () {
        $scope.item = 'true';
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };

    $scope.getallcurrencyconversions = function () {

        EmailService.GetAllTask().success(function (data) {
            console.log(data)

            $scope.dtOptions.data = data;
            //$scope.CurrencyGrid.api.setRowData(data);
        })
    };

    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    //var columnDefs = [{ headerName: '', hide: true, field: 'Id', width: 1 },
    //{ headerName: 'ClientNumber', field: 'ClientNumber', width: 320 },
    //{ headerName: 'TaskId', field: 'TaskId', width: 320, hide: true },
    //{ headerName: 'EmailSubject', field: 'EmailSubject', width: 320 },
    //{ headerName: 'EmailId', field: 'EmailId', width: 320 },
    //{ headerName: 'IsActive', field: 'IsActive', width: 320, hide: true },
    //{ headerName: 'IsMappedToTask', field: 'IsMappedToTask', width: 320, hide: true },
    //{ headerName: 'IsProcessed', field: 'IsProcessed', width: 320 },
    //{ headerName: 'CreatedDate', field: 'CreatedDate', width: 320 },
    //{ headerName: 'EmailAttachment', field: 'EmailAttachment', width: 320 },
    //{ headerName: 'CreatedBy', field: 'CreatedBy', width: 320 },
    //{ headerName: 'EmailContent', field: 'EmailContent', width: 320 },
    //{ headerName: 'LastModifiedBy', field: 'LastModifiedBy', width: 320, hide: true },
    //    { headerName: 'LastModifiedDate', field: 'LastModifiedDate', width: 320, hide: true },
    //    { headerName: 'TaskAssignedBy', field: 'TaskAssignedBy', width: 320, hide: true },
    //    { headerName: 'TaskAssignedDate', field: 'TaskAssignedDate', width: 320, hide: true },
    //    { headerName: 'TaskAttachement', field: 'TaskAttachement', width: 320 },
    //    { headerName: 'TaskComments', field: 'TaskComments', width: 320 },
    //    { headerName: 'UniqueEmailId', field: 'UniqueEmailId', width: 320, hide: true },
    //    //{ headerName: 'Description', field: 'Description', width: 440 },
    //    { headerName: 'SignOff Status', field: 'IsSignOff', width: 140 },
    //    {
    //        headerName: 'Action', width: 200, field: 'abc', cellStyle: { 'text-align': 'center', 'display': 'flex', 'align-items': 'center' }, cellRenderer: function (params) {
    //            return "</span><a data-ng-click=\"GetCurrencyConversionForId('" + params.data.Id + "')\" href=\"javascript:;\"> Edit</a>";
    //        }
    //    }];

    $scope.dtOptions = DTOptionsBuilder.fromSource()
   .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
    //    DTColumnBuilder.newColumn('ClientNumber').withTitle('ClientNumber'),
    //DTColumnBuilder.newColumn('TaskId').withTitle('TaskId'),
    DTColumnBuilder.newColumn('EmailId').withTitle('EmailId'),
    DTColumnBuilder.newColumn('EmailSubject').withTitle('EmailSubject'),
    DTColumnBuilder.newColumn('IsActive').withTitle('IsActive'),
    DTColumnBuilder.newColumn('IsMappedToTask').withTitle('IsMappedToTask'),
    DTColumnBuilder.newColumn('IsProcessed').withTitle('IsProcessed'),
    DTColumnBuilder.newColumn('CreatedDate').withTitle('CreatedDate'),
    //DTColumnBuilder.newColumn('EmailAttachment').withTitle('EmailAttachment'),
    //DTColumnBuilder.newColumn('CreatedBy').withTitle('CreatedBy'),
    //DTColumnBuilder.newColumn('EmailContent').withTitle('EmailContent'),
    //DTColumnBuilder.newColumn('LastModifiedBy').withTitle('LastModifiedBy'),
    //DTColumnBuilder.newColumn('LastModifiedDate').withTitle('LastModifiedDate'),
    //DTColumnBuilder.newColumn('TaskAssignedBy').withTitle('TaskAssignedBy'),
    //DTColumnBuilder.newColumn('TaskAssignedDate').withTitle('TaskAssignedDate'),
    //DTColumnBuilder.newColumn('TaskAttachement').withTitle('TaskAttachement'),
    //DTColumnBuilder.newColumn('TaskComments').withTitle('TaskComments'),
    //DTColumnBuilder.newColumn('UniqueEmailId').withTitle('UniqueEmailId'),
    ////{ headerName: 'Description').withTitle('Description', width: 440 },
    //DTColumnBuilder.newColumn('SignOff Status').withTitle('IsSignOff'),
    //DTColumnBuilder.newColumn('Name').withTitle('Name'),
  //  DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable().renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        return '<a  ng-click="GetCurrencyConversionForId(' + data + ')"><img src="images/edit.png"></a> ';
        //+'<button class="btn btn-danger" ng-click="delete(' + data + ')" )"="">' +
        //'   <i class="fa fa-trash-o"></i>' +
        //'</button>';
    }
    $scope.getallcurrencyconversions();

    $scope.showadd = function () {
        $timeout(function () {
            $scope.errorinfo = '';
            $scope.EmailActive = false;
        }, 100);

        //$scope.checked = 'true';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };

    $scope.GetAllCurrency = function () {
        EmailService.GetAllTask().success(function (data) {
            $scope.Currency = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.add = function (currency) {
        if (currency != null) {
            currency.IsActive = "Y";
            currency.IsSignOff = "Y";
            currency.IsSignOff = (currency.IsSignOff == "checked" ? "Y" : 'N');
            EmailService.AddTask(currency).success(function (data) {
                if (data == "success") {
                    $scope.getallcurrencyconversions()
                    $('#currencyModel').modal('hide');
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        EmailService.GetAllTaskById(id).success(function (data) {
            $scope.editMode = true;
            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };



    $scope.UpdatecurrencyConversion = function (model) {
        model.UpdatedBy = '';//$rootScope.UserInfo.user.userId;
        EmailService.UpdatecurrencyConversion(model).success(function (data) {
            $scope.editMode = false;
            toaster.pop('success', "Success", "Currency rate updated successfully", null);
            $('#currencyModel').modal('hide');
            $scope.getallcurrencyconversions()
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
        EmailService.GetCurrencyConversionbyId(id).success(function (data) {
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

    $scope.GetRightsList();

});