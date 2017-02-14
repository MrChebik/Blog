/**
 * Created by mrchebik on 24.01.17.
 */
var error = 1;

function submitData(id, elementId) {
    document.getElementById(elementId).value = id;
    document.getElementById("form2").submit();
}

