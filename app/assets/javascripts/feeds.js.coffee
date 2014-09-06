# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", ".feed_like", (e) ->
    feed_id = $(this).data("feed-id")
    send_data = {id: feed_id}
    $.ajax "/feeds/#{feed_id}/add_like",
      type: "post"
      dataType: "json"
      data: send_data
      error: () ->
        alert("error")
      success: (data) ->
  
  
  $(document).on "click", ".send_comment", (e) ->
    feed_id = $(this).data("feed-id")
    comment = $(".input_box").val()
    send_data = {id: feed_id, comment_content: comment}
    $.ajax "/feeds/#{feed_id}/add_comment",
      type: "post"
      dataType: "json"
      data: send_data
      error: () ->
      success: (data) ->
        $(".input_box").val("")
        
  $(document).on "click", "#heart", (e) ->
    alert("준비중인 기능입니다.");
    
  $(document).on "click", "#search", (e) ->
    alert("준비중인 기능입니다.");
    
  $(document).on "click", "#setting", (e) ->
    alert("준비중인 기능입니다.");
    
    
    
    
    
    
    
        
