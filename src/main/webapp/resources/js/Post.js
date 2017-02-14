/**
 * Created by mrchebik on 13.02.17.
 */
var error = 1;

function check(id) {
    var element = $('#' + id);
    
    if (element.val() < 1 || element.val() > 500) {
        element.css("borderColor", "red");
        error = 1;
    } else {
        element.css("borderColor", "darkgreen");
        error = 0;
    }
}

function checkError(form) {
    if (error == 0) {
        $('#' + form).submit();
    } else {
        alert('Some error');
    }
}