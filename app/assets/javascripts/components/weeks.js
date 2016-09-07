$(document).ready(function() {
  var addLink = $('.add-weeks-link')

  if (addLink) {
    $(addLink).off().on('click', function() {
      $('.add-weeks-form').toggle();
    });
  }
});