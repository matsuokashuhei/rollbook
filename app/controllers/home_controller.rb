class HomeController < ApplicationController

  def index
    @posts = Post.active.order(open_date: :desc, updated_at: :desc).decorate
  end
end
