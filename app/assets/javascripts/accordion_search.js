$(document).on('turbolinks:load', function(){
  $('.info_open').on('click',function(){
    const $info = $(this).next('.search-box');
    if($info.hasClass('open')){
      $info.removeClass('open').slideUp(200);
      $(this).find('.check').text('+');
    }else{
      $info.addClass('open').slideDown(200);
      $(this).find('.check').text('-');
    }
  });
});