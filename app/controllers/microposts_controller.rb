class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end      
  end

  def destroy
    @micropost.destroy
    flash[:success] ='メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def likes
    @micropost = Micropost.find(params[:id])
    @likes = @micropost.likes.page(params[:page])
    counts(@like)
  end  
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def corrent_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
end





