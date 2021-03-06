﻿ReportApp.controller('ClientController', ['$scope', '$rootScope', 'ClientService', '$timeout', '$compile', 'DTOptionsBuilder', 'DTColumnBuilder', 'toaster',function ($scope, $rootScope, ClientService, $timeout, $compile, DTOptionsBuilder, DTColumnBuilder, toaster) {
    $scope.errorinfo = '';
    $scope.editMode = false;
    $scope.IsReadOnly = true;
    $scope.showaction = false;
    $scope.LoanTypeList = [{ value: 'Investment Loan' }, { value: 'Development Loan' }]
    $scope.StructureList = [{ value: 'Yes' }, { value: 'No' }]
    $scope.pageList = [{ Page: true, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }, { Page: false, IsValid: false }];
    $scope.activateTab = function (tabid) {
        for (var i = 0; i < $scope.pageList.length; i++) {
            $scope.pageList[i].Page = false;
        }
        $scope.pageList[tabid].Page = true;
        $scope.pageList[tabid].IsValid = true;
    }
    $scope.Confirmcancel = function () {
        $('#confirmModal').modal('show');
    }

    $scope.showerror = function () {
        $('#showreadonly').modal('show');

    }

    $scope.getclientdata = function () {
        ClientService.GetAllCurrency().success(function (data) {
            console.log(data);
            $scope.dtOptions.data = data
        })
    };
    $scope.dtOptions = DTOptionsBuilder.fromSource()
      .withPaginationType('full_numbers').withOption('createdRow', createdRow).withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
        DTColumnBuilder.newColumn('ClientNumber').withTitle('Client Number'),
        DTColumnBuilder.newColumn('ObligorName').withTitle('Obligor Name'),
        DTColumnBuilder.newColumn('OriginalLender').withTitle('Original Lender'),
        DTColumnBuilder.newColumn('LCompanyName').withTitle('LCompany Name'),
        DTColumnBuilder.newColumn('BCompanyName').withTitle('BCompany Name'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        return '<a  class="test"><img src="images/edit.png"></a> ';
    }
    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.test', nRow).unbind('click');
        $('.test', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.GetCurrencyConversionForId(aData.ClientNumber);
            });
        });
    }
    $scope.showadd = function () {
        $scope.showaction = true;
        $timeout(function () {
            $scope.errorinfo = '';
            $scope.ClientActive = false;
            $scope.IsSignOff = false;
        }, 100);
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');
    };

    $scope.InsertClient = function (currency) {
        if ($scope.ClientActive)
            currency.IsActive = "Y";
        else
            currency.IsActive = "N";

        if ($scope.IsSignOff)
            currency.IsSignOff = "Y";
        else
            currency.IsSignOff = "N";
        if (currency != null) {
            ClientService.InsertClient(currency).success(function (data) {
                if (data == "success") {
                    $scope.showaction = false;
                    toaster.pop('success', "Success", "Client inserted successfully", null);
                    $scope.getclientdata();
                }
                else {
                    $scope.errorinfo = "Error : Mandatory fields are not filled <br />" + data;
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        ClientService.GetDatabyId(id).success(function (data) {
            $scope.pageList = [{ Page: true, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }, { Page: false, IsValid: true }];
            $scope.editMode = true;
            $scope.currency = data[0];
            if (data[0].IsActive == "Y")
                $scope.ClientActive = true;
            else
                $scope.ClientActive = false;

            if (data[0].IsSignOff == "Y")
                $scope.IsSignOff = true;
            else
                $scope.IsSignOff = false;
            $scope.showaction = true;
            $('#currencyModel').modal('show');

        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };
    //$scope.delete = function () {
    //    var crc = { Id: $scope.Id };
    //    ClientService.DeletecurrencyConversion(crc).success(function (data) {
    //        $scope.editMode = false;
    //        $scope.getclientdata();
    //        $('#confirmModal').modal('hide');
    //        toaster.pop('success', "Success", "Client deleted successfully", null);
    //    }).error(function (data) {
    //        $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
    //    });
    //};
    $scope.UpdateClient = function (model) {
        if ($scope.ClientActive)
            model.IsActive = "Y";
        else
            model.IsActive = "N";
        if ($scope.IsSignOff)
            model.IsSignOff = "Y";
        else
            model.IsSignOff = "N";
        if (model != null) {
            ClientService.UpdateClient(model).success(function (data) {
                if (data == "success") {
                    $scope.editMode = false;
                    toaster.pop('success', "Success", "Client updated successfully", null);
                    $scope.showaction = false;
                    $scope.getclientdata();
                }
                else {
                    $scope.errorinfo = "Error : Mandatory fields are not filled <br />" + data;
                }
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }

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
        $scope.showaction = false;
        $('#confirmModal').modal('hide');
    };

    $scope.updatecancel = function (data) {
        ClientService.GetCurrencyConversionbyId(id).success(function (data) {
            $scope.editMode = true;
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

    $scope.getclientdata();
    $scope.GetRightsList = function () {
        angular.forEach($rootScope.RightList, function (value, key) {
            if (value.RightName.contains('Currency Rate Write')) {
                $scope.IsReadOnly = false;
            }
        });
    };
    $scope.GetRightsList();

}]);