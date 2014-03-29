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
function authentications_opener(e){return window.open(e,"authentications","toolbar=no,location=yes,directories=yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=850,height=500,left=50,top=100"),!1}$(document).ready(function(){$(".a_demo_three").colorbox({inline:!0,width:"670px"}),$("#password-clear").show(),$("#password-password").hide(),$("#password-clear").focus(function(){$("#password-clear").hide(),$("#password-password").show(),$("#password-password").focus()}),$("#password-password").blur(function(){$("#password-password").val()==""&&($("#password-clear").show(),$("#password-password").hide())}),$("#password-clear1").show(),$("#password-password1").hide(),$("#password-clear1").focus(function(){$("#password-clear1").hide(),$("#password-password1").show(),$("#password-password1").focus()}),$("#password-password1").blur(function(){$("#password-password1").val()==""&&($("#password-clear1").show(),$("#password-password1").hide())})}),$(function(){$(".dropdown-toggle").dropdown(),$(".dropdown input, .dropdown label").click(function(e){e.stopPropagation()}),setTimeout(function(){$(".alert").slideUp()},5e3)}),$(window).bind("load",function(){function r(){e=n.height(),t=$(window).scrollTop()+$(window).height()-e+"px",$(document.body).height()+e<$(window).height()?n.css({position:"absolute",visibility:"visible"}):n.css({position:"static",visibility:"visible"})}var e=0,t=0,n=$("#footer");r(),$(window).scroll(r).resize(r)});