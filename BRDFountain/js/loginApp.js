var LoginApp = angular.module('LoginApp', []);

LoginApp.controller('LoginController', function ($location, $scope) {
    $scope.errorMessage = '';
    jQuery(function ($) {
        //Generic Ajax handler
        $('form[data-async]').on('submit', function (event) {
            var $form = $(this);
            var $target = $($form.attr('data-target'));
            var $id = "#" + $form.attr('id');
            var disabled = $form.find(':input:disabled').removeAttr('disabled');
            $('.validation').html("<img width='50' height='50' src='../../Content/images/ajax-loader2.gif' />");
            $.ajax({
                type: $form.attr('method'),
                url: $form.attr('action'),
                data: $form.serialize(),
                success: function (data, status) {
                    $('.validation').html(data);
                    if (data === "Logged in successfully") {
                        reloadPage("#RedirectToHome");
                    }
                    else {
                        $scope.$apply(function () {
                            $scope.errorMessage = data;
                        });
                        //$toaster.pop('error', "Error", data, null);
                    }
                }
            });
            disabled.attr('disabled', 'disabled');
            event.preventDefault();
        });



        //Redirect helper
        function reloadPage(redirectTo) {
            var url = $(redirectTo).val();
            location.href = url;
        }
    });

    //$scope.login = function () {
    //    $location.path("/Home/Index");
    //    if(Login()=="Logged in successfully")
    //    {

    //    }
    //}
    //function Login() {
    //    return $http.get('Login?userName=' + $scope.username + '&passWord=' + $scope.password + '&auth_type&=');
    //}
});
//var loginApp = angular.module('loginApp', ['ngRoute', 'oauth', 'ngRoute']);
//loginApp.run(['$rootScope', '$window', '$http', function ($rootScope, $window, $http) {
//  $rootScope.UserInfo = angular.fromJson($window.sessionStorage.getItem('userAuth'));
//  if ($rootScope.UserInfo) {
//    $rootScope.isAuth = true;
//    $http.defaults.headers.common['x-access-token'] = $rootScope.UserInfo.token;
//  }
//}]);


//loginApp.config(['$routeProvider', '$locationProvider', '$httpProvider',
//  function ($routeProvider, $locationProvider, $httpProvider) {
//    if (!$httpProvider.defaults.headers.get) {
//      $httpProvider.defaults.headers.get = {};
//    }
//    $httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
//    $httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
//    $httpProvider.defaults.headers.get['Pragma'] = 'no-cache';

//    $routeProvider
//      .when('/', {
//        controller: 'validateController', templateUrl: 'js/views/Login/Oauth.html'
//      })
//      // .when('/validate:code', {
//      //   controller: 'validateController', templateUrl: 'js/views/Login/validation.html'
//      // })
//      .otherwise({ redirectTo: '/' });

//    $locationProvider.html5Mode(true).hashPrefix('*');
//  }]);

//loginApp.controller('AuthController', function ($scope, $routeParams, $timeout, AccessToken, Endpoint, Storage, $location, $rootScope, $window) {
//  $scope.userId = '';
//  $scope.password = '';
//  $scope.errMsg = '';
//  $scope.loading = false;
//  $scope.imagesPath = ServionImages;
//  $rootScope.Endpoint = Endpoint;
//  var UserInfo = window.sessionStorage.getItem('userAuth');

//  if (UserInfo != undefined || UserInfo != null) {
//    $scope.imagesPath = ServionImages;
//    $scope.loading = true;
//  }

//  var split = $location.absUrl();
//  var content = split.split('?');
//  if (content.length > 1) {
//    $rootScope.code = content[1].split('=')[1];

//  }

//}).run(['$rootScope', '$location', '$window', '$http', '$templateCache', '$routeParams', function ($rootScope, $location, $window, $http, $templateCache, $routeParams) {
//  $rootScope.$on('$routeChangeStart', function (event, next, current) {
//    if (typeof (current) !== 'undefined') {
//      $templateCache.remove(current.templateUrl);
//    }
//  });


//}]);