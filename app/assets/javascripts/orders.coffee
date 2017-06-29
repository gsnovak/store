app = angular.module('customerApp')

app.factory('Product', ['$resource', ($resource) ->
  $resource '/api/v1/products/:id', { id: "@id" },
  'update': {
    method: 'PUT',
    is_array: true
  }
])

app.factory('Order', ['$resource', ($resource) ->
  $resource '/api/v1/orders/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
    'cart': {
      method: 'GET',
      is_array: false,
      url: '/api/v1/orders/cart'
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

  Product.get().$promise.then (data) ->
    $scope.products = data.products

  $scope.add_to_cart = (item) ->
    cartPromise.then (data) ->
      ItemToSave = new OrderItem(source_id: item.id, source_type: "Product")
      ItemToSave.quantity += 1
      ItemToSave.order_id = $scope.order.id
      ItemToSave.$save()

app.controller 'CheckoutController', ($scope, Product, Order, Address, CreditCard, OrderItem) ->

  cartPromise = Order.cart().$promise

  cartPromise.then (data) ->
    if data?
      $scope.order = new Order(data.order)
    else
      $scope.order = new Order()
    $scope.order.order_items.map (item) ->
      new OrderItem(item)

    $scope.isPlaced = ->
      $scope.order.state == 'placed'

  $scope.addressInit = (address) ->
    if address.id?
      $scope.address = new Address(address)
    else
      $scope.address = new Address()

  $scope.ccInit = (cc) ->
    if cc.id?
      $scope.cc = new CreditCard(cc)
    else
      $scope.cc = new CreditCard()

  $scope.updateAddress =  ->
    if $scope.address.id?
      $scope.address.$update()
    else
      $scope.addr.$save()

  $scope.updateCC =  ->
    if $scope.cc.id?
      $scope.cc.$update()
    else
      $scope.cc.$save()


  $scope.completeOrder = ->
    $scope.order.state = 'placed'
    if $scope.order.id?
      $scope.order.$update()
    else
      $scope.order.$save()




