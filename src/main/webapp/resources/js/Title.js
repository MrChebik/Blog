/**
 * Created by mrchebik on 25.01.17.
 */
var error = 1;

function check(id) {
    var element = document.getElementById(id);

    if (element.value.length < 1 || element.value.length > 50) {
        element.style.borderColor = 'red';
        error = 1;
    } else {
        element.style.borderColor = "#9999CC";
        error = 0;
    }
}

function checkError() {
    if (error == 0) {
        document.getElementById("form1").submit();
    } else {
        alert("The title must not be red, have not more than 50 chars and not be empty.");
    }
}