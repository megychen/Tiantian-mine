// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require activestorage
//= require 'china_city/jquery.china_city'
//= require_tree .

$(document).on('turbolinks:load', function () {
  $(".alert").fadeOut(2000);

  $(".registration").on("click", function() {
    if (!isValidEmailAddress()) {
      modalMessage()
      return false
    }
  })

  $(".session").on("click", function() {
    if (!isValidEmailAddress()) {
      modalMessage()
      return false
    }
  })

  function isValidEmailAddress() {
    var $email = $('form input[name="user[email]');
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/i;
    console.log($email.val(), $email.val() == '', re.test($email.val()))
    if ($email.val() == '' || !re.test($email.val())) {
      return false;
    }
    return true
  }

  function modalMessage() {
    $(".modal-content").text("请输入有效的邮箱地址")
    $('#message').modal()
    $('#message').modal('show')
  }
})
