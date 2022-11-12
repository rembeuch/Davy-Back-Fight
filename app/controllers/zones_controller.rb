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

    private

    def zones_params
        params.require(:zone).permit(:name, :affinity, :affinity_number, :position, :slot)
    end
end
