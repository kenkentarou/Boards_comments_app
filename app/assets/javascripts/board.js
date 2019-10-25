$(function () {
    function readURL(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $('#js_img_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#js_board_img").change(function () {
        readURL(this);
    });
})