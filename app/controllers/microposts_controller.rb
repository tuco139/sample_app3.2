class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  respond_to :html, :js 
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_path
 #   redirect_to request.referer
  end
  
  private
  
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @microposts.nil?
    end
end