 $(document).ready(function() {
       new Swiper('.swiper-container', {
           effect:'coverflow',
           centeredSlides: true,
           slidesPerView: 'auto',
           autoplay: {
               delay: 2500,
               disableOnInteraction: true,
           },
           coverflowEffect: {
               rotate: 50,
               stretch: 0,
               depth: 100,
               modifier: 1,
               slideShadows : true,
           },


       });
       var mySwiper = document.querySelector('.swiper-container').swiper

       $(".swiper-container").mouseenter(function() {
           mySwiper.autoplay.stop();
           console.log('slider stopped');
       });

       $(".swiper-container").mouseleave(function() {
           mySwiper.autoplay.start();
           console.log('slider started again');
       });
   });