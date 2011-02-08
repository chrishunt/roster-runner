function init_prefix_dialog(){
  $('#prefix_dialog').dialog({
    width: 500,
    height: 180,
    autoOpen: false,
    modal: true,
    draggable: false,
    resizable: false,
    buttons: {
      Cancel: function(){
        $(this).dialog('close');
      },
      "Download": function(){
        var prefix = $('#prefix_dialog_input').val();
        var id = $('#prefix_dialog_team_id').val();
        var form = $('#prefix_dialog_form').val();
        var url = "/teams/" + id + "/code?prefix=" + prefix + "&form=" + form;
        window.location.href = url;
        $(this).dialog('close');
      }
    }
  });
  $('.code_link').click(function(e){
    e.preventDefault();
    var split = $(this).attr('id').split('_');
    var id = split[split.length-3]
    var prefix = split[split.length-2]
    var form = split[split.length-1]
    $('#prefix_dialog_input').val(prefix);
    $('#prefix_dialog_team_id').val(id);
    $('#prefix_dialog_form').val(form);
    $('#prefix_dialog').dialog('open');
  });
}

$(document).ready(function() {
  init_prefix_dialog();
});

