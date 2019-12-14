document.addEventListener('turbolinks:load', function () {
  $('.admin_flag').each(function (i) {
    if ($(this).text() == '◯') {
      $(this).addClass('bg-danger text-white');
    }
  });
});