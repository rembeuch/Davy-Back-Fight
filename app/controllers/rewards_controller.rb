class RewardsController < ApplicationController
  def new
    @mob = Mob.find(params[:mob_id])
    @reward = Reward.new
  end

  def create
    @mob = Mob.find(params[:mob_id])
    @reward = Reward.new(reward_params)
    @reward.mob = @mob
    @reward.player = current_user.player
    if @reward.save
      redirect_to place_path(@mob.place)
    else
      render :new
    end
  end

  def reward_params
    params.require(:reward).permit(:name, :category, :image)
  end
end
