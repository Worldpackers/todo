$(document).ready(function() {
  $(".check-completed").on("click", function() {
    if(this.checked) {
      modal_treats('Are you sure you have completed this task?', $(this).val(), this.checked);
    } else {
      modal_treats('Are you sure you want to reopen this task?', $(this).val(), this.checked);
    }
    $("#modal-alert").modal();
    return false;
  });

  $(".save-task").on("click", function() {
    id_task = $("#modal-alert").find('.modal-id-task').val();
    checked = $("#modal-alert").find('.modal-task').val();

    $.ajax({
      type: "PUT",
      url: "/tasks/"+id_task,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      dataType: 'json',
      data: { 'task': {'completed':checked }},
      success: function(data, textStatus, jqXHR){
        $("input:checkbox[id='completed'][value='"+data.id+"']").prop('checked', data.completed);
        console.log(data);
      },
      error: function(jqXHR, textStatus, errorThrown){
        console.log(textStatus);
      }
    });
    $("#modal-alert").modal('hide');
  });
});

function modal_treats(text, id_task, checked){
  $("#modal-alert").on('show.bs.modal', function (event) {
    var modal = $(this)
    modal.find('.modal-body').text(text);
    modal.find('.modal-id-task').val(id_task);
    modal.find('.modal-task').val(checked);
  });
}
