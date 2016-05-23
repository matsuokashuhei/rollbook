//$(document).on('page:change', function() {
$(function() {
  $("#lesson tr[data-href]").click(function(e) {
      if ($(e.target).is('a')) {
        return
      }
      location.href = $(e.target).closest('tr').data('href');
  });
  $("#lesson tr[data-lesson]").click(function(e) {
      if ($(e.target).is('a')) {
        return
      }
      $(e.target).closest('tr').children('form').submit();
      return false;
  });
});
