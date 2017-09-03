jQuery(function ($) {

    //var $object = $('#batch-date');
    //if ($object.length) {
    //$('#batch-date').datepicker({
    //    endDate: new Date()
    //    //,
    //    //setDate:new Date() 
    //});

    //$('.date-picker').datepicker({
    //    endDate: new Date()
    //    //,
    //    //setDate:new Date() 
    //});
    // }

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
                if (data == "Logged in successfully") {
                    reloadPage("#RedirectToHome");
                }
            }
        });
        disabled.attr('disabled', 'disabled');
        event.preventDefault();
    });


    /*Delete User*/
    //$(".delete").on("click", function () {
    //    //$('#myModal').modal('show');
    //    var self = $(this);
    //    var result = confirm("Want to delete?");
    //    if (result == true) {
    //        //Logic to delete the item
    //        $.ajax({
    //            url: "UserManagement/DeleteUser",
    //            type: "POST",
    //            data: { UserName: self.data("username"), Role: self.data("role"), Status: self.data("status") },
    //            success: function (data) {
    //                self.closest('tr').fadeOut();
    //                console.log(self);
    //            }
    //        });
    //    }

    //});


    //Reset controls
    $(".reset").click(function () {
        $(this).closest('form').find("input[type=text], textarea, select").val("");
    });

    $('a').click(function () {
        $(".user-message, .validation").html("");
    })

    //Clear validation text when bootstrap modal pops up 
    $('#edit-modal, #create-modal, #login-modal, #pwd-modal').on('shown.bs.modal', function () {
        $(".user-message, .validation").html("");
        $(".form-control").val("");
    });

    //Redirect on modal close
    $('#edit-modal, #create-modal').on('hidden.bs.modal', function () {
        reloadPage("#RedirectToUserManagement");
    });




    //Redirect helper
    function reloadPage(redirectTo) {
        $('#login-modal').modal('hide');
        var url = $(redirectTo).val();
        location.href = url;
    }



    
});


/*Role Management related functions ends here*/

