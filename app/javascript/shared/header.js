function toggle_alert() {
  $('#alert-area .alert').remove();
}

$(document).on('ready turbolinks:load', () => {
  if ($('#alert-area .alert').length) {
    $('#alert-area .alert').on('click', () => {
      toggle_alert();
    });
  }
});