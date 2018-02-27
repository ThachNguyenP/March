$(document).ready ->
  appendTask = undefined
  $('.add_new').click ->
    appendTask $(this).parent().children('.tasks')

  appendTask = (board) ->
    board.append '<div class="task">meh.</div>'
    board.children('.task').each (i, t) ->
      console.log t
      $(t).draggable()

  $('.task').draggable()
  return
