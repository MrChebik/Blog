/**
 * Created by mrchebik on 02.02.17.
 */
var error = 1;
var password = $('#passwordConfirm');

function checkSetting(element) {
    var elem = $('#' + element);

    if (element == 'username' || element == 'oldPassword' || element == 'newPassword') {
        if (elem.val().length < 4 || elem.val().length > 60) {
            elem.css("borderColor", "red");
            error = 1;
        } else {
            elem.css("borderColor", "darkgreen");
            error = 0;
        }

        if (id == 'newPassword') {
            if (password.val() != elem.val() && elem.val() != '') {
                password.css("borderColor", "red");
                error = 1;
            } else {
                password.css("borderColor", "darkgreen");
                error = 0;
            }
        }
    } else if (element == 'newEmail') {
        if (elem.val().indexOf('@') == -1) {
            elem.css("borderColor", "red");
            error = 1;
        } else {
            elem.css("borderColor", "darkgreen");
            error = 0;
        }
    } else {
        if (elem.val() != $('#password').val() && elem.val() != '') {
            elem.css("borderColor", "red");
            error = 1;
        } else {
            elem.css("borderColor", "darkgreen");
            error = 0;
        }

        if (elem.val() == '') {
            error = 1;
        }
    }
}

function checkError(info) {
    if (error == 0) {
        document.getElementById(info).submit();
    } else {
        alert("Error");
    }
}