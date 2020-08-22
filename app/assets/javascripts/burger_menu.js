$(document).on('turbolinks:load', function(){
  $('.bars').on('click',function(){
    if($(this).hasClass('active')){
      $(this).removeClass('active');
    } else {
      $(this).addClass('active');
      $('.nav').addClass('open');
      $('.overlay').addClass('open');
      $('.close').addClass('open');
    }
  });
  $('.overlay').on('click',function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('.nav').removeClass('open'); 
      $('.bars').removeClass('active');
    }
  });
  $('.close').on('click',function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('.nav').removeClass('open');
      $('.overlay').removeClass('open');
      $('.bars').removeClass('active');
    }
  });
});