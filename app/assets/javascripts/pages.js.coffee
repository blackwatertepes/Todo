# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
	$('#task_search').typeahead
		name: 'name',
    	source: remote

remote = (query, process) ->
	$.ajax
		url: "/search",
		data: 
			term: query
		complete: (xhr, status) ->
			#console.log xhr.responseText
			process(xhr.responseText)