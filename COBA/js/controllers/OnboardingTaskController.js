ReportApp.controller('OnboardingTaskController', function ($scope, $rootScope, OnboardingTaskService, $timeout, Upload, $window, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.downloadurl = 'http://localhost/Appserver/inbox/';
    $scope.FileList = [];
    $scope.ManualFileList = [];
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

    $scope.getallcurrencyconversions = function () {

        OnboardingTaskService.GetAllTask().success(function (data) {
            console.log(data)
            $scope.CurrencyGrid.data = data;
        })
    };

    $rootScope.$on("toggle", function () {
        $timeout(function () {
            $scope.CurrencyGrid.api.sizeColumnsToFit();
        }, 1000);
    });

    //var columnDefs = [{ name: 'Id' },
    //{ name: 'ClientNumber' },
    //{ name: 'TaskName' },
    //{ name: 'EmailSubject' },
    ////{ headerName: 'EmailId', name: 'EmailId', width: 320 },
    ////{ headerName: 'IsActive', name: 'IsActive', width: 320 },
    ////{ headerName: 'IsMappedToTask', name: 'IsMappedToTask', width: 320 },
    //,

    ////{ headerName: 'CreatedDate', name: 'CreatedDate', width: 320 },
    //{ headerName: 'EmailAttachment', name: 'EmailAttachment' },
    ////{ headerName: 'CreatedBy', name: 'CreatedBy', width: 320 },
    //{ headerName: 'EmailContent', name: 'EmailContent' },
    ////{ headerName: 'LastModifiedBy', name: 'LastModifiedBy', width: 320, hide: true },
    // //   { headerName: 'LastModifiedDate', name: 'LastModifiedDate', width: 320, hide: true },
    // //   { headerName: 'TaskAssignedBy', name: 'TaskAssignedBy', width: 320, hide: true },
    //  //  { headerName: 'TaskAssignedDate', name: 'TaskAssignedDate', width: 320, hide: true },
    //    { headerName: 'TaskAttachement', name: 'TaskAttachement' },
    //    { headerName: 'TaskComments', name: 'TaskComments' },
    //   // { headerName: 'UniqueEmailId', name: 'UniqueEmailId', width: 320, hide: true },
    //    //{ headerName: 'Description', name: 'Description', width: 440 },
    //    //{ headerName: 'SignOff Status', name: 'IsSignOff', width: 140 },
    //     {
    //         name: 'IsProcessed',
    //         cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-show={{row.entity.IsProcessed=="N"}}><i class="fa fa-close" ></i></a ><a ng-show={{row.entity.IsProcessed=="Y"}}><i class="fa fa-check" ></i></a> </div>'
    //     },
    //     {
    //         field: 'Action'
    //        , cellTemplate: '<div class="ui-grid-cell-contents"> <a ng-click=\"grid.appScope.GetCurrencyConversionForId(row.entity.Id)" ><i class="fa fa-edit" ></i></a ></div>'

    //     }];


    //$scope.CurrencyGrid = {
    //    paginationPageSizes: [10, 20, 30, 40, 50, 60],
    //    paginationPageSize: 10,
    //    columnDefs: columnDefs,
    //};


    $scope.dtOptions = DTOptionsBuilder.fromSource()
   .withPaginationType('full_numbers').withOption('createdRow', createdRow);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('Id').withTitle('ID').notVisible(),
       DTColumnBuilder.newColumn('ClientNumber').withTitle('ClientNumber'),
    DTColumnBuilder.newColumn('TaskName').withTitle('TaskName'),
    DTColumnBuilder.newColumn('EmailSubject').withTitle('EmailSubject'),
        DTColumnBuilder.newColumn('Name').withTitle('Name'),
         DTColumnBuilder.newColumn('TaskAttachement').withTitle('TaskAttachement'),
        DTColumnBuilder.newColumn('TaskComments').withTitle('TaskComments'),
        DTColumnBuilder.newColumn('Id').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];
    function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        return '<a  ng-click="GetVenuetypeMasterById(' + data + ')"><img src="images/edit.png"></a> ';
        //+'<button class="btn btn-danger" ng-click="delete(' + data + ')" )"="">' +
        //'   <i class="fa fa-trash-o"></i>' +
        //'</button>';
    }


    $scope.getallcurrencyconversions();

    $scope.showadd = function () {
        $timeout(function () {
            $scope.OnboardingActive = false;
        }, 100);
        $scope.errorinfo = '';
        $scope.editMode = false;
        $scope.currency = {};
        $scope.ecurrency.CurrencyDescrition = '';
        $('#currencyModel').modal('show');

    };

    $scope.GetAllCurrency = function () {
        OnboardingTaskService.GetAllTask().success(function (data) {
            $scope.dtOptions.data = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };


    $scope.add = function (currency) {
        if (currency != null) {
            currency.IsActive = "Y";
            currency.IsSignOff = "Y";
            currency.IsSignOff = (currency.IsSignOff == "checked" ? "Y" : 'N');
            OnboardingTaskService.AddTask(currency).success(function (data) {
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding currency! " + data.ExceptionMessage;
            });
        }
    };

    $scope.GetCurrencyConversionForId = function (id) {
        $scope.FileList = [];
        $scope.ManualFileList = [];

        OnboardingTaskService.GetAllTaskById(id).success(function (data) {
            $scope.editMode = true;
            $scope.downloadurl += data[0].ClientNumber + "\\";
            if (data[0].EmailAttachment != null && data[0].EmailAttachment != undefined && data[0].EmailAttachment.length > 0) {
                var splitdata = data[0].EmailAttachment.split(',');

                for (var i = 0; i < splitdata.length; i++) {
                    if (splitdata.length > 0) {
                        var filename = splitdata[i].split('.');
                        $scope.FileList.push({ FileName: splitdata[i], FilePath: $scope.downloadurl + "\\" + splitdata[i], extension: filename[filename.length - 1] });
                    }
                }
            }
            if (data[0].TaskAttachement != null && data[0].TaskAttachement != undefined && data[0].TaskAttachement.length > 0) {
                var TaskAttachmentdata = data[0].TaskAttachement.split(',');
                for (var i = 0; i < TaskAttachmentdata.length; i++) {
                    if (TaskAttachmentdata.length > 0) {
                        var filename = TaskAttachmentdata[i].split('.');
                        $scope.ManualFileList.push({ FileName: TaskAttachmentdata[i], FilePath: $scope.downloadurl + "\\" + TaskAttachmentdata[i], extension: filename[filename.length - 1] });
                    }
                }
            }


            data[0].IsSignOff = (data[0].IsSignOff == "Y" ? "checked" : 'unchecked');
            $scope.ecurrency = data[0];
            $('#currencyModel').modal('show');
        }).error(function (data) {
            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
        });
    };



    $scope.UpdatecurrencyConversion = function (model) {
        //model.UpdatedBy = $rootScope.UserInfo.user.userId;

        OnboardingTaskService.UpdatecurrencyConversion(model).success(function (data) {
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
        OnboardingTaskService.GetCurrencyConversionbyId(id).success(function (data) {
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

});