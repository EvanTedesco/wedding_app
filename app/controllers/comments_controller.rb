class CommentsController < ApplicationController

  def index
  @users = User.all
  end
end