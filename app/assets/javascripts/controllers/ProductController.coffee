app = angular.module('customerApp')

app.controller 'ProductsController', ['$scope', 'Product', 'OrderItem', 'Order', '$window', ($scope, Product, OrderItem, Order, $window) ->
  Product.query().$promise
    .then (data) ->
      console.log data
      $scope.products = data
]
