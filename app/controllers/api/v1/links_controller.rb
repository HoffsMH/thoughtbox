class Api::V1::LinksController < ApplicationController
  respond_to :json
  def update
    link =  Link.find_by(id: params[:id])
    link.update(link_params)
    render json: link
  end

  private
  def link_params
    o = params.require(:link).permit(:title, :url, :read, :user_id)
    o[:user_id] = current_user.id
    o
  end
end
