// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= bootstrap-filestyle.min
//= require_tree . 

$(document).ready(function () {
  $(".a_demo_three").colorbox({
    inline: true,
    width: "670px"
  });

  $('#password-clear').show();
  $('#password-password').hide();

  $('#password-clear').focus(function () {
    $('#password-clear').hide();
    $('#password-password').show();
    $('#password-password').focus();
  });
  $('#password-password').blur(function () {
    if ($('#password-password').val() == '') {
      $('#password-clear').show();
      $('#password-password').hide();
    }
  });

  $('#password-clear1').show();
  $('#password-password1').hide();

  $('#password-clear1').focus(function () {
    $('#password-clear1').hide();
    $('#password-password1').show();
    $('#password-password1').focus();
  });
  $('#password-password1').blur(function () {
    if ($('#password-password1').val() == '') {
      $('#password-clear1').show();
      $('#password-password1').hide();
    }
  });

});

function authentications_opener(url) {
  window.open(url, 'authentications', 'toolbar=no,location=yes,directories=yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=850,height=500,left=50,top=100');
  return false;
}

$(function () {
  $('.dropdown-toggle').dropdown();

  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function (e) {
    e.stopPropagation();
  });

  setTimeout(function () {
    $(".alert").slideUp()
  }, 5000);

});

// Window load event used just in case window height is dependant upon images
$(window).bind("load", function () {

  var footerHeight = 0,
    footerTop = 0,
    $footer = $("#footer");

  positionFooter();

  function positionFooter() {

    footerHeight = $footer.height();
    footerTop = ($(window).scrollTop() + $(window).height() - footerHeight) + "px";

    if (($(document.body).height() + footerHeight) < $(window).height()) {
      $footer.css({
        position: "absolute",
        visibility: "visible"
      })
    } else {
      $footer.css({
        position: "static",
        visibility: "visible"
      })
    }

  }

  $(window)
    .scroll(positionFooter)
    .resize(positionFooter)

});
