$(document).on("turbolinks:load", function() {
  navEvents.setToggle();
});

var navEvents = {
  setToggle: function() {
    $(".hamburger").off().on("click", function() {
      $(".menu-items").toggle();
    });
  }
}