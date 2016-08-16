$(document).ready(function() {
  navEvents.setToggle();
});

var navEvents = {
  setToggle: function() {
    $(".hamburger").on("click", function() {
      $(".menu-items").toggle();
    });
  }
}