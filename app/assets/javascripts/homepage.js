var products = {},
    deleteCount = 0,
    uniqCount = 0,
    itemCount = 0,
    tprice = 0;

function initStorage() {
  products = JSON.parse(localStorage['products']);

  for (key in products) {
    uniqCount += 1;
    itemCount += products[key]['count'];
    tprice += products[key]['count'] * products[key]['price'];
  }

  $('.circle').data('count', itemCount).css('display', 'block');

  if (parseInt($('.circle').data('count')) < 1000) {
    $('.circle').text($('.circle').data('count'));
  } else {
    $('.circle').text('∞').css('display', 'block');
  }

  $('.tpricespan').text("$" + tprice.toFixed(2));
}

function PopUpShow() {
  $('.popup').each(function(){
    $(this).data('count', parseInt($(this).data('count')) + 1);
    var count = parseInt($(this).data('count'));
    $(this).css('transform','translate(0,' + (-240*count) + 'px)');
   });
  $('.pcontent').append('<div class="popup" data-count="0">Product successfully added in cart!</div>');
  $('.popup').last().addClass('appear');
  setTimeout(function(){ $('.popup').last().addClass('visappear'); }, 20);
  return $('.popup').last();
}

function PopUpHide($popup) {
  $popup.css('transform','translate(-720px,' + (-240*parseInt($popup.data('count'))) + 'px)');
  $popup.removeClass('visappear');
  setTimeout(function(){
    $popup.removeClass('appear');
    $popup.remove(); }, 400);
}

function initAddButton() {
  $('.prodbutton').click(function (){
    var $this = $(this);
    var finder = false;
    var prodId = $this.parents('.productcard').data("id");
    var prodName = $this.parents('.productcard').data("name");
    var prodPrice = parseFloat($this.parents('.productcard').data("price"));

    for (key in products) {
      if (prodName === products[key]['name']) {
        if (parseInt(products[key]['count']) < 999){
          products[key]['count'] += 1;
          tprice += products[key]['price'];
          localStorage['products'] = JSON.stringify(products);
          itemCount ++;

          var $popup = PopUpShow();
          setTimeout(function(){ PopUpHide($popup); }, 2000);
        }

        finder = true;
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
      var $popup = PopUpShow();
      setTimeout(function(){ PopUpHide($popup); }, 2000);
    }

    $('.circle').data('count', itemCount).css('display', 'block');

    if (parseInt($('.circle').data('count')) < 1000) {
      $('.circle').text($('.circle').data('count')).css('display', 'block');
    } else {
      $('.circle').text('∞').css('display', 'block');
    }

    $('.tpricespan').html("$" + (tprice).toFixed(2));

  });
}

function replaceLoadmore(evnt, data, status, xhr) {
  $(".loadmore").replaceWith(data);
  $('.prodbutton').unbind('click');
  initAddButton();
  listerLoadmore();
}

function listerLoadmore() {
  $(".loadmore a").on('ajax:success', replaceLoadmore);
}

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
  $('.prodinp').on("change", function (){
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

    $('.circle').data('count', parseInt($('.circle').data('count')) - oldCount + newCount).css('display', 'block');

    if (parseInt($('.circle').data('count')) < 1000) {
      $('.circle').text($('.circle').data('count'));
    } else {
      $('.circle').text('∞');
    }

    $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

    var price = parseFloat($(this).parents('.prodbox').data('price'));
    $(this).parents('.prodbox-func').find('.totalprice').text("$" + (price * $(this).val()).toFixed(2).replace('.', ','));
  });

  $('.plusblock').click(function (){
    var counter = parseInt($(this).parent('.countblock').find('.prodinp').val());
    var price = parseFloat($(this).parents('.prodbox').data('price'));
    counter += 1;

    var productId = $(this).parents('.prodbox').data('id');

    for (key in products) {
      if (productId === products[key]['id']) {
        if (parseInt(products[key]['count']) < 999) {
          products[key]['count'] += 1;
          localStorage['products'] = JSON.stringify(products);

          $('.cartbox').data('totalprice', (parseFloat($('.cartbox').data('totalprice')) + price).toFixed(2));
          $('.subtot .right').text("$" + $('.cartbox').data('totalprice'));
          $('.tright').text("$" + $('.cartbox').data('totalprice'));

          $('.circle').data('count', parseInt($('.circle').data('count')) + 1).css('display', 'block');

          if (parseInt($('.circle').data('count')) < 1000) {
            $('.circle').text($('.circle').data('count'));
          } else {
            $('.circle').text('∞');
          }

          $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

          $(this).parent('.countblock').find('.prodinp').val(counter);
          $(this).parents('.prodbox-func').find('.totalprice').text("$" + (price * counter).toFixed(2).replace('.', ','));
        }
      }
    }
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

    $('.circle').data('count', parseInt($('.circle').data('count')) - productCount).css('display', 'block');

    if (parseInt($('.circle').data('count')) < 1000) {
      $('.circle').text($('.circle').data('count'));
    } else {
      $('.circle').text('∞');
    }

    $('.tpricespan').text("$" + $('.cartbox').data('totalprice'));

    if ($(".prodbox").length == 0) {
      $(".pcontent").replaceWith('<div class="pcontent holder clearfix"><div class="cartbox">' +
        '</div><div class="allprods"><div class="prodbox"><div class="prodbox-desc">your cart is empty</div></div></div></div>');
      $('.circle').css('display', 'none');
      $('.tpricespan').text("empty");
      localStorage.clear();
    }
  });

  $('.cartbutton').click(function () {
    var idCount = {};
    var uniqCount = 0;

    for (key in products) {
          uniqCount += 1;
          var prodName = "product" + uniqCount;
          idCount[prodName] = {};
          idCount[prodName]['id'] = products[key]['id'];
          idCount[prodName]['count'] = products[key]['count'];
      }

      $.ajax({
        url: '/makeorder',
        type: 'post',
        data: { 'idCount': idCount },
        success: function(data, status, xhr) {
          localStorage.clear();
          $(".pcontent").replaceWith('<div class="pcontent holder clearfix"><div class="cartbox">' +
          '</div><div class="allprods"><div class="prodbox"><div class="prodbox-desc">' +
          'your order is accepted, thank you</div></div></div></div>');
          $('.circle').css('display', 'none');
          $('.tpricespan').text("empty");
        },
        error: function(xhr, status, error) {
          alert(error);
        }
      });

  });
}

