app = angular.module('customerApp')

app.controller 'BaseController', ['$scope', 'Order', 'OrderItem', '$window', ($scope, Order, OrderItem, $window) ->
  Order.cart().$promise.then (data) ->
    if data?
      $scope.order = new Order(data)
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
          $scope.order.order_items.push(orderItem) unless existingItem
          $scope.saveSuccess = true
        .catch (result) ->
          $scope.productErrors = result.order_items
        .finally ->
          $scope.addingToCart = false

    $scope.removeFromCart = (item, index) ->
      $scope.order.order_items.splice(index, 1)

      itemToDelete = new OrderItem(item)
      itemToDelete.$delete()

    $scope.cartCount = ->
      total = 0
      angular.forEach($scope.order.order_items, (item) ->
        total += item.quantity)
      total
]
