$(function () {
    $(document).on('click', '.js-edit-comment-button', function () {
        // 表示
        var id = $(this).data('id');
        $('#js-comment-' + id).hide();
        $('#js-textarea-comment-box-' + id).show();
    });
})

$(function () {
    $(document).on('click', '.js-button-edit-comment-cancel', function () {
        // 非表示
        var id = $(this).data('comment-id');
        $('#js-comment-' + id).show();
        $('#js-textarea-comment-box-' + id).hide();
    });
})

$(function () {
    $(document).on('click', '.js-button-comment-update', function () {
        var id = $(this).data('comment-id');
        const textField = $('#js-textarea-comment-' + id);
        const body = textField.val();
        $.ajax({
            type: 'PUT',
            url: '/comments/' + id,
            data: {
                comment: {
                    body: body
                }
            }
        }).done(function () {
            // 成功処理
            $('#js-textarea-comment-box-' + id).hide();
            $('#js-comment-' + id).text(body);
            $('#js-comment-' + id).show();
        }).fail(function () {
            // 失敗処理
            $('#js-textarea-comment-' + id).before('<p>コメントを入力してください</p>');
        });
    });
})