var products = {};
var uniqCount = 0;
var itemCount = 0;
var tprice = 0;

if (localStorage.length == 0) {
  localStorage['products'] = JSON.stringify(products);
}

else {
  products = JSON.parse(localStorage['products']);

  for (key in products) {
    uniqCount += 1;
    itemCount += products[key]['count'];
    tprice += products[key]['count'] * products[key]['price'];
  }

  $('.circle').html(itemCount).css('display', 'block');
  $('.tpricespan').html("$" + tprice + ".00");
}

$('.prodbutton').click(function (){
  var $this = $(this);
  var finder = false;
  var prodName = $this.parents('.productcard').find('.name').text();
  var prodPrice = parseInt($this.parents('.productcard').find('.price').text().slice(1, -3));

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

    products[newProdName]['name'] = prodName;
    products[newProdName]['price'] = prodPrice;
    products[newProdName]['count'] = 1;

    tprice += prodPrice;
    localStorage['products'] = JSON.stringify(products);
  }

  $('.circle').html(itemCount).css('display', 'block');
  $('.tpricespan').html("$" + tprice + ".00");
});

if ($('.plusblock').length) {
  $('.plusblock').click(function (){
    var counter = parseInt($(this).parent('.countblock').find('.counter').text());
    var price = parseInt($(this).parents('.prodbox-func').find('.oneprice').text().slice(1, -3));
    counter += 1;
    $(this).parents('.prodbox-func').find('.totalprice').text("$" + price * counter + ",00")
    $(this).parent('.countblock').find('.counter').text(counter);
  });
}
