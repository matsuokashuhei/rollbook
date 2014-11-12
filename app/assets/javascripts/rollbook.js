$(document).on("focus", "[data-behaviour~='datepicker']", function(e) {
  $(this).datepicker({
    autoclose: true,
    weekStart: 1,
    language: "ja"
  });
});

$(document).on("focus", "[data-behaviour~='monthpicker']", function(e) {
  $(this).datepicker({
    //format: "yyyy-mm",
    format: "yyyy/mm",
    startView: 1,
    minViewMode: 1,
    autoclose: true,
    language: "ja"
  });
});

$(document).on("focus", "[data-behaviour~='datetimepicker']", function(e) {
  $(this).datetimepicker({
    startView: 1,
    format: "yyyy/MM/dd hh:mm:ss",
    language: "ja"
  });
});
