# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.carousel').carousel()

$(document).on 'ready page:load', ->
    angular.bootstrap document, ['app']

class HomeCtrl
    constructor: (SeriesService) ->
        SeriesService.list().then (series) =>
            @series = series

SeriesService = ($http) ->
    return {
        list: ->
            return $http.get('/series.json').then (response) -> response.data
    }

formatWiki = ->
    return (input) ->
        return input.replace(/\(.*?\)/g, '').trim().replace(/\s/g, '_')

angular.module('app', ['truncate']).
    controller('HomeCtrl', ['SeriesService', HomeCtrl]).
    filter('formatWiki', formatWiki).
    factory('SeriesService', ['$http', SeriesService])