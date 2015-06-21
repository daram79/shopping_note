# coding : utf-8
class FeedsController < ApplicationController
  protect_from_forgery :except => [:add_like]
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :comment, :add_like]
  before_action :is_login?, only: [:index, :index_json]

  # GET /feeds
  # GET /feeds.json
  def index
    # @friend_ids = current_user.user_relations.pluck(:friend_user_id)
    # ids = @friend_ids + current_user.id.to_s.split
    # feed_ids = MainFeed.where(user_id: ids).pluck(:feed_id)
    # feed_ids.uniq!
    # @feeds = Feed.where(id: feed_ids).order('id desc')
    # @current_user_id = current_user.id
  end
  
  def index_json
    @friend_ids = current_user.user_relations.pluck(:friend_user_id)
    ids = @friend_ids + current_user.id.to_s.split
    #feed_ids = MainFeed.where(user_id: ids).pluck(:feed_id)
    feed_ids = Feed.where(user_id: ids).pluck(:id)
    feed_ids.uniq!
    @feeds = Feed.where("id in ? and feed_type <> 2", feed_ids).order('updated_at desc')
    @current_user_id = current_user.id
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    if params[:user_token]
      user = User.where(email: params[:user_email], authentication_token: params[:user_token]).first
      sign_in user if user
    end
    @item_photo = @feed.feed_photos[0]
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
      content = params[:feed][:content]
      tags = Feed.get_tag(content) #태그 작성후 DB에 넣고 태그값 리턴해줌
      html_content = Feed.make_html(content, tags)
      #@feed = Feed.new(feed_params)
      @feed = Feed.new(feed_params.merge(html_content: html_content))
      respond_to do |format|
        if @feed.save
          #format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
          Feed.create_tag(@feed.id, tags)
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
    like = Like.where(feed_id: params[:id], user_id: current_user.id).first
    unless like
      like_flg = true
      Like.create(feed_id:params[:id] , user_id: current_user.id, like_type: "feed")
    else
      like.destroy
      like_flg = false
    end
    render json: {like_flg: like_flg}
  end
  
  def search_tag
    tag = params[:tag]
    feed_ids = FeedTag.where(tag_name: tag).pluck(:feed_id)
    @feeds = Feed.where(id: feed_ids)
  end
  
  def comment
    @comments = @feed.comments
  end
  
  def add_comment
    comment = Comment.create(feed_id:params[:id] , user_id: current_user.id, content: params[:comment_content])
    photo_url = current_user.profile_photos.first.image.thumb.url
    render json: {comment_content: comment.content, photo_url: photo_url, user_nick: current_user.nick}
  end
  
  def newest
    @feeds = Feed.all.order('updated_at desc')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params[:feed].permit(:user_id, :content, :html_content, :feed_type_id, feed_photos_attributes: [:image])
    end
end
