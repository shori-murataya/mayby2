$(document).on('turbolinks:load', function(){
  const inputs = $('[type="radio"].js-post-form-radio-none');
  let checked = inputs.filter(':checked').val();
  inputs.on('click', function(){
    if($(this).val() === checked) {
      $(this).prop('checked', false);
      checked = '';
    } else {
      $(this).prop('checked', true);
      checked = $(this).val();
    }
  });
});