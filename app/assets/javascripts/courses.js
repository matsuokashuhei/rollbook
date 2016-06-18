$(document).ready(function() {
  $(".course").hover(
      function() {
          $(this).toggleClass("warning");
      },
      function() {
          $(this).toggleClass("warning");
      }
  );
});
