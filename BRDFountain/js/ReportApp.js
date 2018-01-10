﻿var BaseURL = '';
var ServionImages = '';
var HostPath = '';
var urltype = '';

var ReportApp = angular.module('reportApp', ['ngFileUpload', 'toaster','datatables']);

ReportApp.controller('MainController', ['$scope', '$rootScope', 'StrategyService', 'UserFactory', 'ApiCall',function ($scope, $rootScope, StrategyService, UserFactory, ApiCall) {
    $scope.rootname = 'Index';

    if (sessionStorage.getItem('menuname') != null) {
        var root = sessionStorage.getItem('menuname');
        $scope.rootname = root;
    }
    else {
        sessionStorage.setItem('menuname', 'Index');
        $scope.rootname = 'Index';
    }

    $scope.notificationdata = [];
    $rootScope.UserInfo = {};
    $scope.MenuList = [];

    $scope.updatemenuclick = function (path) {
        sessionStorage.setItem('menuname', path);
    }
    $scope.GetUserRoles = function () {
        UserFactory.getloggedusername().success(function (data) {
            $rootScope.UserInfo = { userId: data };
            var userId = data;
            if (data != '') {
                UserFactory.GetUserRoles(userId).success(function (data) {
                    console.log(data);
                    $rootScope.RightList = data;
                    $scope.MenuList = [];
                    var distinctArray = [];
                    for (var i = 0; i < data.length; i++) {
                        if (distinctArray.indexOf(data[i].MenuName) < 0 && data[i].ShowMenu == 'true') {
                            distinctArray.push(data[i].MenuName);
                            $scope.MenuList.push({ 'MenuName': data[i].MenuName, 'Path': data[i].Path, 'Icon': data[i].Icon });
                        }
                    }

                }).error(function (error) {
                    console.log('Error when getting rights list: ' + error);
                });
            }

        });
    }
    $scope.GetUserRoles();

    //$scope.GetAllNofitications = function () {
    //    ApiCall.MakeApiCall("GetStrategyApprovalByuser", 'GET', '').success(function (data) {
    //        $scope.notificationdata = data;
    //    }).error(function (error) {
    //        $scope.Error = error;
    //    });
    //};
    //$scope.GetAllNofitications();


    //$scope.GetCurrencyConversionForId = function (id, Version, Comments, ApprovedDate, Status) {
    //    $('#LayoutModel').modal('show');
    //    $scope.notificationExist = true;
    //    $scope.currency = { 'Comments': Comments };
    //    //StrategyService.GetStrategyApprovalByuser().success(function (data) {
    //    //    for (var i = 0; i < data.length; i++) {
    //    //        //if (data[i].RefNumber == id && data[i].Version == Version) {

    //    //        //}
    //    //    }
    //    //}).error(function (error) {
    //    //    $scope.Error = error;
    //    //});
    //};

    //$scope.layoutcancel = function () {
    //    $scope.currency = {};
    //    $('#LayoutModel').modal('hide');
    //};


}]);



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

ReportApp.factory('_', ['$window', function ($window) {
    return $window._; // assumes underscore has already been loaded on the page
}]);



