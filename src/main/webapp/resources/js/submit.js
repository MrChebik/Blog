/**
 * Created by mrchebik on 24.01.17.
 */
function submitData(id, elementId) {
    document.getElementById(elementId).value = id;
    document.getElementById("form2").submit();
}