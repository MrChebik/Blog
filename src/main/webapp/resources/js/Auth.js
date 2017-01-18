/**
 * Created by mrchebik on 15.01.17.
 */
var error = 1;

function check(id) {
    var element = document.getElementById(id);

    if (element.value.length < 4 || element.value.length > 60) {
        element.style.borderColor = 'red';
        error = 1;
    } else {
        element.style.borderColor = 'darkgreen';
        error = 0;
    }

    var passwordConfirm = document.getElementById('passwordConfirm');

    if (passwordConfirm.value != document.getElementById('password').value && passwordConfirm.value != '') {
        passwordConfirm.style.borderColor = 'red';
        error = 1;
    } else {
        passwordConfirm.style.borderColor = 'darkgreen';
        error = 0;
    }

    if (passwordConfirm.value == '') {
        error = 1;
    }

    if (element.getAttribute('id') == 'email') {
        if (element.value.indexOf('@') == -1) {
            element.style.borderColor = "red";
            error = 1;
        } else {
            element.style.borderColor = "darkgreen";
            error = 0;
        }
    }
}

function checkError() {
    if (error == 0) {
        document.getElementById("form1").submit();
    } else {
        alert("Check your login and password, they must not be red or empty.");
    }
}