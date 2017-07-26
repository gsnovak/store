app = angular.module('customerApp')

app.controller 'ProductController',['$scope', ($scope) ->
  $scope.range = [0..($scope.product.on_hand_count)]
]
