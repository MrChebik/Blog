/**
 * Created by mrchebik on 09.02.17.
 */
var password = $('#password-confirm');

function check(id) {
    var element = $('#' + id);
    if (id == 'forgot-email') {
        if (element.val().indexOf('@') == -1) {
            element.css("borderColor", "red");
            error = 1;
        } else {
            element.css("borderColor", "darkgreen");
            error = 0;
        }
    } else if (id == 'password-confirm') {
        if (element.val() != $('#password').val() && element.val() != '') {
            element.css("borderColor", "red");
            error = 1;
        } else {
            element.css("borderColor", "darkgreen");
            error = 0;
        }

        if (element.val() == '') {
            error = 1;
        }
    } else {
        if (element.val().length < 4 || element.val().length > 60) {
            element.css("borderColor", "red");
            error = 1;
        } else {
            element.css("borderColor", "darkgreen");
            error = 0;
        }

        if (element.val() != password.val() && element != '') {
            password.css("borderColor", "red");
            error = 1;
        } else {
            password.css("borderColor", "darkgreen");
            error = 0;
        }
    }
}

function checkError(id) {
    if (id != 'code-form') {
        if (error == 0) {
            $('#' + id).submit();
        } else {
            alert("Check your email, it must not be red or empty.");
        }
    } else {
        $('#' + id).submit();
    }
}