function loadCart () {
  var idCount = {};
  var counter = 0;
  if (localStorage['products'] !== undefined && localStorage['products'] !== "{}") {
    products = JSON.parse(localStorage['products']);

    for (key in products) {
      counter += 1;
      var prodName = "product" + counter;
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

        var fineid = []
        $('.prodbox').each(function(){
          if ($(this).data('id')){
            fineid.push($(this).data('id'));
          }
        });

        var i, founder;

        for (key in products) {

          founder = false;

          for (i = 0; i < fineid.length; i++) {
            if (products[key]['id'] === fineid[i]) {
              founder = true;
              break;
            }
          }

          if (founder === false) {
            delete products[key];
            deleteCount++;
            localStorage['dcount'] = deleteCount;
            localStorage['products'] = JSON.stringify(products);
          }
        }

        uniqCount = 0;
        itemCount = 0;
        tprice = 0;

        initStorage();
        initProdEvents();

        if ($('.prodbox').data('id') === undefined) {
          $('.circle').css('display', 'none');
          $('.tpricespan').text("empty");
          localStorage.clear();
        }
      },
      error: function(xhr, status, error){
        alert(error);
      }
    });
  }
}

$(document).ready(function() {

  // Для всех страниц

  if (localStorage['products'] !== undefined && localStorage['products'] !== "{}") {
    initStorage();
  }

  if (localStorage['dcount'] !== undefined) {
    deleteCount += parseInt(localStorage['dcount']);
    uniqCount += deleteCount;
  } else {
    localStorage.setItem('dcount', '0');
  }

  // Для главной

  if ($('.fixedblocks').length !== 0) {
    initAddButton();
    listerLoadmore();
  }

  // Для корзины

  if ($('.cartbox').length !== 0) {
    loadCart();
  }
});