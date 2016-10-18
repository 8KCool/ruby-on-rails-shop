var products = {};
var deleteCount = 0;

var uniqCount = 0 + parseInt(deleteCount);
var itemCount = 0;
var tprice = 0;

if (localStorage['products'] !== undefined) {
  products = JSON.parse(localStorage['products']);

  for (key in products) {
      uniqCount += 1;
      itemCount += products[key]['count'];
      tprice += products[key]['count'] * products[key]['price'];
  }

  // if (itemCount < 1000) {
  //   $('.circle').html(itemCount).css('display', 'block');
  // } else {
  //   $('.circle').html('∞').css('display', 'block');
  // }

  $('.circle').html(itemCount).css('display', 'block');
  $('.tpricespan').text("$" + tprice.toFixed(2));
}

if (localStorage['dcount'] !== undefined) {
  deleteCount += localStorage['dcount'];
} else {
  localStorage.setItem('dcount', '0');
}

uniqCount += deleteCount;

function initAddButton() {
  $('.prodbutton').click(function (){
    var $this = $(this);
    var finder = false;
    var prodId = $this.parents('.productcard').data("id");
    var prodName = $this.parents('.productcard').data("name");
    var prodPrice = parseFloat($this.parents('.productcard').data("price"));

    for (key in products) {
      if (prodName === products[key]['name']) {
        products[key]['count'] += 1;
        tprice += products[key]['price'];
        localStorage['products'] = JSON.stringify(products);
        finder = true;
        itemCount ++;
      }
    }

    if (finder === false) {

      uniqCount ++;
      itemCount ++;

      var newProdName = "product" + uniqCount;

      products[newProdName] = {};

      products[newProdName]['id'] = prodId;
      products[newProdName]['name'] = prodName;
      products[newProdName]['price'] = prodPrice;
      products[newProdName]['count'] = 1;

      tprice += prodPrice;
      localStorage['products'] = JSON.stringify(products);
    }

    $('.circle').html(itemCount).css('display', 'block');
    $('.tpricespan').html("$" + (tprice).toFixed(2));
  });
}

initAddButton();

function isNormalInteger(str) {
    return /^[1-9]\d*$/.test(str);
}

function isNegativeNumber(str) {
    return /^-\d*\.?\d+$/.test(str);
}

function isZeroOrEmpty(str) {
    return /^0?$/.test(str);
}

