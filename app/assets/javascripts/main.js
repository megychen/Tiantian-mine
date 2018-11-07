$(document).on('turbolinks:load', function () {
  var totalQuantity = <%= @product.quantity %>
  var quantityObj = $("#quantity-val")
  var quantityObjValue = quantityObj.val()

  $("#sub-btn").on("click", function () {
    if (quantityObjValue > 1) {
      quantityObjValue = parseInt(quantityObjValue) - 1
      $("#quantity-val").val(quantityObjValue)
    }
  })

  $("#inc-btn").on("click", function () {
    if (quantityObjValue < totalQuantity) {
      quantityObjValue = parseInt(quantityObjValue) + 1
      $("#quantity-val").val(quantityObjValue)
    }
  })

  $(document).on("click", "#add-to-cart-btn", function(evt){
    evt.preventDefault();
    var url = $(this).attr("href");

    // 加入购物车
    $.ajax({
      url: url,
      data: { quantity: quantityObj.val() },
      method: 'POST',
      dataType: 'json', // 要求服务器回传 json
      success: function (response) {
        if (response.success === true) {
          $(".result").html("成功加入购物车")
          var cartVal = <%= current_cart.products.count %>
          $("#product-cart").html(cartVal)
        }
      }
    })
  })

  // 现在购买
  $("#instance-buy-btn").click(function(evt){
    evt.preventDefault();
    var url = $(this).attr("href");

    // 送出 Ajax
    $.ajax({
      url: url,
      data: { quantity: quantityObj.val() },
      method: 'POST',
      dataType: 'json', // 要求服务器回传 json
      success: function (response) {
        if (response.success === true) {
          $(location).attr('href', '/carts')
        }
      }
    })
  })
})
