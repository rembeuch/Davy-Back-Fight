class UsersControllerController < ApplicationController
  def index
    @users = User.all
  end
end
