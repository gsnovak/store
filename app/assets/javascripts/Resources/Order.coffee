app = angular.module('customerApp')

app.factory('Order', ['$resource', ($resource) ->
  $resource '/api/v1/orders/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    },
    'cart': {
      method: 'GET',
      is_array: false,
      url: '/api/v1/orders/cart'
    },
    'query': {
      method: 'GET',
      is_array: false
    },
    'changeState': {
      method: 'PUT',
      url: '/api/v1/orders/:id/change_state'
    }
])