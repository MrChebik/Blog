/**
 * Created by mrchebik on 11.02.17.
 */
var error = 1;

function check() {
    var element = $("input[name='title']");

    if (element.val().length < 1 || element.val().length > 80) {
        element.css("borderColor", "red");
        error = 1;
    } else {
        element.css("borderColor", "darkgreen");
        error = 0;
    }
}

function checkError() {
    if (error == 0) {
        var saver = "";

        $("#categories :selected").each(function () {
            saver += this.id + ',';
        });

        saver = saver.slice(0, -1);

        $("input[name='categoriesId']").val(saver);
        document.getElementById("post-form").submit();
    } else {
        alert("Some error");
    }
}