app = angular.module('customerApp')

app.factory('Product', ['$resource', ($resource) ->
  $resource '/api/v1/products/:id', { id: "@id" },
  'update': {
    method: 'PUT'
  }
])

app.factory('Order', ['$resource', ($resource) ->
  $resource '/api/v1/orders/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
    'cart': {
      method: 'GET'
    }
])

app.factory('OrderItem', ['$resource', ($resource) ->
  $resource '/api/v1/order_items/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
])

app.factory('CreditCard', ['$resource', ($resource) ->
  $resource '/api/v1/credit_cards/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
])

app.factory('Address', ['$resource', ($resource) ->
  $resource '/api/v1/address/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
])


app.controller 'ProductsController', ($scope, Product, OrderItem, Order) ->
  cartPromise = Order.cart().$promise

  cartPromise.then (data) ->
    if data?
      $scope.order = new Order(data.order)
    else
      $scope.order = new Order()

  Product.query().$promise.then (data) ->
    $scope.products = data

  cartPromise.then (data) ->
    $scope.add_to_cart = (item) ->
      console.log("Adding to cart....")

      item_to_save = new OrderItem(source_id: item.id, source_type: "Product")
      item_to_save.quantity += 1
      item_to_save.order_id = $scope.order.id
      item_to_save.$save()

app.controller 'CheckoutController', ($scope, Product, Order, Address, CreditCard, OrderItem) ->

  Product.query().$promise.then (data) ->
    $scope.products = data

  cartPromise = Order.cart().$promise

  cartPromise.then (data) ->
    if data?
      $scope.order = new Order(data.order)
    else
      $scope.order = new Order()

  $scope.address_init = (add) ->
    if add?
      $scope.addr = new Address(add)
    else
      $scope.addr = new Address()

  $scope.cc_init = (cc) ->
    if cc?
      $scope.credit_card = new CreditCard(cc)
    else
      $scope.credit_card = new CreditCard()

  $scope.update_address =  ->
    if $scope.addr.id?
      $scope.addr.$update()
    else
      $scope.addr.$save()

  $scope.update_cc =  ->
    if $scope.credit_card.id?
      $scope.credit_card.$update()
    else
      $scope.credit_card.$save()

  $scope.update_order =  ->
    if $scope.order.id?
      $scope.order.$update()
    else
      $scope.order.$save()

  cartPromise.then (data) ->
    $scope.is_placed = ->
      $scope.order.state == 'placed'

  $scope.complete_order = ->
    console.log "completing order"
    if $scope.addr.id?
      $scope.update_address()
    if $scope.credit_card.id?
      $scope.update_cc()

    if $scope.order.id?
      $scope.order.$update()
    else
      $scope.order.$save()