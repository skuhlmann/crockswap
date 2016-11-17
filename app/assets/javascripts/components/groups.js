$(document).ready(function() {
  var deleteLink = $('.delete-group-link');

  if (deleteLink) {
    $(deleteLink).off().on('click', function() {
      $('.delete-group-confirmation').show();

      var cancelLink = $('.delete-group-cancel');
      
      $(cancelLink).off().on('click', function() {
        $('.delete-group-confirmation').hide();
      });
    });
  }
});