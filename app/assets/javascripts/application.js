// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap-material-design
//= require nprogress
//= require nprogress-turbolinks
//= require data-confirm-modal
//= require_tree .

dataConfirmModal.setDefaults({
  title: 'Sei sicuro?',
  commit: 'Conferma',
  cancel: 'Annulla'
});

document.oncontextmenu = function () {
   return false;
};


$(function(){
  // clickable table entire row
  $(document).on("click", '.table.table-clickable-row > tbody > tr', function(e){
    window.location = $(this).find("a").first().attr("href")
  });

  $(document).on("click", "#cancel-multiselect-button", function(){
    $(this).closest("li").remove();
    $(".nav.navbar-nav li").show();
    disableMultiselect();
  });

  var pressTimer, longPress

  function enableMultiselect() {
    $(".link-item").hide();
    $(".checkbox-item").css({display: "block"});
    $(".btn-multiselect").show();
    $(".nav.navbar-nav li").hide();
    $(".nav.navbar-nav.navbar-left").append("<li><a href='javascript:void(0)' id='cancel-multiselect-button'><i class='material-icons'>close</i></a></li>");
  }

  function disableMultiselect() {
    $(".link-item").show();
    $(".checkbox-item").css({display: "none"});
    $(".btn-multiselect").hide();
    longPress = false
  }

  $(document).on("mouseup", ".list-group.rabbits a", function(){
    console.log("mouseup")
    clearTimeout(pressTimer)
    return false;
  }).on("mousedown", ".list-group.rabbits a", function(){
    console.log("mousedown")
    var rabbitId = $(this).data("rabbitId")
    pressTimer = window.setTimeout(function() {
      console.log("longpress")
      enableMultiselect();
      longPress = true
      return false;
    },600)
  }).on("click", ".list-group.rabbits a", function(){
    console.log("click, longpress? " + longPress)
    return !longPress
  })

  $(document).on("click", ".enable_multiselect", function() {
    enableMultiselect()
  })
})
