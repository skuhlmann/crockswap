$(document).ready(function() {
  var owl = $(".owl-carousel");
  owl.owlCarousel({
    items : 3,
  });

  var owlInstance = $(".owl-carousel").data('owlCarousel');
  var weekIndex = owl.attr('data-current-week-index');
  owlInstance.jumpTo(weekIndex);
});