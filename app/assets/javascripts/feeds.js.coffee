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
        cnt = parseInt($("#feed_box_#{feed_id} .like_cnt").text());
        if data.like_flg
          $(e.currentTarget).css('color', '#38c')
          $("#feed_box_11 .like_cnt").text(cnt + 1);
        else
          $(e.currentTarget).css('color', 'white')
          $("#feed_box_11 .like_cnt").text(cnt - 1);
  
  $(document).on "click", ".delete_feed", (e) ->
    feed_id = $(this).data("feed-id")
    send_data = {id: feed_id}
    $.ajax "/feeds/#{feed_id}",
      type: "delete"
      dataType: "json"
      error: () ->
      success: (data) ->
        $("#feed_box_#{feed_id}").remove()
  
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
        html_str = ""
        html_str += "<div class='' style='background-color: yellow; padding: 10px; margin: 10px;'>"
        html_str += "  <span><img src='#{data.photo_url}' /></span>"
        html_str += "  <span>#{data.user_nick}</span>"
        html_str += "  <span>#{data.comment_content}</span>"
        html_str += "</div>"
        $("#comment_container").append(html_str)
        $("#comment_container").scrollTop(10000);
        
        
  $(document).on "click", "#heart", (e) ->
    alert("준비중인 기능입니다.");
    
  $(document).on "click", "#search", (e) ->
    alert("준비중인 기능입니다.");  
    
    
    
    
    
    
        
