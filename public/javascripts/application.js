function init_download_dialog(){
  $('#download_dialog').dialog({
    width: 400,
    height: 210,
    autoOpen: false,
    modal: true,
    draggable: false,
    resizable: false,
    buttons: {
      Cancel: function(){
        $(this).dialog('close');
      },
      "Download": function(){
        var prefix = $('#download_dialog_prefix').val();
        var team_id = $('#download_dialog_team_id').val();
        var form = $('#download_dialog_form').val();
        var url = "/teams/" + team_id + "/code?prefix=" + prefix + "&form=" + form;
        window.location.href = url;
        $(this).dialog('close');
      }
    }
  });
  $('.download_link').click(function(e){
    e.preventDefault();
    var split = $(this).attr('id').split('_');
    var team_id = split[split.length-2]
    var prefix = split[split.length-1]
    var form = "pm";
    $('#download_dialog_prefix').val(prefix);
    $('#download_dialog_team_id').val(team_id);
    $('#download_dialog_form').val(form);
    $('#download_dialog').dialog('open');
  });
}

$(document).ready(function() {
  init_download_dialog();
});

