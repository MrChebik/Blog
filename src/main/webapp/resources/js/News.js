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

function check(id) {
    if (id == 'register-username' || id == 'login-username' || id == 'login-password' || id == 'register-password') {
        if ($('#' + id).val().length < 4 || $('#' + id).val().length > 60) {
            $('#' + id).css("borderColor", "red");
            error = 1;
        } else {
            $('#' + id).css("borderColor", "darkgreen");
            error = 0;
        }
    } else if (id == 'register-passwordConfirm') {
        if ($('#' + id).val() != $('#register-password').val() && $('#' + id) != '') {
            $('#' + id).css("borderColor", "red");
            error = 1;
        } else {
            $('#' + id).css("borderColor", "darkgreen");
            error = 0;
        }

        if ($('#' + id).val() == '') {
            error = 1;
        }
    } else {
        if ($('#' + id).val().indexOf('@') == -1) {
            $('#' + id).css("borderColor", "red");
            error = 1;
        } else {
            $('#' + id).css("borderColor", "darkgreen");
            error = 0;
        }
    }
}

function checkError(id) {
    if (error == 0) {
        $('#' + id).submit();
    } else {
        alert("Check your login and password, they must not be red or empty.");
    }
}