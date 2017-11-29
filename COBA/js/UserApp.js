ReportApp.controller('UserController', function ($scope, $rootScope, $window, $location, UserFactory, reportFactory, $timeout, ApiCall, RoleFactory, toaster, $compile, DTOptionsBuilder, DTColumnBuilder) {
    $scope.data = [];
    $scope.dtOptions = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
    .withOption('rowCallback', rowCallback1);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('userId').withTitle('UserId'),
        DTColumnBuilder.newColumn('UserName').withTitle('User Name'),
        DTColumnBuilder.newColumn('EmailId').withTitle('EmailId'),

        DTColumnBuilder.newColumn('checked').withTitle('Actions').notSortable()
            .renderWith(actionsHtml)
    ];

    $scope.dtOptions1 = DTOptionsBuilder.fromSource()
        .withPaginationType('full_numbers').withOption('createdRow', createdRow)
    .withOption('rowCallback', rowCallback);

    $scope.dtColumns1 = [
       DTColumnBuilder.newColumn('userId').withTitle('UserId'),
       DTColumnBuilder.newColumn('UserName').withTitle('User Name'),
       DTColumnBuilder.newColumn('EmailId').withTitle('EmailId'),
          DTColumnBuilder.newColumn('RoleName').withTitle('RoleName'),
        DTColumnBuilder.newColumn('RegionName').withTitle('RegionName'),
        DTColumnBuilder.newColumn('CountryName').withTitle('CountryName'),
        DTColumnBuilder.newColumn('BusinessSector').withTitle('BusinessSector'),
       DTColumnBuilder.newColumn('userId').withTitle('Actions').notSortable()
           .renderWith(actionsHtml1)
    ];


    function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
    }
    function actionsHtml1(data, type, full, meta) {
        $scope.data = data;
        return '<a  class="test" ><img src="../images/edit.png"></a>' +
            '&nbsp;<a  class="view"><img style="width:24px;height:24px;" src="../images/eyeicon.png"></a>';
    }

    function actionsHtml(data, type, full, meta) {
        $scope.data = data;
        if (data)
            return '<input type="checkbox" class="checkclick"  checked />';
        else
            return '<input type="checkbox" class="checkclick" />';
    }
    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.test', nRow).unbind('click');
        $('.test', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.EditUser(aData.userId);
            });
        });

        $('.view', nRow).unbind('click');
        $('.view', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.GetUser(aData.userId);
            });
        });
        //$('.checkclick', nRow).unbind('click');
        //$('.checkclick', nRow).bind('click', function () {
        //    $scope.$apply(function () {
        //        $scope.chkChanged(aData);
        //    });
        //});
        return nRow;
    }
    function rowCallback1(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('.checkclick', nRow).unbind('click');
        $('.checkclick', nRow).bind('click', function () {
            $scope.$apply(function () {
                $scope.chkChanged(aData);
            });
        });
        return nRow;
    }

    $scope.UpdatedUserTypes = [];
    $scope.selectedSBU = {};
    $scope.selectedRole = {};
    $scope.selectedStatus = {};
    $scope.InvalidMessage = '';
    $scope.Error = {};
    $scope.user = {};
    $scope.User = {};
    $scope.EditedUser = {};
    $scope.Users = [];
    $scope.UsersView = [];
    $scope.ADUsers = [];
    $scope.Roles = [];
    $scope.IsReadOnly = false;

    $scope.IsUserSCHead = function () {
        UserFactory.GetUser($rootScope.UserInfo.user.userId).success(function (data) {
            if (data.TypeId == '8') {
                $scope.IsSCUser = true;
            }
        }).error(function (err) {
            $scope.IsSCUser = false;
        });
    };

    $scope.IsPageReadOnly = function () {
        UserFactory.getloggedusername().success(function (data) {
            var userId = data;
            if (data != '') {
                reportFactory.GetRightsList(userId).success(function (data) {
                    var isRead = true;
                    $scope.IsReadOnly = true;
                    angular.forEach(data, function (value, key) {
                        if (value.RightName == 'User Management Write') {
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

    }

    $scope.stateChanged = function (selectedType) {
        if (selectedType.Id != undefined) {
            if (selectedType.Id == 2) {
                $scope.BillingSBU = $scope.OnlySBU;
                return;
            }
            else {
                $scope.BillingSBU = $scope.AllSBU;
                return;
            }
        }
        else if (selectedType.TypeID == 13 || selectedType.TypeID == 14 || selectedType.TypeID == 1 || selectedType.TypeID == 2 || selectedType.TypeID == 5 || selectedType.TypeID == 3 || selectedType.TypeID == 4) {
            $scope.SBU = $scope.OnlySBU;
        }
        else {
            $scope.SBU = $scope.AllSBU;
        }
    },

    $scope.ConvertToUserTypes = function (data) {
        $scope.UserTypes = [];
        angular.forEach(data, function (value, key) {
            $scope.UserTypes.push({ 'userId': value.userId, 'UserName': value.UserName, 'EmailId': value.EmailId, 'checked': false });
        });

        $scope.dtOptions.data = $scope.UserTypes;
    };

    $scope.GetAllRoles = function () {
        RoleFactory.GetRoles().success(function (data) {
            $scope.Roles = data;
        }).error(function (error) {
            $scope.Error = error;
        });

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

        ApiCall.MakeApiCall("GetAllRegion?RegionId=", 'GET', '').success(function (data) {
            console.log(data);
            $scope.RegionMasterList = data;
        }).error(function (error) {
            $scope.Error = error;
        })

    };

    $scope.GetADUsers = function () {
        UserFactory.GetADUsers().success(function (data) {
            $scope.ADUsers = data;

            $scope.ConvertToUserTypes(data);

        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetAllUsers = function () {
        $scope.UsersView = [];
        UserFactory.GetUsers().success(function (data) {
            $scope.Users = data;
            angular.forEach($scope.Users, function (value, key) {
                $scope.UsersView.push({
                    'userId': value.userId, 'UserName': value.UserName, 'EmailId': value.EmailId, 'RoleName': value.RoleName,
                    'RegionName': value.RegionName,
                    'CountryName': value.CountryName,
                    'BusinessSector': value.BusinessSector,
                    'Status': value.Status
                })
            })

            $scope.dtOptions1.data = $scope.UsersView;

        }).error(function (error) {
            $scope.Error = error;
        });
    };
    $scope.GetUser = function (userId) {
        UserFactory.GetUser(userId).success(function (data) {
            $scope.User = data[0];
            $('#viewModal').modal('show');
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    $scope.CreateTempUser = function (user) {
        $scope.InvalidMessage = '';

        UserFactory.GetUser(user.userId).success(function (data) {
            if (data.length > 0) {
                $scope.userId = '';
                $scope.InvalidMessage = 'The UserID already exists!'
            }
            else {
                UserFactory.CreateTempUser(user).success(function (data) {
                    $scope.GetAllUsers();
                    $('#userCreateModel').modal('hide');
                }).error(function (err) {
                    $scope.Error = err;
                });
            }
        }).error(function (err) {
            $scope.Error = err;
        });
    };
    $scope.EditUser = function (userId) {
        $scope.EditedUser = {};
        UserFactory.GetUser(userId).success(function (data) {
            $scope.user = data[0];
            $scope.editMode = true;
            $('#editModel').modal('show');
        }).error(function (error) {
            $scope.Error = error;
        })
    };

    $scope.showtempadd = function () {
        // angular.element(document.querySelector('#loader')).removeClass('hide');
        $scope.InvalidMessage = '';
        $scope.user = {};
        $('#userCreateModel').modal('show');
    };

    //Modal popup events
    $scope.showadd = function () {
        angular.element(document.querySelector('#loader')).removeClass('hide');
        $scope.UpdatedUserTypes = [];
        $scope.user.showSelected = false;
        $scope.user.selectedType = {};
        $scope.user.selectedCountry = {};
        $scope.user.selectedRegion = {};
        $scope.user.selectedRole = {};
        $scope.user.selectedStatus = {};
        $scope.user.selectedBusinessSector = {};
        $scope.user = {};
        $scope.GetADUsers();
        $scope.editMode = false;
        // this.adduserform.$setPristine(); //for form reset       
        $('#userModel').modal('show');
        $timeout(function () {
            angular.element(document.querySelector('#loader')).addClass('hide');
        }, 2500);
        window.setTimeout(function () {
            $(window).resize();
            $(window).resize();
        }, 1000);

    };

    //Model popup events
    $scope.showconfirm = function (data) {
        $scope.user = data;
        $('#confirmModal').modal('show');
    };

    // add User
    $scope.add = function (v) {
        var currentUser = v;
        if (currentUser != null && currentUser.UserName != null) {
            currentUser.userId = currentUser.UserName;
            currentUser.userName = currentUser.UserName;
            currentUser.password = currentUser.UserName;
            currentUser.emailId = currentUser.EmailId;
            currentUser.mobileNumber = currentUser.MobileNumber;
            $scope.user = currentUser;
            UserFactory.AddUser(currentUser).success(function (data) {
                $scope.addMode = false;
                //currentUser.UserId = data;
                //$scope.users.push(currentUser);
                $scope.GetAllUsers();
                $scope.user = {};
                // $scope.adduserform.$setPristine(); //for form reset
                $('#userModel').modal('hide');
            }).error(function (data) {
                $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
            });
        }
    };

    $scope.cancel = function () {
        $scope.user = {};
        $('#userModel').modal('hide');
    }

    $scope.chkChanged = function (event) {
        var isAddedAlready = false;

        if (event.checked == false) {

            angular.forEach($scope.UpdatedUserTypes, function (value, key) {
                if (event.userId == value.userId) {
                    isAddedAlready = true;
                }
            });
            if (!isAddedAlready)
                $scope.UpdatedUserTypes.push({ 'userId': event.userId, 'UserName': event.UserName, 'EmailId': event.EmailId, 'checked': true });
        }
        else {
            for (var i = $scope.UpdatedUserTypes.length - 1; i >= 0; i--) {
                if ($scope.UpdatedUserTypes[i].userId == event.userId) {
                    $scope.UpdatedUserTypes.splice(i, 1);
                }
            }
        }
        event.checked = !event.checked;
    }

    //Display only selected users
    $scope.showSelectedUsers = function (isChecked) {
        if (isChecked) {
            console.log('setting row data');
            $scope.dtOptions.data = $scope.UpdatedUserTypes;
        }
        else {
            $scope.dtOptions.data = $scope.UserTypes;
        }
    }

    // Add Users
    $scope.getSelected = function (selectedRole, selectedregion, selectedcoutry, selectedBS) {
        try {
            var ar = $scope.UpdatedUserTypes;
            $scope.UpdatedUserTypes = [];
            console.log('Total selected: ' + ar.length);
            if (ar.length == 0) {
                toaster.pop('warning', "Warning", "There are no users selected", null);
            }
            else {
                var successcount = 0;
                for (var i = 0; i < ar.length; i++) {
                    if (ar[i] != null && ar[i].UserName != null && ar[i].EmailId) {
                        console.log('Valid user: ' + ar[i].UserName);
                        $scope.user = ar[i];
                        $scope.user.RoleId = selectedRole.id;
                        $scope.user.BusinessSectorId = selectedBS.Id;
                        $scope.user.CountryId = selectedcoutry.Id;
                        $scope.user.RegionId = selectedregion.Id;

                        UserFactory.AddUser($scope.user).success(function (data) {
                            $scope.addMode = false;
                            $scope.GetADUsers();
                            $scope.user = {};
                            toaster.pop('success', "Success", "User added successfully", null);
                            var n = parseInt(ar.length);
                            n = n - 1;
                            if (successcount == n) {
                                $scope.GetAllUsers();
                            }
                            successcount++;
                            $('#userModel').modal('hide');

                        }).error(function (data) {
                            $scope.error = "An Error has occured while Adding user! " + data.ExceptionMessage;
                        });
                    }
                    else {
                        //alert('Please select both the Role and SBU');
                        toaster.pop('warning', "Warning", "Please select both the Role and SBU", null);
                    }
                }
            }
        }
        catch (ex) {
            console.log("Error occurred: " + ex);
        }
    };

    $scope.ModifyUser = function (data) {
        //data.userId = data.UserName;
        //data.userName = data.UserName;
        //data.password = data.UserName;
        //data.emailId = data.EmailId;
        //data.mobileNumber = data.MobileNumber;
        //data.SBU = data.selectedSBU;
        //data.BillingSBU = data.selectedBillingSBU

        //if (data.userId == $rootScope.UserInfo.user.userId) {
        //    $scope.EditedUser = data;
        //    $('#roleChange').modal('show');
        //}
        //else {
        UserFactory.ModifyUser(data).success(function (data) {
            $scope.GetAllUsers();
            //reset form
            $scope.user = {};
            toaster.pop('success', "Success", "Modified User successfully", null);
            $('#editModel').modal('hide');

        }).error(function (error) {
        });
        //}
    };

    $scope.ModifySelfUser = function () {
        $('#roleChange').modal('hide');

        $scope.EditedUser.userName = $scope.EditedUser.UserName;
        // data.password = $scope.EditedUser.UserName;
        $scope.EditedUser.emailId = $scope.EditedUser.EmailId;
        $scope.EditedUser.mobileNumber = $scope.EditedUser.MobileNumber;

        UserFactory.ModifyUser($scope.EditedUser).success(function (data) {
            $scope.GetAllUsers();
            //reset form
            $scope.user = {};
            $scope.EditedUser = {};
            $('#editModel').modal('hide');
            reportFactory.Logout($rootScope.UserInfo.user.userId).success(function (data) {
                $window.sessionStorage['userAuth'] = null;
                $rootScope.UserInfo = null;
                $rootScope.isAuth = false;
                $location.path('/');
                console.log('Logged out successfully');
            }).error(function (error) {
                console.log('Failed to log out properly. Error: ' + error);
            })

        }).error(function (error) {
        });
    };

    $scope.delete = function () {
        var currentUser = $scope.user;
        currentUser.userId = currentUser.userId;
        UserFactory.DeleteUser(currentUser).success(function () {

            $scope.GetAllUsers();
            //reset form
            $scope.user = {};
            // $scope.adduserform.$setPristine(); //for form reset
            toaster.pop('success', "Success", "User deleted successfully", null);
            $('#confirmModal').modal('hide');


        }).error(function (error) {

        });
    };
    $scope.ChangePassword = function () {
        UserFactory.ChangePassword($scope.User).success(function (data) {

        }).error(function (error) {

        });
    };


    $scope.GetAllRoles();
    $scope.GetAllUsers();
    //$scope.IsUserSCHead();
    $scope.IsPageReadOnly();
});

ReportApp.factory('UserFactory', function ($http) {
    var UserFactory = {
        GetUsers: function () {
            return $http.get('getusers?userid=');
        },

        GetADUsers: function () {
            return $http.get('getADuser');
        },

        GetUser: function (userid) {
            return $http.get('getusers?userid=' + userid);
        },

        AddUser: function (user) {
            return $http.post('CreateUser', user);
        },
        CreateTempUser: function (user) {
            return $http.post('CreateTempUser', user);
        },
        ModifyUser: function (user) {
            return $http.post('ModifyUser', user);
        },
        DeleteUser: function (user) {
            return $http.post('DeleteUser', user);
        },

        getloggedusername: function () {
            return $http.get('getloggedusername');
        },
        GetUserRoles: function (userId) {
            return $http.get('GetUserRoles/?UserId=' + userId);
        },

        GetInactiveUsers: function () {
            return $http.get(Userurl + '/GetInactiveUsers');
        },


    };
    return UserFactory;
});