ReportApp.directive('multiselect', function () {
    return {
        restrict: 'E',
        scope: {
            msModel: '=',
            msOptions: '=',
            msConfig: '=',
            msChange: '&'
        },
        replace: true,
        controller: ['$scope',
            function ($scope) {
                /* -------------------------------- *
                 *      Configuration defaults      *
                 * -------------------------------- */
                $scope.config = $scope.msConfig;
                if (typeof ($scope.config) === 'undefined') {
                    $scope.config = {};
                }
                if (typeof ($scope.config.itemTemplate) === 'undefined') {
                    $scope.config.itemTemplate = function (elem) {
                        return elem;
                    };
                }
                if (typeof ($scope.config.labelTemplate) === 'undefined') {
                    $scope.config.labelTemplate = function (elem) {
                        return elem;
                    };
                }
                if (typeof ($scope.config.modelFormat) === 'undefined') {
                    $scope.config.modelFormat = function (elem) {
                        return elem;
                    };
                }
                $scope.$watch('msOptions', function () {
                    _filterOptions();
                });



                /* -------------------------------- *
                 *          Multiselect setup       *
                 * -------------------------------- */
                if ($scope.msModel === null || typeof ($scope.msModel) === 'undefined') {
                    $scope.msModel = [];
                }
                if ($scope.msOptions === null || typeof ($scope.msOptions) === 'undefined') {
                    $scope.msOptions = [];
                }

                $scope.multiselect = {
                    filter: '',
                    filtered: [],
                    options: $scope.msOptions,
                    displayDropdown: true,
                    deleteSelected: function (index) {
                        var oldVal = angular.copy($scope.msModel);

                        if ($scope.msModel[index].name == 'ALL') {

                            for (var i = ($scope.msModel.length - 1) ; i < ($scope.msModel.length) ; i--) {
                                $scope.msModel.splice(i, 1);
                                if ($scope.msModel.length == 0) {
                                    i = $scope.msModel.length + 2;
                                }
                            }
                        }
                        else {
                            $scope.msModel.splice(index, 1);
                        }

                        $scope.msChange({
                            newVal: $scope.msModel,
                            oldVal: oldVal
                        });

                        _filterOptions();
                    },
                    selectElement: function (index) {

                        var oldVal = angular.copy($scope.msModel);

                        if ($scope.multiselect.filtered[index].name == 'ALL') {
                            for (var i = 0; i < $scope.multiselect.filtered.length; i++) {
                                $scope.msModel.push($scope.multiselect.filtered[i]);
                            }

                        }
                        else {
                            $scope.msModel.push($scope.multiselect.filtered[index]);
                        }


                        $scope.msChange({
                            newVal: $scope.msModel,
                            oldVal: oldVal
                        });

                        $scope.multiselect.filter = '';

                        _filterOptions();
                    },
                    focusFilter: function () {
                        $scope.multiselect.currentElement = 0;
                        if ($scope.config.hideOnBlur) {
                            $scope.multiselect.displayDropdown = true;
                        }
                    },
                    blurFilter: function () {
                        $scope.multiselect.currentElement = null;
                        if ($scope.config.hideOnBlur) {
                            $scope.multiselect.displayDropdown = false;
                        }
                    },
                    currentElement: null
                };

                if ($scope.config.hideOnBlur) {
                    $scope.multiselect.displayDropdown = false;
                }

                /* -------------------------------- *
                 *           Helper methods         *
                 * -------------------------------- */

                var _filterOptions = function () {
                    if ($scope.msModel === null) {
                        $scope.multiselect.options = $scope.msOptions;
                        return;
                    }
                    // else if($scope.msModel!=null && $scope.msModel.length>0)
                    // {
                    //    if($scope.msModel[0].name=='ALL')
                    //     {
                    //         $scope.multiselect.options = $scope.msOptions.filter(function(each){
                    //             return $scope.msModel=$scope.multiselect.options;
                    //         });

                    //     }
                    // }

                    $scope.multiselect.options = $scope.msOptions.filter(function (each) {
                        return $scope.msModel.indexOf(each) < 0;
                    });
                };
            }
        ],
        link: function (scope, element, attrs) {
            element.on('keydown', function (e) {
                var code = e.keyCode || e.which;
                switch (code) {
                    case 40: // Down arrow
                        scope.$apply(function () {
                            scope.multiselect.currentElement++;
                            if (scope.multiselect.currentElement >= scope.multiselect.filtered.length) {
                                scope.multiselect.currentElement = 0;
                            }
                        });
                        break;
                    case 38: // Up arrow
                        scope.$apply(function () {
                            scope.multiselect.currentElement--;
                            if (scope.multiselect.currentElement < 0) {
                                scope.multiselect.currentElement = scope.multiselect.filtered.length - 1;
                            }
                        });
                        break;
                    case 13: // Enter
                        scope.$apply(function () {
                            scope.multiselect.selectElement(scope.multiselect.currentElement);
                        });
                        break;
                    default:
                        scope.$apply(function () {
                            scope.multiselect.currentElement = 0;
                        });
                }
            });
        },
        template: function (elem, attrs) {
            var template = $(elem).find('template');
            return '<div class="multiselect" id="multi_popover">' +
                '   <div class="multiselect-labels">' +
                '       <span class="label label-default multiselect-labels-lg" ng-repeat="element in msModel">' +
                '           <span ng-bind-html="config.labelTemplate(element)"></span>' +
                '           <a href="" ng-click="$event.preventDefault(); multiselect.deleteSelected($index)" title="Remove element">' +
                '               <i class="fa fa-times"></i>' +
                '           </a>' +
                '       </span>' +
                '   </div>' +
                //'   <input ng-show="multiselect.options.length > 0" placeholder="' + attrs.placeholder + '" type="text" class="form-control" ng-model="multiselect.filter" ng-focus="multiselect.focusFilter()" ng-blur="multiselect.blurFilter()" />' +
                '   <div ng-show="msModel.length < multiselect.options.length && multiselect.options.length === 0 && !multiselect.options.$resolved"><em>Loading...</em></div>' +
                '   <ul id="agent_dropdown" class="dropdown-menu" role="menu" ng-show="multiselect.displayDropdown && multiselect.options.length > 0">' +
                '       <li ng-repeat="element in multiselect.filtered = (multiselect.options | filter:multiselect.filter) track by $index" role="presentation" ng-class="{active: $index == multiselect.currentElement}">' +
                '           <a href="" role="menuitem" ng-click="$event.preventDefault(); multiselect.selectElement($index)" ng-bind-html="config.itemTemplate(element)"></a>' +
                '       </li>' +
                '   </ul>' +
                '</div>';
        }
    };
});
