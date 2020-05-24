$(document).on('ready turbolinks:load', () => {
  $("input[type='number']").each(function () {
    let el = $(this);
    el.wrap('<span class="level-counter"></span>');
    el.before('<span class="minus">ー</span>');
    el.after('<span class="plus">＋</span>');

    // カウントダウン
    el.parent().on('click', '.minus', function () {
      if (el.val() > parseInt(el.attr('min')))
        el.val( function(_i, oldval) { return --oldval; });
    });
    
    // カウントアップ
    el.parent().on('click', '.plus', function () {
      if (el.val() < parseInt(el.attr('max')))
        el.val( function(_i, oldval) { return ++oldval; });
    });
  });
});