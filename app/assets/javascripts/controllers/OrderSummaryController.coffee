app = angular.module('customerApp')

app.controller 'OrderSummaryController',['$scope', 'Order', ($scope, Order) ->
  Order.getPlaced().$promise.then (data) ->
    $scope.ord = data

    $scope.amount = ->
      total = 0
      angular.forEach($scope.ord.order_items, (item) ->
        total += (item.source.price * item.quantity))
      total
  $scope.addressInit = (address) ->
    $scope.address = address

  $scope.ccInit = (cc) ->
    $scope.cc = cc

]
