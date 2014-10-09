# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.carousel').carousel()

app = angular.module 'app', ['truncate']

$(document).on 'ready page:load', ->
  angular.bootstrap document, ['app']


app.controller 'HomeCtrl', ['$scope', '$http', ($scope, $http) ->
  $http.get('/series.json').success (data) ->
    $scope.series = data
]