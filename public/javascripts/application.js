function init_submit_buttons(){
  $('#custom_submit_button').button();
}

function create_download_dialog(){
  $('#download_dialog').dialog({
    width: 380,
    height: 250,
    autoOpen: false,
    modal: true,
    draggable: false,
    resizable: false,
    buttons: {
      Cancel: function(){
        $(this).dialog('close');
      },
      "Download": function(){
        var team_name = $('#download_dialog_team_name').val();
        var prefix = $('#download_dialog_prefix').val();
        var team_id = $('#download_dialog_team_id').val();
        var form = $('#download_dialog_form').val();
        var url = "/teams/" + team_id + "/code?team_name=" + team_name + "&prefix=" + prefix + "&form=" + form;
        window.location.href = url;
        $(this).dialog('close');
      }
    }
  });
}

function replace_download_dialog_button(){
  $('.download_link').click(function(e){
    e.preventDefault();
    var split = $(this).attr('id').split('_');
    var team_id = split[0]
    var prefix = split[1]
    var team_name = split[2]
    var form = "pm";
    $('#download_dialog_team_name').val(team_name);
    $('#download_dialog_prefix').val(prefix);
    $('#download_dialog_team_id').val(team_id);
    $('#download_dialog_form').val(form);
    $('#download_dialog').dialog('open');
  });
}

function init_download_dialog(){
  create_download_dialog();
  replace_download_dialog_button();
}

function ajaxify_links(){
  $('.pagination a').live('click', function(){
    $.getScript(this.href, function(){
      replace_download_dialog_button();
    });
    return false;
  });
}

function ajaxify_search_button(){
  $('#team_search_form').submit(function(){
    $.get(this.action, $(this).serialize(), function(){
      replace_download_dialog_button();
    }, "script");
    return false;
  });
}

$(document).ready(function() {
  init_download_dialog();
  init_submit_buttons();
  ajaxify_links();
  ajaxify_search_button();
});

