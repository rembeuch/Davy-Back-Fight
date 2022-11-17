class ZonesController < ApplicationController
    def self.creation(solo)
        solo.zones.destroy_all
        @zone = Zone.new(
            name: "Ile de Dawn",
            position: 1,
            solo: solo
        )
        @zone.save
        @zone = Zone.new(
            name: "Shimotsuki",
            position: 2,
            solo: solo
        )
        @zone.save

        @zone = Zone.new(
            name: "Ile de Goat",
            position: 3,
            solo: solo
        )
        @zone.save

        @zone = Zone.new(
            name: "Yotsuba",
            position: 4,
            solo: solo
        )
        @zone.save

        @zone = Zone.new(
            name: "Archipel des Orgao",
            position: 5,
            solo: solo
        )
        @zone.save

        @zone = Zone.new(
            name: "Ile des animaux rares",
            position: 6,
            solo: solo
        )
        @zone.save        
    end

    def self.attribut(solo)
        @shuffle_zones = Zone.all.select{|z| z.solo == solo}.shuffle.in_groups_of(Zone.all.select{|z| z.solo == solo}.length / 3).to_a
        @marine_zones = @shuffle_zones[0]
        @pirate_zones = @shuffle_zones[1]
        @neutral_zones = @shuffle_zones[2]
        @marine_zones.each do |zone|
            zone.affinity = "marine"
            zone.affinity_number = rand(1..40)
            zone.slot = rand(4..10)
            zone.save
        end
        @pirate_zones.each do |zone|
            zone.affinity = "pirate"
            zone.affinity_number = rand(60..100)
            zone.slot = rand(4..10)
            zone.save
        end
        @neutral_zones.each do |zone|
            zone.affinity = "neutre"
            zone.affinity_number = rand(41..59)
            zone.slot = rand(1..10)
            zone.save
        end
    end

    def chantier
        @solo = current_user.solo
        @zone = Zone.find(params[:zone_id])
        @destination = Zone.find(params[:zone][:name])
        @version = params[:zone][:affinity]
        @cost = cost_construction(@version)
        if @zone != @destination
            @moving_days = (@zone.position - @destination.position).abs
        else
            @moving_days = 0
        end
        @constructions_days = @cost - (Building.where(solo: @solo, version: "chantier", zone: @zone.name).count * 15)
        if @solo.berrys >= @cost && @solo.wood >= @cost
            @building = Building.create!(solo: @solo, version: @version, zone: @zone.name, destination: @destination, moving_days: @moving_days, constructions_days: @constructions_days, statut: "creation")
            @solo.berrys -= @cost
            @solo.wood -= @cost
            @solo.save
        end
        redirect_to solo_path(@solo)
    end

    private

    def zones_params
        params.require(:zone).permit(:name, :affinity, :affinity_number, :position, :slot)
    end

    def cost_construction(version)
        if version == 'canon'
            return 150
        elsif version == 'chantier' || version == 'port' || version == 'caserne'
            return 200
        end
    end
end
