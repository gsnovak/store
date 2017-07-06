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

app.controller 'ProductsController', ($scope, Product, OrderItem, Order, $window) ->
  cartPromise = Order.cart().$promise

  cartPromise.then (data) ->
    if data?
      $scope.order = new Order(data.order)
    else
      $scope.order = new Order()

    $scope.order.order_items.map (item) ->
      new OrderItem(item)

  Product.get().$promise.then (data) ->
      $scope.products = data.products


  $scope.addToCart = (item) ->
    cartPromise.then (data) ->
      return if _.findWhere($scope.order.order_items, {id: item.id })?
      ItemToSave = new OrderItem(source_id: item.id, quantity: 1000, source_type: "Product")
      ItemToSave.order_id = $scope.order.id
      ItemToSave.$save()

app.controller 'CheckoutController', ($scope, Product, Order, Address, CreditCard, OrderItem) ->

  Order.cart().$promise.then (data) ->
    if data?
      $scope.order = new Order(data.order)
    else
      $scope.order = new Order()

    $scope.order.order_items.map (item) ->
      new OrderItem(item)

  $scope.editCC = ->
    $scope.editingCC = true;

  $scope.editAddress = ->
    $scope.editingAddress = true;

  $scope.addressInit = (address) ->
    if address.id?
      $scope.address = new Address(address)
    else
      $scope.address = new Address()

  $scope.removeFromCart = (item) ->
    itemToDelete = new OrderItem(item)
    itemToDelete.$delete()

  $scope.ccInit = (cc) ->
    if cc.id?
      $scope.cc = new CreditCard(cc)
    else
      $scope.cc = new CreditCard()

  $scope.updateAddress =  ->
    return if $scope.savingAddress
    $scope.savingAddress = true

    if $scope.address.id?
      promise = $scope.address.$update()
    else
      promise = $scope.address.$save()

    promise
      .then ->
        delete $scope.addressErrors
      .catch (result) ->
        $scope.addressErrors = result.data.address
      .finally ->
        $scope.savingAddress = false
        $scope.editingAddress = false

  $scope.updateCC =  ->
    return if $scope.savingCC
    $scope.savingCC = true

    if $scope.cc.id?
      promise = $scope.cc.$update()
    else
      promise = $scope.cc.$save()

    promise
      .then ->
        delete $scope.ccErrors
      .catch (result) ->
        $scope.ccErrors = result.data.credit_cards
      .finally ->
        $scope.savingCC = false
        $scope.editingCC = false

  $scope.orderPlaced = ->
    $scope.order.state is "placed"

  $scope.completeOrder = ->
    return if $scope.savingOrder
    $scope.savingOrder = true
    $scope.order.state = 'placed'
    $scope.order.$save()
    .then ->
      delete $scope.orderErrors
    .catch (result) ->
      $scope.orderErrors = result.data.orders
    .finally ->
      $scope.savingOrder = false
      $scope.editingOrder = false
      $scope.orderCompleted = true




