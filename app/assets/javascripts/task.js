document.addEventListener('turbolinks:load', function() {
  $('.priority').each(function (i) {
    if ($(this).text() == '高') {
      $(this).addClass('bg-danger text-white');
    }
  });

  $('.status').each(function (i) {
    if ($(this).text() == '未着手') {
      $(this).addClass('bg-warning text-white');
    }
  });

  $('.status').each(function (i) {
    if ($(this).text() == '完了') {
      $(this).addClass('bg-success text-white');
    }
  });

  if ($('#priority').text() == '高') {
    $('#priority').addClass('bg-danger text-white');
  }

  if ($('#status').text() == '未着手') {
    $('#status').addClass('bg-warning text-white');
  }

  if ($('#status').text() == '完了') {
    $('#status').addClass('bg-success text-white');
  }
});
