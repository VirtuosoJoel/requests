$(document).ready(function() {

  $('a.new').click(function(){
    url = $(this).attr('href');
    $.get(url, function(data){
      removeForm();
      appendForm(data)
    });

    return false;
  });

  $('a.cancel').live('click', function() {
    $('.row').show();
    removeForm();
    return false;
  });
	
  $(document).ready(
	  function(){
	    setInterval(function(){
	      $('.body-div').load('/requests/refresh')
	    }, 30000);
	    
	  }
  );


});

function removeForm() {
  $('.form').remove();
}

function appendContent(content){
  $('.body-div').append(content);
}

function appendForm(content){
  $('.form-div').append(content);
}

function printpage()
  {
  window.print()
  }