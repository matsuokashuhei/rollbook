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
  $(".lessons").hover(
      function() {
          $(this).toggleClass("warning");
      },
      function() {
          $(this).toggleClass("warning");
      }
  );
  $("td.lessons[data-href]").click(function(e) {
      location.href = $(e.target).closest('td').data('href');
  });
});
