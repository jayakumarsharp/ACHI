
var hostpath = '/CDR';
var hostpath = '';
    $('.log-out').click(function () {
        try {
            
            //localStorage.clear();
            //localStorage.removeItem("LoadApplicationNames");
            //localStorage.removeItem("LoadAllCircles");
        }
        catch (ex) {
            console.log(ex);
        }
    });



function CompareDates(smallDate, largeDate, separator) {
    //  debugger;
    var smallDateArr = Array();
    var largeDateArr = Array();
    smallDateArr = smallDate.split(separator);
    largeDateArr = largeDate.split(separator);
    var smallDt = smallDateArr[0];
    var smallMt = smallDateArr[1];
    var smallYr = smallDateArr[2];
    var largeDt = largeDateArr[0];
    var largeMt = largeDateArr[1];
    var largeYr = largeDateArr[2];

    if (smallYr > largeYr)
        return 0;
    else if (smallYr == largeYr && smallMt > largeMt)
        return 0;
    else if (smallYr == largeYr && smallMt == largeMt && smallDt > largeDt)
        return 0;
    else
        return 1;
}

function CheckToday(largeDate, separator) {
    var hfdate = new Date();
    var smallDateArr = Array();
    var largeDateArr = Array();
    largeDateArr = largeDate.split(separator);
    var smallDt = hfdate.getDate();
    var smallMt = hfdate.getMonth() + 1;
    var smallYr = hfdate.getFullYear();
    var largeDt = largeDateArr[0];
    var largeMt = largeDateArr[1];
    var largeYr = largeDateArr[2];

    if (smallYr > largeYr)
        return 0;
    else if (smallYr == largeYr && smallMt > largeMt)
        return 0;
    else if (smallYr == largeYr && smallMt == largeMt && largeDt < smallDt)
        return 0;
    else
        return 1;
}

