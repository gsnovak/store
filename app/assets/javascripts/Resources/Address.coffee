app = angular.module('customerApp')

app.factory('Address', ['$resource', ($resource) ->
  $resource '/api/v1/addresses/:id', { id: "@id" },
    'update': {
      method: 'PUT'
    }
])
