/**
 * Created by mrchebik on 28.01.17.
 */
var error = 1;

function edit(i) {
    $('#edit' + i).css("display", "none");
    $('#save' + i).css("display", "block");
    $('#cat' + i).css("display", "none");
    $('#text' + i).css("display", "block");
}

function saveData(id) {
    if (error == 0) {
        window.location.href='/blog/categories/edit?id=' + id + '&name=' + $('#text' + id).val();
    } else {
        alert('Error, check name of category');
    }
}

function checkText(i) {
    if (i.value.length < 1 || i.value.length > 50) {
        i.style.borderColor = 'red';
        error = 1;
    } else {
        i.style.borderColor = "black";
        error = 0;
    }
}

function checkError(form) {
    if (error == 0) {
        $('#' + form).submit();
    } else {
        alert("Some error");
    }
}