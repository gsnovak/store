app = angular.module('customerApp')

app.controller 'BaseController', ['$scope', 'Order', 'OrderItem', '$window', 'Product', ($scope, Order, OrderItem, $window, Product) ->
  Order.cart().$promise.then (data) ->
    if data?
      $scope.cartOrder = new Order(data)
    else
      $scope.cartOrder = new Order()

    $scope.addToCart = (item) ->
      return if $scope.addingToCart
      $scope.addingToCart = true

      existingItem = _.findWhere($scope.cartOrder.order_items, { source_type: 'Product', source_id: item.id })
      if existingItem?
        existingItem.quantity = item.quantity
        itemToSave = new OrderItem(existingItem)
        promise = itemToSave.$update()
      else
        itemToSave = new OrderItem(source_id: item.id, quantity: item.quantity, source_type: "Product", order_id: $scope.cartOrder.id )
        promise = itemToSave.$save()

      promise
        .then (orderItem) ->
          $scope.cartOrder.order_items.push(orderItem) unless existingItem
          $scope.saveSuccess = true
        .catch (result) ->
          $scope.productErrors = result.order_items
        .finally ->
          $scope.addingToCart = false

    $scope.removeFromCart = (item, index) ->
      $scope.cartOrder.order_items.splice(index, 1)

      itemToDelete = new OrderItem(item)
      itemToDelete.$delete()

    $scope.total = ->
      total = _.reduce $scope.cartOrder.order_items, (runningSum, orderItem) ->
        runningSum + orderItem.quantity*orderItem.source.price
      , 0.00
      total

    $scope.cartCount = ->
      count = _.reduce $scope.cartOrder.order_items, (runningSum, orderItem) ->
        runningSum + orderItem.quantity
      , 0
      count

  Product.query().$promise
    .then (data) ->
      $scope.products = data
]
