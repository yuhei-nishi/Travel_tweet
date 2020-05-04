class TweetsController < ApplicationController
  before_action :set_group

  def index
    @tweet = Tweet.new
    @tweets = @group.tweets.includes(:user)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = @group.tweets.new(tweet_params)
    if @tweet.save
      redirect_to group_tweets_path(@group), notice: 'メッセージが送信されました'
    else
      @tweets = @group.tweets.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
