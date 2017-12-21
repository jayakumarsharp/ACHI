var hasreload = true;
var userid;
var editedname;


jQuery(function ($) {

    $.getUrl = function (path) {

        return '@Url.Content("~")' + path;

    };

    $('form[data-async]').on('submit', function (event) {
        var $form = $(this);
        var $target = $($form.attr('data-target'));
        var $id = "#" + $form.attr('id');
        var disabled = $form.find(':input:disabled').removeAttr('disabled');
        //$('.validation').html("<img width='50' height='50' src='../TTSLAdmin/Content/images/ajax-loader2.gif' />");
        // alert($form.serialize());
        $('.validation').html("<img width='50' height='50' src='../Content/images/ajax-loader2.gif' />");
        $.ajax({
            type: $form.attr('method'),
            url: $form.attr('action'),
            data: $form.serialize(),

            success: function (data, status) {

                $('.validation').html(data);

                if (data == "Logged in successfully") {

                    $.ajax({
                        url: hostpath + '/Home/GetUserid',
                        type: "POST",
                        async: false,
                        success: function (data) {
                            userid = data;
                        }
                    });

                    reloadCAlVolume("#RedirectToHome");
                }
                else if (data == "User created successfully") {
                    $('#create-modal').modal('hide');
                }
                else if (data == "User edited successfully") {
                    $('#edit-modal').modal('hide');
                }
                else if (data == "Role created successfully") {
                    $('#create-r-modal').modal('hide');
                }
                else if (data == "Role Updated successfully") {
                    $('#edit-role-modal').modal('hide');
                }

                else if (data == "Please enter the Username" | data == "Please enter the Password" | data == "You account has been blocked. Please contact the Admin" | data == "Login failed please check the credentials you entered") {
                    //if (document.getElementById("logincancelbtn") != null) {
                    //    document.getElementById("logincancelbtn").disabled = false;
                    document.getElementById("input-username").readOnly = false;
                    document.getElementById("input-password").readOnly = false;
                    // }
                }

            }
        });
        disabled.attr('disabled', 'disabled');
        event.preventDefault();
    });

    $(".delete").on("click", function () {
        //$('#myModal').modal('show');
        var self = $(this);
        //var result = confirm("Are you sure delete User " + self.data("username") + "?");
        result = confirm("Are you sure want to delete ?");
        if (result == true) {
            //Logic to delete the item
            $.ajax({
                url: "DeleteUser/?Id=" + self.data("id"),
                type: "POST",
                success: function (data) {
                    if (data == "SUCCESS")
                        self.closest('tr').fadeOut();
                    else
                        alert(data);
                    //console.log(self);
                }
            });
        }

    });

    $('#create-modal').on('hidden', function () {

    });

    $("#editUser_validator").bind("change", function () {
        if ($('#editUser_validator').val() == "Successfunction") {

        }
    });

    //Reset controls
    $(".reset").click(function () {
        $(this).closest('form').find("input[type=text], textarea, select").val("");
    });

    //Clear validation text when bootstrap modal pops up 
    $('#edit-modal, #create-modal, #login-modal, #pwd-modal').on('shown.bs.modal', function () {
        $(".user-message, .validation").html("");
        //$(".form-control").val("");
    });

    //Redirect on modal close
    $('#edit-modal, #create-modal').on('hidden.bs.modal', function () {
        reloadPage("#RedirectToUserManagement");
    });


    $('#loginSubmitbtn').click(function (event) {
        document.getElementById("input-username").readOnly = true;
        document.getElementById("input-password").readOnly = true;
        //   document.getElementById("logincancelbtn").disabled = true;

    });

    $('#loginLinkClick').click(function (event) {
        document.getElementById("input-username").readOnly = false;
        document.getElementById("input-password").readOnly = false;
        document.getElementById("input-username").value = "";
        document.getElementById("input-password").value = "";
    });

    $('#editUser_cancel').click(function (event) {
        var Id = $('#hdnuId').val()
        $.ajax({
            type: 'get',
            dataType: "json",
            async: true,
            url: 'GetUserbyId/?Id=' + Id,
            success: function (data) {
                if (data[0].Status == 0) {
                    document.getElementById("e_chkstatus").checked = true;
                }
                else { document.getElementById("e_chkstatus").checked = false; }
                $('#e_Empcode').val(data[0].EmpCode)
                $('#e_EmpName').val(data[0].EmpName)
                $('#e_password').val(data[0].Password)
                $("#e_manager").val(data[0].ManagerId)
                $("#e_hod").val(data[0].HODID)
                $("#e_usertype option:selected").text(data[0].UserType)

                $("#e_email").val(data[0].Email)
                $("#e_contact").val(data[0].ContactNo)
                $("#e_role").val(data[0].RoleId)
                $("#e_team").val(data[0].TeamId)

            }

        });

    });

    $('#createUser_cancel').click(function (event) {
        $('#createUser_validator').html('')

        $('#Empcode').val('')
        $('#EmpName').val('')
        $('#password').val('')
        $("#manager").val('')
        $("#hod").val('')
        $("#usertype").val("-1")
        $("#email").val('')
        $("#contact").val('')
        $("#role").val('')
        $("#team").val('')
        document.getElementById("e_chkstatus").checked = true;
    });


    //   Edit Code
    $('#edit_user_submit').click(function () {
        if (validateedituser()) {
            var boolstatus = $('#e_chkstatus').is(":checked");
            var status;

            if (boolstatus == true) {
                status = 0;
            }
            else { status = 1; }

            var userinfo =
                {
                    Id: $('#hdnuId').val(),
                    EmpCode: $('#e_Empcode').val(),
                    EmpName: $('#e_EmpName').val(),
                    Password: $('#e_password').val(),
                    ManagerId: $("#e_manager").val(),
                    HODID: $("#e_hod").val(),
                    UserType: $("#e_usertype option:selected").text(),
                    Email: $("#e_email").val(),
                    ContactNo: $("#e_contact").val(),
                    RoleId: $("#e_role").val(),
                    TeamId: $("#e_team").val(),
                    Status: status
                }
            $.ajax({
                url: 'EditUser',
                type: 'POST',
                data: userinfo,
                success: function (data) {
                    if (data == "SUCCESS") {
                        reloadPage("#RedirectToUserManagement");
                    }
                    else {
                        alert(data);
                    }
                }
            });
        }


    });
    //Editcode

    //Create code


    $('#chkstatus').prop('checked', true);

    $("#btnuseradd").click(function () {
        if (checkadduser()) {
            var boolstatus = $('#chkstatus').is(":checked");
            var status;

            if (boolstatus == true) {
                status = 0;
            }
            else { status = 1; }
            var userinfo =
                {
                    EmpCode: $('#Empcode').val(),
                    EmpName: $('#EmpName').val(),
                    Password: $('#password').val(),
                    ManagerId: $("#manager").val(),
                    HODID: $("#hod").val(),
                    UserType: $("#usertype  option:selected").text(),
                    Email: $("#email").val(),
                    ContactNo: $("#contact").val(),
                    RoleId: $("#role").val(),
                    TeamId: $("#team").val(),
                    Status: status
                }

            $.ajax({
                url: 'CreateUser',
                type: 'POST',
                data: userinfo,
                success: function (data) {
                    if (data == "SUCCESS") {
                        reloadPage("#RedirectToUserManagement");
                    }
                    else {
                        alert(data)
                    }
                },
                error: function (data) {
                    alert(data)
                    console.log(data);
                }
            });
        }
    });


    $(".useredit").click(function () {
        var self = $(this);
        var Id = self.data("id")
        $('#hdnuId').val(Id)
        $.ajax({
            type: 'get',
            dataType: "json",
            async: true,
            url: 'GetUserbyId/?Id=' + Id,
            success: function (data) {
                if (data[0].Status == 0) {
                    document.getElementById("e_chkstatus").checked = true;
                }
                else { document.getElementById("e_chkstatus").checked = false; }
                $('#e_Empcode').val(data[0].EmpCode)
                $('#e_EmpName').val(data[0].EmpName)
                $('#e_password').val(data[0].Password)
                $("#e_manager").val(data[0].ManagerId)
                $("#e_hod").val(data[0].HODID)
                $("#e_usertype option:selected").text(data[0].UserType)

                $("#e_email").val(data[0].Email)
                $("#e_contact").val(data[0].ContactNo)
                $("#e_role").val(data[0].RoleId)
                $("#e_team").val(data[0].TeamId)

            }

        });

    });


    $.ajax({
        type: 'get',
        dataType: "json",
        async: true,
        url: 'GetManagers',
        success: function (data) {
            $('#manager').empty()
            $('#e_manager').empty()
            $('#manager').append("<option value='-1'>--Select--</option>");
            $.each(data, function (key, val) {
                $('#manager').append("<option value=" + val.UserId + ">" + val.ManagerName + "</option>");
                $('#e_manager').append("<option value=" + val.UserId + ">" + val.ManagerName + "</option>");
            });
        }
    });


    $.ajax({
        type: 'get',
        dataType: "json",
        async: true,
        url: 'GetHOD',
        success: function (data) {
            $('#hod').empty()
            $('#e_hod').empty()
            $('#hod').append("<option value='-1'>--Select--</option>");
            $.each(data, function (key, val) {
                $('#hod').append("<option value=" + val.UserId + ">" + val.HodName + "</option>");
                $('#e_hod').append("<option value=" + val.UserId + ">" + val.HodName + "</option>");
            });
        }
    });


    $.ajax({
        type: 'get',
        dataType: "json",
        async: true,
        url: 'GetRoles',
        success: function (data) {
            $('#role').empty()
            $('#role').append("<option value='-1'>--Select--</option>");
            $.each(data, function (key, val) {
                $('#role').append("<option value=" + val.RoleId + ">" + val.RoleName + "</option>");
                $('#e_role').append("<option value=" + val.RoleId + ">" + val.RoleName + "</option>");
            });
        }
    });


    $.ajax({
        type: 'get',
        dataType: "json",
        async: true,
        url: 'GetTeams',
        success: function (data) {
            $('#team').empty()
            $('#e_team').empty()

            $('#team').append("<option value='-1'>--Select--</option>");
            $.each(data, function (key, val) {
                $('#team').append("<option value=" + val.UserId + ">" + val.TeamName + "</option>");
                $('#e_team').append("<option value=" + val.UserId + ">" + val.TeamName + "</option>");
            });
        }
    });


    $.ajax({
        type: 'get',
        dataType: "json",
        async: true,
        url: 'GetUserType',
        success: function (data) {
            $('#usertype').empty()
            $('#e_usertype').empty()
            $('#usertype').append("<option value='-1'>--Select--</option>");
            $.each(data, function (key, val) {
                $('#usertype').append("<option value=" + val.Id + ">" + val.Usertype + "</option>");
                $('#e_usertype').append("<option value=" + val.Id + ">" + val.Usertype + "</option>");
            });
        }
    });

    //Create code
    //Hierachy user

    $(".userhieredit").click(function () {
        var self = $(this);
        var Id = self.data("ecode")
        var name = self.data("ehname")
        $('#dyna1').html('')
        $('#dyna2').html('')

        $('#h_Empcode').val(Id)
        var cnt = 0;
        $('#h_Empname').val(name)

        $.ajax({
            type: 'get',
            dataType: "json",
            async: true,
            url: 'GetManagerbyID/?Id=' + Id,
            success: function (data) {
                //var test = '<h6 style="font-weight:600;font-size:14;margin-bottom:1%;text-align:center;">Manager To</h6>';
                var tbdata1 = '<table id="table1" class="table table-striped table-hover bordercls"><thead><tr><th class="table-col-max">EmpCode</th><th class="table-col-max">EmpName</th><th class="table-col-max">Dependent as Manager</th></thead><tbody>'

                if (data.length > 0) {
                    $.each(data, function (key, val) {
                        $('#hdnman').val(val.key)
                        //      test += '<div class="form-group"> <div class="col-lg-6">' + val.ip + '</div> <div class="col-lg-6">' + val.sellist + '</div></div>';
                        tbdata1 += "<tr>";
                        tbdata1 += "<td>" + val.key + "</td>";
                        tbdata1 += "<td>" + val.ip + "</td>";
                        tbdata1 += "<td>" + val.sellist + "</td>";
                        tbdata1 += "</tr>";
                    })
                    cnt = 1;
                }
                else {
                    cnt = 0;
                    //test = '';
                    //test = '<h5 style="text-align:center;">No Hierarchy</h5>';
                }
                $('#dyna1').html(tbdata1)


            }

        });

        $.ajax({
            type: 'get',
            dataType: "json",
            async: true,
            url: 'GetHodbyID/?Id=' + Id,
            success: function (data) {
                // var test = '<h6 style="font-weight:600;font-size:14;margin-bottom:1%;text-align:center;">HOD To</h6>';
                var tbdata2 = '<table id="table2" class="table table-striped table-hover bordercls"><thead><tr><th class="table-col-max">EmpCode</th><th class="table-col-max">EmpName</th><th class="table-col-max">Dependent as HOD</th></thead><tbody>'
                if (data.length > 0) {
                    $.each(data, function (key, val) {
                        $('#hdnhod').val(val.key)
                        //test += '<div class="form-group"> <div class="col-lg-6">' + val.ip + '</div> <div class="col-lg-6">' + val.sellist + '</div></div>';
                        tbdata2 += "<tr>";
                        tbdata2 += "<td>" + val.key + "</td>";
                        tbdata2 += "<td>" + val.ip + "</td>";
                        tbdata2 += "<td>" + val.sellist + "</td>";
                        tbdata2 += "</tr>";
                    })
                }
                else {
                    //if (cnt == 0)
                    //    tbdata2 = '<h5 style="text-align:center;">No Hierarchy</h5>';
                    //else
                    //test = ''
                }
                //$('#dyna2').html(test)
                $('#dyna2').html(tbdata2)
            }

        });


    });

    $("#hier_user_submit").click(function () {


        var hod = $('#dyna2 select').size();
        var man = $('#dyna1 select').size();
        var managerlist = '';
        var hodlist = '';
        for (var i = 0; i < hod; i++) {
            hodlist += $('#randhod' + i + ' option').filter(":selected").attr('value') + "." + $('#randhod' + i + ' option').filter(":selected").attr('title') + ',';
        }

        for (var j = 0; j < man; j++) {
            managerlist += $('#randman' + j + ' option').filter(":selected").attr('value') + "." + $('#randman' + j + ' option').filter(":selected").attr('title') + ',';
        }

        $.ajax({
            type: 'Post',
            data: { ManagerList: managerlist, HodList: hodlist },
            url: 'HierachyUser',
            success: function (data) {
                if (data == "executed successfully") {
                    reloadPage("#RedirectToUserManagement");
                }
            }

        });

    });

    //Hierachy User

});


//Redirect helper
function reloadPage(redirectTo) {
    $('#login-modal').modal('hide');
    var url = $(redirectTo).val();
    location.href = url;
}

function reloadCAlVolume(redirectTo) {
    var url = $(redirectTo).val();
    location.href = url;
}


function clearAllText() {
    $('#input-username').empty();
    $('#input-password').empty();
}

function validateedituser() {
    if ($('#e_EmpName').val() == "") {
        $('#User_validator').html('Please enter Empname')
        return false;
    }
    else if ($('#e_password').val() == "") {
        $('#User_validator').html('Please enter Password')
        return false;
    }
    else if ($("#e_email").val() == "") {
        $('#User_validator').html('Please enter EmailID')
        return false;
    }
    else if ($("#e_contact").val() == "-1") {
        $('#User_validator').html('Please enter Contactnumber')
        return false;
    }
    return true;
}
