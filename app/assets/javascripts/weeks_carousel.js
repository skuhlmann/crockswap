$(document).ready(function() {
  var owl = $(".owl-carousel");

  if (owl.length > 0) {
    // owl.owlCarousel({
    //   items : 3,
    // });

    owl.owlCarousel();


    var owlInstance = $(".owl-carousel").data('owlCarousel');
    var weekIndex = owl.attr('data-current-week-index');
    owlInstance.jumpTo(weekIndex);
  }
});