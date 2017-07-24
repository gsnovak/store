app = angular.module('customerApp')

app.controller 'CheckoutController',['$window', '$q', '$scope', 'Product', 'Order', 'Address', 'CreditCard', 'OrderItem', ($window, $q, $scope, Product, Order, Address, CreditCard, OrderItem) ->

  Order.cart().$promise.then (data) ->
    if data?
      $scope.ord = new Order(data)
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
    $scope.ccReady = false

  $scope.editAddress = ->
    $scope.editingAddress = true
    $scope.addressReady = false

  $scope.addressInit = (address) ->
    $scope.address = new Address(address)
    $scope.address.state_id = address.state_id.toString() if address.state_id?

  $scope.orderInit = (order) ->
    $scope.order = new Address(address)
    $scope.address.state_id = address.state_id.toString() if address.state_id?

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
        $scope.addressReady = true
        $scope.address = data
        $scope.address.state_id = data.state_id.toString() if data.state_id?
      .catch (result) ->
        $scope.addressErrors = result.data
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
        $scope.ccReady = true
        $scope.cc = data
      .catch (result) ->
        $scope.ccErrors = result.data
      .finally ->
        $scope.savingCC = false
        $scope.editingCC = false

  $scope.canPlace = ->
    $scope.savingOrder && $scope.addressReady && $scope.ccReady && !$scope.editingCC && !$scope.editingAddress

  $scope.completeOrder = ->
    return if $scope.savingOrder
    $scope.savingOrder = true
    console.log "here"

    promises = []
    if $scope.cc.id?
      promises.push $scope.cc.$update()
    if $scope.address.id?
      promises.push $scope.address.$update()

    $q.all(promises)
      .then ->
        $scope.ord.state = 'placed'
        $scope.ord.$update()
          .then ->
            delete $scope.orderErrors
            $scope.orderCompleted = true
            $window.location.href = '/thank_you'
          .catch (result) ->
            $scope.orderErrors = result.data
          .finally ->
            $scope.savingOrder = false
      .catch (result) ->
        $scope.orderErrors = result.data
      .finally ->
        $scope.savingOrder = false
]
