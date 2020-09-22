$(document).on('turbolinks:load', function(){
  const radio_map = {};
  $('input[type="radio"].post_form_radio_none').click(function(){
    const input = $(this);
    const name = input.attr('name');
    if (radio_map[name] === input.val()) {
      radio_map[name] = null;
      input.attr('checked', false);
    } else {
      radio_map[name] = input.val();
    }
  }).each(function(){
    const input = $(this);
    if (input.prop('checked')) {
      const name = input.attr('name');
      radio_map[name] = input.val();
    }
  });
});