$(document).ready(function() {
  var scroller = $('.scroller');

  if (scroller) {
    scroller.slick({
      dots: false,
      slidesToShow: 2,
      slidesToScroll: 2,
      infinite: false,
      prevArrow: $('.weeks-arrow-left'),
      nextArrow: $('.weeks-arrow-right'),
      responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2,
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
        ]
    });

    var weekIndex = parseInt(scroller.attr('data-current-week-index'));
    scroller.slick('slickGoTo', weekIndex, false);
  }
});