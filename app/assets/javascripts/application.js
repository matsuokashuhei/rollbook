// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require_tree .

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

//$(document).on("focus", "[data-toggle~='tooltip']", function(e) {
//  $(this).tooltip()
//});
//$("[data-toggle~='tooltip']").tooltip()
