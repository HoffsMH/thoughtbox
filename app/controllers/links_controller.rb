class LinksController < ApplicationController
  before_action :authenticate_user!
  def index
    @new_link = Link.new()
    @links = Link.where(user_id: current_user.id)
  end

  def create
    link = Link.new(new_link_params)
    if link.save
      redirect_to root_path
    else
      flash.notice = link.errors.full_messages.join(", ")
      redirect_to action: "index"
    end
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = Link.find_by(id: params[:id])
    @link.update(new_link_params)
    redirect_to "/"
  end

  private
  def new_link_params
    o = params.require(:link).permit(:title, :url)
    o[:user_id] = current_user.id
    o
  end
end