function initProdEvents() {
  $('.prodinp').change(function (){
    if (isNormalInteger($(this).val()) === false) {
      $(this).val(parseInt($(this).val()));

      if (isZeroOrEmpty($(this).val()) === true) {
        $(this).val(1);
      }

      if (isNegativeNumber($(this).val()) === true) {
        $(this).val($(this).val() * (-1));
      }
    }

    if ( $(this).val().length > 3 ) {
      $(this).val(parseInt($(this).val().slice(0, 3)));
    }

    var productId = $(this).parents('.prodbox').data('id');
    var oldPrice = 0;
    var oldCount = 0;
    var productPrice = parseFloat($(this).parents('.prodbox').data('price'));
    var newPrice = 0;
    var newCount = 0;

    for (key in products) {
      if (productId === products[key]['id']) {
        oldPrice = parseInt(products[key]['count']) * productPrice;
        oldCount = parseInt(products[key]['count']);
        products[key]['count'] = parseInt($(this).val());
        newPrice = parseInt(products[key]['count']) * productPrice;
        newCount = parseInt(products[key]['count']);
        localStorage['products'] = JSON.stringify(products);
      }
    }

    $('.cartbox').data('totalprice', (parseFloat($('.cartbox').data('totalprice')) - oldPrice + newPrice).toFixed(2));
    $('.subtot .right').text("$" + $('.cartbox').data('totalprice'));
    $('.tright').text("$" + $('.cartbox').data('totalprice'));

    $('.circle').text(parseInt($('.circle').text()) - oldCount + newCount);
    $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

    var price = parseFloat($(this).parents('.prodbox').data('price'));
    $(this).parents('.prodbox-func').find('.totalprice').text("$" + (price * $(this).val()).toFixed(2));
  });

  $('.plusblock').click(function (){
    var counter = parseInt($(this).parent('.countblock').find('.prodinp').val());
    var price = parseFloat($(this).parents('.prodbox').data('price'));
    counter += 1;

    var productId = $(this).parents('.prodbox').data('id');

    for (key in products) {
      if (productId === products[key]['id']) {
        products[key]['count'] += 1;
        localStorage['products'] = JSON.stringify(products);
      }
    }

    $('.cartbox').data('totalprice', (parseFloat($('.cartbox').data('totalprice')) + price).toFixed(2));
    $('.subtot .right').text("$" + $('.cartbox').data('totalprice'));
    $('.tright').text("$" + $('.cartbox').data('totalprice'));

    $('.circle').text(parseInt($('.circle').text()) + 1);
    $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

    $(this).parent('.countblock').find('.prodinp').val(counter);
    $(this).parents('.prodbox-func').find('.totalprice').text("$" + (price * counter).toFixed(2));
  });

  $('.deleter').click(function (){
    $(this).parents('.prodbox').remove();

    var productId = $(this).parents('.prodbox').data('id');
    var productCount = 0;
    var productPrice = parseFloat($(this).parents('.prodbox').data('price'));
    var minus = 0;

    for (key in products) {
      if (productId === products[key]['id']) {
          productCount = parseInt(products[key]['count']);
          minus = productCount * productPrice;
          delete products[key];
          deleteCount++;
          localStorage['dcount'] = deleteCount;
          localStorage['products'] = JSON.stringify(products);
      }
    }

    $('.cartbox').data('totalprice', (parseFloat($('.cartbox').data('totalprice')) - minus).toFixed(2));
    $('.subtot .right').text("$" + $('.cartbox').data('totalprice'));
    $('.tright').text("$" + $('.cartbox').data('totalprice'));

    $('.circle').text($('.circle').text() - productCount);
    $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

    if ($(".prodbox").length == 0) {
      $(".pcontent").replaceWith('<div class="pcontent holder clearfix"><div class="cartbox">' +
        '</div><div class="allprods"><div class="prodbox"><div class="prodbox-desc">your cart is empty</div></div></div></div>');
      $('.circle').css('display', 'none');
      $('.tpricespan').text("empty");
      localStorage.clear();
    }
  });

  $('.cartbutton').click(function (){
    localStorage.clear();
    $(".pcontent").replaceWith('<div class="pcontent holder clearfix"><div class="cartbox">' +
        '</div><div class="allprods"><div class="prodbox"><div class="prodbox-desc">your cart is empty</div></div></div></div>');
    $('.circle').css('display', 'none');
    $('.tpricespan').text("empty");
  });
}

$(document).ready(function() {

  function replaceLoadmore(evnt, data, status, xhr) {
    $(".loadmore").replaceWith(data);
    initAddButton();
    listerLoadmore();
  }

  function listerLoadmore() {
    $(".loadmore a").on('ajax:success', replaceLoadmore);
  }

  listerLoadmore();

});

$(document).ready(function() {
  if ($('.cartbox').length !== 0) {
    var products = {};
    var idCount = {};
    var uniqCount = 0;

    if (localStorage['products'] !== undefined) {
      products = JSON.parse(localStorage['products']);

      for (key in products) {
          uniqCount += 1;
          var prodName = "product" + uniqCount;
          idCount[prodName] = {};
          idCount[prodName]['id'] = products[key]['id'];
          idCount[prodName]['count'] = products[key]['count'];
      }

      $.ajax({
        url: '/cart',
        type: 'post',
        data: { 'idCount': idCount },
        success: function(data, status, xhr){
          $(".pcontent").replaceWith(data);
          initProdEvents();
        },
        error: function(xhr, status, error){
          console.log(xhr);
          alert(error);
        }
      });
    }
  }
});