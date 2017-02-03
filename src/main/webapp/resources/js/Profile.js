/**
 * Created by mrchebik on 02.02.17.
 */
var error = 1;

function checkSetting(elem) {
    if (elem.name == 'email') {
        if (elem.value.indexOf('@') == -1) {
            elem.style.borderColor = "red";
            error = 1;
        } else {
            elem.style.borderColor = "darkgreen";
            error = 0;
        }
    } else {
        var passwordConfirm = document.getElementsByName('passwordConfirm')[0];

        if (passwordConfirm.value != document.getElementsByName('newPassword')[0].value && passwordConfirm.value != '') {
            passwordConfirm.style.borderColor = 'red';
            error = 1;
        } else {
            passwordConfirm.style.borderColor = 'darkgreen';
            error = 0;
        }

        if (passwordConfirm.value == '') {
            error = 1;
        }
    }
}

function checkError(info) {
    if (error == 0) {
        document.getElementsByName("type")[0].value = info;
        document.getElementById("form1").submit();
    } else {
        alert("Error");
    }
}