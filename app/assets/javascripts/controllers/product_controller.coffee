app = angular.module('customerApp')

app.controller 'ProductController',['$scope', 'OrderItem', ($scope, OrderItem) ->
  $scope.range = [1..($scope.product.on_hand_count)]
]
