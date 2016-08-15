// $(document).on("ready page:load", function() {
$(document).on("page:change", function() {

  $(".hamburger").on("click", function() {
    $(".menu-items").toggle();
  });

});