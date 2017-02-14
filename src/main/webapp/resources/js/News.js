/**
 * Created by mrchebik on 08.02.17.
 */
var error = 1;

$(function() {
    $('#login-form-link').click(function(e) {
        $("#login-form").show('fast');
        $("#register-form").hide('fast');
        $('#register-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
        error = 1;
    });
    $('#register-form-link').click(function(e) {
        $("#register-form").show('fast');
        $("#login-form").hide('fast');
        $('#login-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
        error = 1;
    });
});

var password = $('#register-passwordConfirm');

function check(id) {
    var element = $('#' + id);
    if (id == 'register-username' || id == 'login-username' || id == 'login-password' || id == 'register-password') {
        if (element.val().length < 4 || element.val().length > 60) {
            element.css("borderColor", "red");
            error = 1;
        } else {
            element.css("borderColor", "darkgreen");
            error = 0;
        }
        
        if (id == 'register-password') {
            if (password.val() != element.val() && element.val() != '') {
                password.css("borderColor", "red");
                error = 1;
            } else {
                password.css("borderColor", "darkgreen");
                error = 0;
            }
        }
    } else if (id == 'register-passwordConfirm') {
        if (element.val() != $('#register-password').val() && element.val() != '') {
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
        if (element.val().indexOf('@') == -1) {
            element.css("borderColor", "red");
            error = 1;
        } else {
            element.css("borderColor", "darkgreen");
            error = 0;
        }
    }
}

function checkError(id) {
    if (error == 0) {
        $('#' + id).submit();
    } else {
        alert("Check your fields, they must not be red or empty.");
    }
}