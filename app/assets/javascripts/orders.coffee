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
  $resource '/api/v1/addresses/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
])

app.controller 'BaseController', ['$scope', 'Order', 'OrderItem', '$window', ($scope, Order, OrderItem, $window) ->
  Order.cart().$promise.then (data) ->
      if data?
        $scope.order = new Order(data.order)
      else
        $scope.order = new Order()

  $scope.addToCart = (item) ->
      return if $scope.addingToCart
      $scope.addingToCart = true

      existingItem = _.findWhere($scope.order.order_items, { source_id: item.id })
      if existingItem?
        existingItem.quantity = item.quantity
        itemToSave = new OrderItem(existingItem)
        promise = itemToSave.$update()
      else
        itemToSave = new OrderItem(source_id: item.id, quantity: item.quantity, source_type: "Product")
        itemToSave.order_id = $scope.order.id
        promise = itemToSave.$save()

      promise
        .then (orderItem) ->
          $scope.order.order_items.push(orderItem.order_item) unless existingItem
          $scope.saveSuccess = true
        .catch (result) ->
          $scope.productErrors = result.order_items
        .finally ->
          $scope.addingToCart = false

   $scope.removeFromCart = (item, index) ->
    $scope.order.order_items.splice(index, 1)

    itemToDelete = new OrderItem(item)
    itemToDelete.$delete()
]

app.controller 'ProductsController', ['$scope', 'Product', 'OrderItem', 'Order', '$window', ($scope, Product, OrderItem, Order, $window) ->

  Product.get().$promise.then (data) ->
      $scope.products = data.products
]

app.controller 'CheckoutController',['$q', '$scope', 'Product', 'Order', 'Address', 'CreditCard', 'OrderItem', ($q, $scope, Product, Order, Address, CreditCard, OrderItem) ->

  Order.cart().$promise.then (data) ->
    if data?
      $scope.ord = new Order(data.order)
    else
      $scope.ord = new Order()

    $scope.ord.order_items.map (item) ->
      new OrderItem(item)

    $scope.total = ->
      total = 0
      angular.forEach($scope.ord.order_items, (item) ->
        total += (item.source.price * item.quantity))
      total

  $scope.editCC = ->
    $scope.editingCC = true

  $scope.editAddress = ->
    $scope.editingAddress = true

  $scope.addressInit = (address) ->
    address.state_id = address.state_id.toString() if address.state_id?
    $scope.address = new Address(address)

  $scope.ccInit = (cc) ->
    $scope.cc = new CreditCard(cc)

  $scope.updateAddress =  ->
    return if $scope.savingAddress
    $scope.savingAddress = true

    if $scope.address.id?
      promise = $scope.address.$update()
    else
      promise = $scope.address.$save()

    promise
      .then (data) ->
        delete $scope.addressErrors
        $scope.addressInit(data.address)
      .catch (result) ->
        $scope.addressErrors = result.data.addresses
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
      .then (data) ->
        delete $scope.ccErrors
        $scope.ccInit(data.credit_card)
      .catch (result) ->
        $scope.ccErrors = result.data.credit_cards
      .finally ->
        $scope.savingCC = false
        $scope.editingCC = false

  $scope.completeOrder = ->
    return if $scope.savingOrder
    $scope.savingOrder = true

    promises = []
    if !$scope.cc.id?
      promises.push $scope.updateCC()
    if !$scope.address.id?
      promises.push $scope.updateAddress()

    $q.all(promises)
      .then ->
        $scope.ord.state = 'placed'
        $scope.ord.$update()
        .then ->
          delete $scope.orderErrors
          $scope.orderCompleted = true
        .catch (result) ->
          $scope.orderErrors = result.data.orders
        .finally ->
          $scope.savingOrder = false
]