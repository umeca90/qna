$ ->
  commentForm = $('.create-comment')
  comments = $('.comments')
  commentsBlock = $('.commentsBlock')

  commentForm.on 'ajax:success', (e) ->
    xhr = e.detail[0]
    resourceName = xhr['commentable_type'].toLowerCase()
    resourceId = xhr['commentable_id']
    resourceContent = xhr['body']
    question = ".#{resourceName}-#{resourceId}"
    $("#{question} .comment-block .comments").append('<div class="comment"><p>'+ resourceContent + '</p></div>')

  commentForm.on 'ajax:error', (e) ->
    errors = e.detail[0]
    $.each errors, (index, value) ->
      $('.comment-errors').append('<p>' + index + ' ' + value + '<p>')

