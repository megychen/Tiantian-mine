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

  /* ****************************

    flash auto disappear

  ***************************** */

  $(".alert").fadeOut(2000);


  /* ****************************

    register & login email address check

  ***************************** */

  $(".registration").on("click", function() {
    if (!isValidEmailAddress()) {
      modalMessage("请输入有效的邮箱地址")
      return false
    }
  })

  $(".session").on("click", function() {
    if (!isValidEmailAddress()) {
      modalMessage("请输入有效的邮箱地址")
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

  /* ****************************

    modal message hint

  ***************************** */

  function modalMessage(msg) {
    $(".modal-content").text(msg)
    $('#message').modal()
    $('#message').modal('show')
  }


  /* ****************************

    carts & checkout page product quantity button action

  ***************************** */

  var indexNumber, totalQuantity, quantityObj, quantityObjValue;

  function sendQauntityChangeRequest (url, quantity) {
    $.ajax({
      url: url,
      data: { quantity: quantity },
      method: 'POST',
      dataType: 'json', // 要求服务器回传 json
      success: function (response) {
        if (response.success !== true) {
          alert(response.message)
        }
      }
    })
  }

  // Calculate carts total price
  function calculateCartsTotalPrice() {
    var sum = 0
    $('input[name="cart_item_id"]:checked').each(function () {
      var cartItemId= $(this).attr("id")
      var cartItemPrice = parseInt($("#price-" + cartItemId).text().split("￥")[1])
      var quantity = parseInt($("#cart-item-quantity-" + cartItemId).val())
      sum += cartItemPrice * quantity
    })
    $(".cart-item-total-price").text(sum)
  }

  // Calculate checkout total price
  function calculateCheckoutTotalPrice() {
    var sum = 0
    $(".checkout-list").each(function () {
      var flag = $(this).children().eq(0).attr("id")
      var quantity = parseInt($("#cart-item-quantity-" + flag).val())
      var price = parseInt($("#cart-item-product-price-" + flag).text())

      sum += quantity * price
    })

    $(".checkout-item-total-price").text(sum)
  }

  $(".sub-btn").on("click", function (e) {
    e.preventDefault()
    indexNumber = $(this).data("indexNumber")
    totalQuantity = $(document).find("#total-" + indexNumber).text()

    quantityObj = $("#cart-item-quantity"+ '-' + indexNumber)
    quantityObjValue = quantityObj.val()

    if (parseInt(quantityObjValue) > 1) {
      quantityObjValue = parseInt(quantityObjValue) - 1
      quantityObj.val(quantityObjValue)
      if (window.location.pathname === "/carts") {
        calculateCartsTotalPrice()
      } else {
        calculateCheckoutTotalPrice()
      }

      var url = $(this).attr("href");
      sendQauntityChangeRequest(url, quantityObjValue)
    }

  })

  $(".inc-btn").on("click", function (e) {
    e.preventDefault()
    indexNumber =  $(this).data("indexNumber")
    totalQuantity = parseInt($(document).find("#total-" +indexNumber).text())

    quantityObj = $("#cart-item-quantity"+ '-' + indexNumber)
    quantityObjValue = quantityObj.val()

    if (parseInt(quantityObjValue) <= totalQuantity - 1) {
      quantityObjValue = parseInt(quantityObjValue) + 1
      quantityObj.val(quantityObjValue)
      if (window.location.pathname === "/carts") {
        calculateCartsTotalPrice()
      } else {
        calculateCheckoutTotalPrice()
      }

      var url = $(this).attr("href");
      sendQauntityChangeRequest(url, quantityObjValue)
    } else {
      modalMessage("库存不足")
    }
  })

  $(".cart-list .quantity-value").each(function () {
    $(this).on("change", function () {
      indexNumber = $(this).next().data("indexNumber")
      totalQuantity = parseInt($(document).find("#" +indexNumber).text())
      quantityObjValue = parseInt($(this).val())

      if (window.location.pathname === "/carts") {
        calculateCartsTotalPrice()
      } else {
        calculateCheckoutTotalPrice()
      }

      var url = $(this).next().attr("href")

      if ( quantityObjValue < 1 ) {
        $(this).val("1")
        return
      } else if (quantityObjValue > totalQuantity) {
        $(this).val("1")
        modalMessage("库存不足")
        return
      } else {
        sendQauntityChangeRequest(url, quantityObjValue)
      }
    })
  })

  // 监听复选框的变化
  $('input[name="cart_item_id"]').each(function () {
    $(this).on("change", function(){
      calculateCartsTotalPrice()
    });
  })

  // 点击全选按钮
  $(".carts-checked-all").on("change", function() {
    if (this.checked) {
      $('input[name="cart_item_id"]').each(function () {
        $(this).prop("checked", true)
      })
    } else {
      $('input[name="cart_item_id"]').each(function () {
        $(this).prop("checked", false)
      })
    }
    calculateCartsTotalPrice()
  })

  // 确认结账
  $(".submit-checkout-btn").click(function (e) {
    e.preventDefault()

    var checkedItem = $('input[name="cart_item_id"]:checked')

    if (checkedItem.length === 0) {
      modalMessage("您还没有选中商品")
      return
    }

    var url = $(this).attr("href")
    var cartItemId = []
    checkedItem.each(function () {
      cartItemId.push($(this).attr("id"))
    })

    url = '/carts/checkout?cart_item_ids=' + cartItemId

    $(location).attr('href', url)
  })
})
