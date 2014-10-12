# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.carousel').carousel()

$(document).on 'ready page:load', ->
    angular.bootstrap document, ['app']

HomeCtrl = ($scope, SeriesService) ->
    SeriesService.list().then (series) ->
        $scope.series = series

SeriesService = ($http) ->
    {
        list: ->
            return $http.get('/series.json').then (response) -> response.data
    }



formatWiki = ->
    return (input) ->
        return input.replace(/\(.*?\)/g, '').trim().replace(/\s/g, '_')

angular.module('app', ['truncate']).
    factory('SeriesService', ['$http', SeriesService]).
    controller('HomeCtrl', ['$scope', 'SeriesService', HomeCtrl]).
    filter('formatWiki', formatWiki)