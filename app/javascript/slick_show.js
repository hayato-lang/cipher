$(function(){
  $('.show-events').slick({
    autoplaySpeed: 3000,
    speed: 1000,
    autoplay: true,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    prevArrow: '<div class="slick-back"></div>',
    nextArrow: '<div class="slick-front"></div>',
    dots: true,
    pauseOnFocus: false,
    pauseOnHover: false,
    pauseOnDotsHover: false,
  });
});

$(function(){
  $(".show-events").on('touchmove', function(event, slick, currentSlide, nextSlide){
    $(".show-events").slick('slickPlay');
});
});