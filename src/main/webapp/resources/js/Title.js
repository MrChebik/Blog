/**
 * Created by mrchebik on 25.01.17.
 */
var error = 1;
var elements = 0;

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

function checkError(maxLevel) {
    if (error == 0) {
        for (i = maxLevel+1; i >= 0; i--) {
            if (document.getElementById('box' + i).style.display == 'block') {
                if (document.getElementById('select' + i).options[document.getElementById('select' + i).selectedIndex].id != '') {
                    document.getElementById('catId').value = document.getElementById('select' + i).options[document.getElementById('select' + (i)).selectedIndex].id;
                }
            }
        } 
        
        document.getElementById("form1").submit();
    } else {
        alert("The title must not be red, have not more than 50 chars and not be empty.");
    }
}

function checkSelects(sel, i, maxLevel) {
    if (typeof(sel.selectedIndex) != 'undefined') {
        elements = 0;
        
        for (j = i+2; j <= maxLevel+1; j++) {
            document.getElementById('box' + j).style.display = 'none';
        }

        var temp = sel.options[sel.selectedIndex].id;
        var nextSelect = document.getElementById('select' + (i+1));
        var lengthNextSelect = nextSelect.querySelectorAll('option').length;
        var nextBox = document.getElementById('box' + (i+1));

        nextSelect.querySelectorAll('option').forEach(function(elem) {
            if (elem.getAttribute('data-name') == temp) {
                elem.style.display = 'block'}
            else {
                elem.style.display = 'none';
                elements++;
            }
        });

        if (lengthNextSelect != elements) {
            nextBox.style.display = 'block';
            nextSelect.value = '';
        } else {
            nextBox.style.display = 'none';
        }
    }
}
