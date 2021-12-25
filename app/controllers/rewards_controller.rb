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
    @rewards = @player.rewards.where.not(category: "EternalPose").sort_by(&:statut)
    @eternalpose = @player.rewards.where(category: "EternalPose")
  end

  def daily_view
    @player = current_user.player
    @log = @player.quest_logs.last
  end

  def daily
    @player = current_user.player
    if @player.daily == true
      @random_daily = rand(1..100)
      if @random_daily >= 90
        @player.update(abilities_points: (@player.abilities_points + 1))
        @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 1 point de compétence!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
      elsif @random_daily >= 70
        @player.update(exp: (@player.exp + 200))
        @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 200 points d'expérience!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
      elsif @random_daily >= 50
        @player.update(action: (@player.action + 1))
        @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 1 point d'action!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
      elsif @random_daily >= 20
        @player.update(money: (@player.money + 10000))
        @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 10 000 Berrys!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
      else
        if @player.wanted < 91
          @player.update(wanted: (@player.wanted + 10))
          @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 10 points ⭐ Wanted!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
        else
          @player.update(money: (@player.money + 10000))
          @log = QuestLog.new
        @log.player = @player
        @log.content = "Votre Récompense du jour: 10 000 Berrys!"
        @log.image = "https://i.skyrock.net/4220/84734220/pics/3219135745_1_4_Yj66ygi1.jpg"
        @log.save
        end
      end
      @player.update(daily: false)
      redirect_to daily_view_path
    end
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

  def buy_skill
    @player = current_user.player
    @player.update(abilities_points: (@player.abilities_points + 1))
    @player.update(money: (@player.money - 1000000))
    redirect_to rewards_path
  end

  def use
    @reward = Reward.find(params[:reward_id])
    @reward.update(statut: "équipé")
    if @reward.category.include?("FDD")
      Player.all.each do |player|
        @log = QuestLog.new
        @log.player = player
        @log.content = "le #{@reward.name} à été mangé!"
        @log.save
      end
    end
    redirect_to rewards_path
  end

  def drop
    @reward = Reward.find(params[:reward_id])
    @reward.update(statut: "Non équipé")
    redirect_to rewards_path
  end

  def sell
    @reward = Reward.find(params[:reward_id])
    if reward_params[:price].to_i > 0
    @reward.update(price: reward_params[:price], statut: "A Vendre")
    redirect_to rewards_path
    else
      redirect_to rewards_path
      flash[:notice] = "problème!"
    end
  end

  def shop
    @player = Player.find(params[:player_id])
    @rewards = @player.rewards.where(statut: "A Vendre")
  end

  def buy_reward
    @reward = Reward.find(params[:reward_id])
    @player = @reward.player
    @place = Place.find_by(name: current_user.player.position)
    if @reward.price <= current_user.player.money && @reward.statut == "A Vendre" && @player.in_fight == false && current_user.player.in_fight == false
      @reward.update(statut: 'Non équipé', player_id: current_user.player.id)
      current_user.player.update(money: (current_user.player.money - @reward.price))
      @player.update(money: (@player.money + @reward.price))
      @log = QuestLog.new
      @log.player = @player
      @log.content = "Vous avez vendu #{@reward.name} pour #{@reward.price}B"
      @log.save
    end
    redirect_to rewards_path
  end

  def reward_params
    params.require(:reward).permit(:name, :category, :image, :price)
  end
end
