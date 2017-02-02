/**
 * Created by mrchebik on 24.01.17.
 */
var error = 1;

function submitData(id, elementId) {
    document.getElementById(elementId).value = id;
    document.getElementById("form2").submit();
}

function saveData(id) {
    if (error == 0) {
        window.location.href='/blog/categories/edit?id=' + id + '&name=' + document.getElementById('text' + id).value;
    } else {
        alert('Error, check name of category');
    }
}

function edit(i) {
    document.getElementById('edit').style.display = 'none';
    document.getElementById('save').style.display = 'block';
    document.getElementById('cat' + i).style.display = 'none';
    document.getElementById('text' + i).style.display = 'block';
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