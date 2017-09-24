var BaseURL = '';
var ServionImages = '';
var HostPath = '';
var urltype = '';

var ReportApp = angular.module('reportApp', ['ui.grid', 'ngFileUpload', 'ui.grid.pagination']);

ReportApp.controller('MainController', function ($scope, $rootScope, StrategyService, UserFactory) {
    $scope.notificationdata = [];



    $rootScope.UserInfo = {};

    $scope.GetUserRoles = function () {
        UserFactory.getloggedusername().success(function (data) {
            $rootScope.UserInfo = { userId: data };
            var userId = data;
            if (data != '') {
                UserFactory.GetUserRoles(userId).success(function (data) {
                    console.log(data);
                    $rootScope.RightList = data;
                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });


    }
    $scope.GetUserRoles()
    $scope.GetAllNofitications = function () {
        StrategyService.GetStrategyApprovalByuser().success(function (data) {
            $scope.notificationdata = data;
        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAllNofitications();


    $scope.GetCurrencyConversionForId = function (id, Version, Comments, ApprovedDate, Status) {
        $('#LayoutModel').modal('show');
        $scope.notificationExist = true;
        $scope.currency = { 'Comments': Comments };
        //StrategyService.GetStrategyApprovalByuser().success(function (data) {
        //    for (var i = 0; i < data.length; i++) {
        //        //if (data[i].RefNumber == id && data[i].Version == Version) {

        //        //}
        //    }
        //}).error(function (error) {
        //    $scope.Error = error;
        //});
    };

    $scope.layoutcancel = function () {
        $scope.currency = {};
        $('#LayoutModel').modal('hide');
    };


});

ReportApp.directive('datetimepicker', function () {
    return {
        require: '?ngModel',
        restrict: 'A',
        link: function (scope, element, attrs, ngModel) {

            if (!ngModel) return; // do nothing if no ng-model

            var currentdate = '';
            if (scope.opp != undefined && scope.opp.WorkDate != undefined) {
                currentdate = scope.opp.WorkDate;
            }
            else if (scope.user != undefined && scope.user.length == 0) {
                currentdate = '';
            }
            else if (scope.user != undefined && (scope.user.FirstWorkingDate != '' || scope.user.FirstWorkingDate != null)) {
                currentdate = scope.user.FirstWorkingDate;
            }
            else if (scope.user != undefined && (scope.user.LastWorkingDate != '' || scope.user.LastWorkingDate != null)) {
                currentdate = scope.user.LastWorkingDate;
            }
            else if (scope.taskDetails != undefined && scope.taskDetails.length > 0 && (scope.taskDetails.FromDate != undefined || scope.taskDetails.FromDate != '' || scope.taskDetails.FromDate != null)) {
                currentdate = scope.taskDetails.FromDate;
            }
            else if (scope.taskDetails != undefined && scope.taskDetails.length > 0 && (scope.taskDetails.ToDate != undefined || scope.taskDetails.ToDate != '' || scope.taskDetails.ToDate != null)) {
                currentdate = scope.taskDetails.ToDate;
            }
            else {
                currentdate = new Date();
            }

            ngModel.$render = function () {
                $(element).find('input').val(ngModel.$viewValue || '');
            }

            $(element).datetimepicker({
                language: 'en',
                pickTime: false,
                defaultDate: currentdate
            });

            $(element).on('dp.change', function () {
                scope.$apply(read);
            });

            read();

            function read() {
                var value = element.find('input').val();
                ngModel.$setViewValue(value);
            }
        }
    }
});