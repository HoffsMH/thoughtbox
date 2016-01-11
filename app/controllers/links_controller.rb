class LinksController < ApplicationController
  before_action :authenticate_user!
  def index
    @new_link = Link.new()
  end

  def create
    binding.pry
  end
end
