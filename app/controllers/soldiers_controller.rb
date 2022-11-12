class SoldiersController < ApplicationController
    def self.creation(solo)
        solo.soldiers.destroy_all
        @shuffle_zones = Zone.all.select{|z| z.solo == solo}.in_groups_of(Zone.all.select{|z| z.solo == solo}.length / 3).to_a
        @marine_zones = @shuffle_zones[0]
        @pirate_zones = @shuffle_zones[1]
    
        @marine_zones.each do |zone|
            @soldier = Soldier.new(
            version: "soldats",
            level: 1,
            zone: zone.name,
            side: "marine",
            cost: 100,
            solo: solo
            )
            @soldier.save

            @soldier = Soldier.new(
                version: "lieutenants",
                level: 2,
                zone: zone.name,
                side: "marine",
                cost: 200,
                solo: solo
                )
            @soldier.save
        end
        @pirate_zones.each do |zone|
            @soldier = Soldier.new(
            version: "pirates",
            level: 1,
            zone: zone.name,
            side: "pirate",
            cost: 100,
            solo: solo
            )
            @soldier.save

            @soldier = Soldier.new(
                version: "lieutenants",
                level: 2,
                zone: zone.name,
                side: "pirate",
                cost: 200,
                solo: solo
                )
            @soldier.save
        end
    end
end
