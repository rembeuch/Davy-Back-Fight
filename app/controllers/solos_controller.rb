class SolosController < ApplicationController
    before_action :check_solo, except: [:menu, :create]
    def create
      if current_user.solo == nil
        @solo = Solo.new
      else
        @solo = current_user.solo
      end
      @solo.user = current_user
      @solo.side = params[:side]
      @solo.jour = 0
      @solo.berrys = 500
      @solo.wood = 500
      @solo.save
      if @solo.computer
        @solo.computer.destroy
      end
      @computer = Computer.new
      if @solo.side == "marine"
        @computer.side = 'pirate'
      else
        @computer.side = "marine"
      end
      @computer.solo = @solo
      @computer.save
      ZonesController.creation(@solo)
      ZonesController.attribut(@solo)
      PersosController.creation(@solo)
      PersosController.attribut(@solo)
      BuildingsController.creation(@solo)
      BoatsController.creation(@solo)
      SoldiersController.creation(@solo)
      redirect_to solo_path(@solo)
    end

    def menu
        
    end

    def show
      @solo = current_user.solo
      @zones = Zone.where(solo: @solo).sort_by(&:position)
      @side_zones = Zone.where(affinity: @solo.side, solo: @solo).sort_by(&:position)
      @zones_with_slots = Zone.select{|zone| zone.affinity == @solo.side && zone.solo == @solo && (zone.slot - Building.where(zone: zone.name, solo: @solo, statut: nil).count - Building.where( destination: zone.name, statut: "creation", solo: @solo).count) > 0}.sort_by(&:position)
    end

    def check_solo
      if current_user.solo == nil
        redirect_to menu_path
      end
    end

    def check_moving_perso

    end
end
