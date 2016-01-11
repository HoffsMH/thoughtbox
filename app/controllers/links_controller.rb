class LinksController < ApplicationController
  before_action :authenticate_user!
  def index
    @new_link = Link.new()
  end

  def create
    link = Link.new(new_link_params)
    if link.save
      binding.pry
      redirect_to root_path
    else
      binding.pry
      redirect_to action: "index"
    end
  end

  private
  def new_link_params
    o = params.require(:link).permit(:title, :url)
    o[:user_id] = current_user.id
    o
  end
end
