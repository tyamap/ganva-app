function count_up() {
  val = $('.level-counter input').val();
  if (val < 10000) {
    $('.level-counter input').val(++val);
  }
}

function count_down() {
  val = $('.level-counter input').val();
  if (val > 0) {
    $('.level-counter input').val(--val);
  }
}

$(document).on('ready turbolinks:load', () => {
  $('.level-counter .plus').on('click', () => {
    count_up();
  });
  $('.level-counter .minus').on('click', () => {
    count_down();
  });
});