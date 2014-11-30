# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#tag_search", (e) ->
    tag = $("#tag").val()
    
    $.ajax "/searches/tag_search",
      type: "get"
      dataType: "json"
      data: {tag: tag}
      error: () ->
        alert("error")
      success: (data) ->
        feeds = data.feeds
        html_str = ""
        for feed in feeds
          html_str += "<a style=''><img style='width:33%' src='#{feed.feed_photos[0].image.url}' /></a>"
        $("#search_result").html(html_str)
        
  