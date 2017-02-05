/**
 * Created by mrchebik on 25.01.17.
 */
var error = 1;

function check() {
    var element = document.getElementById('title');

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
        var element = document.getElementsByName('categories')[0].options;
        for (i = 0; i < element.length; i++) {
            if (element[i].selected == true) {
                document.getElementsByName('categoriesId')[0].value += element[i].id;
                if (i != element.length - 1) {
                    document.getElementsByName('categoriesId')[0].value += ',';
                }
            }
        }
        document.getElementById("form1").submit();
    } else {
        alert("The title must not be red, have not more than 50 chars and not be empty.");
    }
}

function edit(i) {
    document.getElementById('edit').style.display = 'none';
    document.getElementById('cat' + i).style.display = 'none';
    document.getElementById('text' + i).style.display = 'block';
}

function save(i) {
    if (i.value.length < 1 || i.value.length > 50) {
        element.style.borderColor = 'red';
        error = 1;
    } else {
        element.style.borderColor = "#9999CC";
        error = 0;
    }
}