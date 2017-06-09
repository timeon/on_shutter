// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/*
$('.submittable').live('change', function() {
  $(this).parents('form:first').submit();
});
*/
// If any events are not handled here, 
// the resonseText will be automatially executed as javascript
// Therefore if the response is a partial that includes html code only
// It must be handled here to replace a certain element
$(document).ready(function(){
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place()

  // handle content and response vote result from server
  // TODO: update vote cell at ajax:before to improve responsiveness
  
  $('.vote')
    .on("ajax:success", function(evt, data, status, xhr){
      // replace voting cell with response partial 
      evt.currentTarget.innerHTML = data.responseText;
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // TODO: improve on how to show error  
      $("#"+evt.currentTarget.id + "_notice")[0].innerHTML = data.responseText;
      evt.currentTarget.innerHTML = data.responseText;
    });

  $('#edit_post')
    .on("ajax:success", function(evt, data, status, xhr){
      // Hide the edit form 
	  $('#edit_post').hide();

      // update the response
	  $('#post_info')[0].outerHTML = data.responseText;
        
    });
        
  $('#add_response')
    .on("ajax:success", function(evt, data, status, xhr){
      // replace the new response cell with response partial 
      //evt.currentTarget.outerHTML = data.responseText;
      $("#response_")[0].outerHTML = data.responseText;
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // replace the new response cell with response partial 
      //evt.currentTarget.outerHTML = data.responseText;
      $("#response_")[0].outerHTML = data.responseText;
    })    
    .on("ajax:before", function(evt, data, status, xhr){
      // replace the new response cell with response partial 
      //evt.currentTarget.outerHTML = data.responseText;
      $("#response_")[0].outerHTML = data.responseText;
    });    
  // remove the response from the pagea without waiting the response 
  // show it back if there is an error later.  
  $('.delete_response')
    .on("ajax:before", function(evt, data, status, xhr){
      // replace voting cell with response partial 
      $('#' + evt.currentTarget.name).hide()
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // error delete from server, show it back 
      $('#' + evt.currentTarget.name).show()
    });
    
  // hide edit box and show updated response 
  $('.edit_response, .edit_critique')
    .on("ajax:success", function(evt, data, status, xhr){
      // Hide the edit form 
      $("#"+evt.currentTarget.id).hide();
      // update the response
      $("#"+evt.currentTarget.id.replace("edit_", ""))[0].outerHTML = data.responseText;
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // TODO: improve on how to show error  
      $("#"+evt.currentTarget.id + "_notice")[0].innerHTML = data.responseText;
    })
    .on("ajax:before", function(evt, data, status, xhr){
      // TODO: improve on how to show error  
      $("#"+evt.currentTarget.id.replace("edit_", ""))[0].outerHTML = data.responseText;
    });
    
    
  // hide edit box and show updated response 
  $('.add_comment')
    .on("ajax:success", function(evt, data, status, xhr){
      parts = 	evt.currentTarget.id.split("_")
      
      resource = parts[0]
      id = parts[3]     	

      // Hide the edit form 
      hide_comment_form(resource, id)
      // update the response
      $("#comment_list_" + resource + "_" + id).append(data.responseText);
      
      jQuery(".best_in_place").best_in_place();
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // TODO: improve on how to show error  
      $("#"+evt.currentTarget.id + "_notice")[0].innerHTML = data.responseText;
    });
    
  // remove the response from the pagea without waiting the response 
  // show it back if there is an error later.  
  $('.delete_comment')
    .on("ajax:before", function(evt, data, status, xhr){
      // replace voting cell with response partial 
      $('#' + evt.currentTarget.name).hide()
    })
    .on("ajax:error", function(evt, data, status, xhr){
      // error delete from server, show it back 
      $('#' + evt.currentTarget.name).show()
    });
        
});

function show_edit_response_form(id){
  $('#response_body_' + id).hide(); 
  $('#edit_response_' + id).show();
  new nicEditor({fullPanel : true}).panelInstance('response_editor_' + id);
}
   
function hide_edit_response_form(id){
  $('#edit_response_' + id).hide();
  $('#response_body_' + id).show(); 
}

function show_edit_post_form(id){
  $('#post_info').hide(); 
  $('#edit_post').show();
  new nicEditor({fullPanel : true}).panelInstance('post_editor');
}

function hide_edit_post_form(id){
  $('#edit_post').hide();
  $('#post_info').show(); 
}

function show_comment_form(resource, id)
{
  $('#' + resource + '_comment_link_' + id).hide()
  $('#' + resource + '_comment_form_' + id).show()
}

function hide_comment_form(resource, id)
{
  $('#' + resource + '_comment_link_' + id).show()
  $('#' + resource + '_comment_form_' + id).hide()
}

function show_flash_login(id, action, return_to)
{
  var anchor;
  anchorPos = return_to.indexOf("#")
  if (anchorPos >0)
  {
    anchor = return_to.substr(anchorPos+1)
    return_to = return_to.substr(0, anchorPos)
  }

  html  = '<div align="center">'
  html += '<h2>Please <a href="/users/login';
  html += '?return_to=' + return_to
  if (anchorPos > 0)
  {
    html += '&anchor=' + anchor
  }
  html += '">login</a> to ' + action 
  html +=  '</h2> (cancel)'
  html +=  '</div>'
  
  $('#'+id)[0].innerHTML = html

  $('#'+id).show();
}

function show_flash_self(id)
{
  $('#'+id)[0].innerHTML = "<h2>You can't vote on your own.</h2>(click on this box to dismiss)"
  $('#'+id).show();
}

function textarea_to_editor()
{
  if (document.getElementById("new_post_editor") != null)
  {
    new nicEditor({fullPanel : true}).panelInstance('new_post_editor');
  }

  if (document.getElementById("new_response_editor") != null)
  {
    new nicEditor({fullPanel : true}).panelInstance('new_response_editor');
  }
  
  if (document.getElementById("about_me_editor") != null)
  {
    new nicEditor({fullPanel : true}).panelInstance('about_me_editor');
  }
  
}

