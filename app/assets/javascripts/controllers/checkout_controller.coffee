app = angular.module('customerApp')

app.controller 'CheckoutController',['$window', '$q', '$scope', 'Order', 'Address', 'CreditCard', 'OrderItem', 'Product', 'Coupon',($window, $q, $scope, Order, Address, CreditCard, OrderItem, Product, Coupon) ->
  $scope.editingCC = true
  $scope.editingAddress = true

  Order.cart().$promise.then (data) ->
    if data?
      $scope.order = new Order(data)
    else
      $scope.order = new Order()

    $scope.order.order_items.map (item) ->
      new OrderItem(item)

    $scope.completeOrder = ->
      return if $scope.savingOrder
      $scope.savingOrder = true

      promises = []
      if $scope.cc.id?
        promises.push $scope.cc.$update()
      else
        promises.push $scope.cc.$save()
      if $scope.address.id?
        promises.push $scope.address.$update()
      else
        promises.push $scope.address.$save()

      $q.all(promises)
        .then ->
          $scope.order.$update()
            .then ->
              $scope.order.state = 'placed'
              $scope.order.$changeState().then ->
                delete $scope.orderErrors
                $scope.orderCompleted = true
                $scope.coupon.$delete() if $scope.coupon
                $window.location.href = '/thank_you'
            .catch (result) ->
              $scope.orderErrors = result.data
            .finally ->
              $scope.savingOrder = false
        .catch (result) ->
          $scope.orderErrors = result.data
        .finally ->
          $scope.savingOrder = false

  $scope.editCC = ->
    $scope.editingCC = true

  $scope.editAddress = ->
    $scope.editingAddress = true

  $scope.addressInit = (address) ->
    $scope.address = new Address(address)
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
        $scope.address = data
        $scope.address.state_id = data.state_id.toString() if data.state_id?
        $scope.editingAddress = false
        $scope.addressReady = true
      .catch (result) ->
        $scope.addressErrors = result.data
      .finally ->
        $scope.savingAddress = false

   $scope.applyCoupon = (couponCode) ->
    return if $scope.grabbingCoupon
    $scope.grabbingCoupon = true
    Coupon.query(code: couponCode).$promise
      .then (data) ->
        coupon = new Coupon(data)
        itemToSave = new OrderItem(quantity: 1, source_type: "Coupon", source_id: coupon.id, order_id: $scope.cartOrder.id )
        itemToSave.$save().then (item) ->
          $scope.cartOrder.order_items.push(item)
        .catch (result) ->
          $scope.couponErrors = result.data
      .catch (result) ->
        $scope.couponErrors = result.data
      .finally ->
        $scope.grabbingCoupon = false

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
        $scope.cc = data
        $scope.display_number = "XXXX-XXXX-XXXX-" + $scope.cc.last_four
        $scope.editingCC = false
        $scope.ccReady = true
      .catch (result) ->
        $scope.ccErrors = result.data
      .finally ->
        $scope.savingCC = false
]
