# coding : utf-8
class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :comment, :add_like]
  before_action :is_login?, only: [:index]

  # GET /feeds
  # GET /feeds.json
  def index
    #@feeds = Feed.where(user_id: current_user.id).order('id desc')
    @friend_ids = current_user.user_relations.pluck(:friend_user_id)
    ids = @friend_ids + current_user.id.to_s.split
    feed_ids = FeedData.where(user_id: ids).pluck(:feed_id)
    feed_ids.uniq!
    @feeds = Feed.where(id: feed_ids).order('id desc')
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
    @feed.feed_photos.build
    @feed_types = FeedType.all
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    content_type = params[:feed][:feed_photos_attributes]["0"][:image].content_type
    unless "image".eql?(content_type.split('/')[0])
      flash[:notice] = "지원하지 않는 형식의 사진입니다."
      redirect_to action: "new"
    else
      @feed = Feed.new(feed_params)
      respond_to do |format|
        if @feed.save
          #format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
          format.html { redirect_to feeds_url, notice: 'Feed was successfully created.' }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def add_like
    count = Like.where(feed_id: params[:id], user_id: current_user.id).count
    if count == 0
      Like.create(feed_id:params[:id] , user_id: current_user.id, like_type: "feed")
      
      #@feed.user_id, current_user.id
      feed_user_id = @feed.user_id
      channel_user_ids = UserRelation.where(friend_user_id: feed_user_id).pluck(:user_id)
      channel_user_ids.push feed_user_id
      channel_user_ids.push current_user.id
      channel_user_ids.uniq!
      
      unless channel_user_ids.blank?
        channel_user_ids.each do |id|
          message = {channel: "/feeds/#{id}", data: {feed_id: params[:id], like_count: 1}}
          #uri = URI.parse("http://localhost:9292/faye")
          uri = URI.parse(CONFIG['websocket_host'])
          Net::HTTP.post_form(uri, :message => message.to_json)
        end
      end
    end
    render json: {content: :no_content}
  end
  
  def comment
    @comments = @feed.comments 
  end
  
  def add_comment
    comment = Comment.create(feed_id:params[:id] , user_id: current_user.id, content: params[:comment_content])
    render json: {comment: comment}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params[:feed].permit(:user_id, :content, :feed_type_id, feed_photos_attributes: [:image])
    end
end
