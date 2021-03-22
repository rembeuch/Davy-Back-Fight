class FightTokensController < ApplicationController
  def create
    raise
    @fight_token = FightToken.new
    @fight_token.player = current_user
    @fight_token.enemy = Player.find(params[:player_id])
    @fight_token.save
  end
end
