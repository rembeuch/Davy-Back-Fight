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

  def index
    @player = current_user.player
    @rewards = @player.rewards.sort_by(&:statut)
  end

  def buy_health
    @player = current_user.player
    @player.update(health: (@player.health + 1))
    @player.update(money: (@player.money - 1000000))
    redirect_to rewards_path
  end

  def buy_action
    @player = current_user.player
    @player.update(action: (@player.action + 1))
    @player.update(money: (@player.money - 1000000))
    redirect_to rewards_path
  end

  def use
    @reward = Reward.find(params[:reward_id])
    @reward.update(statut: "équipé")
    redirect_to rewards_path
  end

  def reward_params
    params.require(:reward).permit(:name, :category, :image)
  end
end
