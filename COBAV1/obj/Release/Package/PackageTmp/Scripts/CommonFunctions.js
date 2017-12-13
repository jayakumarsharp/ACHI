
jQuery(function ($) {

    function getApplications() {
        
        $.ajax({
            type: 'get',
            dataType: 'json',
            async: false,
            url: '@Url.Action("LoadApplicationNames", "CommonMethods")',
            success: function (data) {
                console.log(data);
                var result = data;
                $.each(result, function (index, value) {
                    $('#appname-list').append('<option value="' + value.ApplicationId + '">' + value.AdminApplicationName + '</option>');
                    //alert(index);
                });

            },
            error: function (data) { console.log(data); }
        });

    }

    function getCircles() {
        $.ajax({
            type: 'get',
            dataType: 'json',
            async: false,
            url: '@Url.Action("LoadAllCircles","CommonMethods")',
            success: function (data) {
                console.log(data);
                var result = data;
                $.each(result, function (index, value) {
                    $('#circle-list').append('<option value="' + value.CircleId + '">' + value.CircleName + '</option>');
                });
            },
            error: function (data) { console.log(data); }

        });

    }
});