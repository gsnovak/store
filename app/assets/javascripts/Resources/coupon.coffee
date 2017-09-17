app = angular.module('customerApp')

app.factory('Coupon', ['$resource', ($resource) ->
  $resource '/api/v1/coupons/:id', { id: "@id" },
  'update': {
    method: 'PUT',
    is_array: true
  },
  'query': {
      method: 'GET',
      is_array: false
    }
])
