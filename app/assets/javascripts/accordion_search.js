$(document).on('turbolinks:load', function(){
  $('.js_open').on('click',function(){
    let info = $(this).next('.js_search-box');
    if(info.hasClass('open')){
      info.removeClass('open').slideUp(200);
      $(this).find('.check').text('+');
    }else{
      info.addClass('open').slideDown(200);
      $(this).find('.check').text('-');
    }
  });
});