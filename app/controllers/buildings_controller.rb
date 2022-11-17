class BuildingsController < ApplicationController
    def self.creation(solo)
        solo.buildings.destroy_all
        @shuffle_zones = Zone.all.select{|z| z.solo == solo}.shuffle.in_groups_of(Zone.all.select{|z| z.solo == solo}.length / 3).to_a
        @marine_zones = @shuffle_zones[0]
        @pirate_zones = @shuffle_zones[1]
        @neutral_zones = @shuffle_zones[2]

        @marine_zones.each do |zone|
            @building = Building.new(
                version: "chantier",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "marine").shuffle.first.name,
                side: "marine",
                cost: 200,
                wood: 200
            )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "port",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "marine").shuffle.first.name,
                side: "marine",
                cost: 200,
                wood: 200
            )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "caserne",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "marine").shuffle.first.name,
                side: "marine",
                cost: 200,
                wood: 200
            )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "canon",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "marine").shuffle.first.name,
                side: "marine",
                cost: 150,
                wood: 150
            )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "chantier",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "marine").shuffle.first.name,
                    side: "marine",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "port",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "marine").shuffle.first.name,
                    side: "marine",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "caserne",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "marine").shuffle.first.name,
                    side: "marine",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "chantier",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "marine").shuffle.first.name,
                    side: "marine",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "canon",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "marine").shuffle.first.name,
                    side: "marine",
                    cost: 150,
                    wood: 150
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
        end   

        @pirate_zones.each do |zone|
            @building = Building.new(
                version: "chantier",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "pirate").shuffle.first.name,
                side: "pirate",
                cost: 200,
                wood: 200
          )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "port",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "pirate").shuffle.first.name,
                side: "pirate",
                cost: 200,
                wood: 200
          )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "caserne",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "pirate").shuffle.first.name,
                side: "pirate",
                cost: 200,
                wood: 200
          )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            @building = Building.new(
                version: "canon",
                level: 1,
                solo: solo,
                zone: Zone.where(affinity: "pirate").shuffle.first.name,
                side: "pirate",
                cost: 150,
                wood: 150
          )
            if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                @building.save
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "chantier",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "pirate").shuffle.first.name,
                    side: "pirate",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "port",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "pirate").shuffle.first.name,
                    side: "pirate",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "caserne",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "pirate").shuffle.first.name,
                    side: "pirate",
                    cost: 200,
                    wood: 200   
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "chantier",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "pirate").shuffle.first.name,
                    side: "pirate",
                    cost: 200,
                    wood: 200
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
            random = rand(1..100)
            if random > 75 
                @building = Building.new(
                    version: "canon",
                    level: 1,
                    solo: solo,
                    zone: Zone.where(affinity: "pirate").shuffle.first.name,
                    side: "pirate",
                    cost: 150,
                    wood: 150
                )
                if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                    @building.save
                end
            end
                
        end

        @neutral_zones.each do |zone|
            random = rand(1..100)
                if random > 75 
                    @building = Building.new(
                        version: "chantier",
                        level: 1,
                        solo: solo,
                        zone: Zone.where(affinity: "neutre").shuffle.first.name,
                        side: "neutre",
                        cost: 200,
                        wood: 200
                    )
                    if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                        @building.save
                    end
                end
                random = rand(1..100)
                if random > 75 
                    @building = Building.new(
                        version: "port",
                        level: 1,
                        solo: solo,
                        zone: Zone.where(affinity: "neutre").shuffle.first.name,
                        side: "neutre",
                        cost: 200,
                        wood: 200
                    )
                    if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                        @building.save
                    end
                end
                random = rand(1..100)
                if random > 75 
                    @building = Building.new(
                        version: "caserne",
                        level: 1,
                        solo: solo,
                        zone: Zone.where(affinity: "neutre").shuffle.first.name,
                        side: "neutre",
                        cost: 200,
                        wood: 200
                    )
                    if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                        @building.save
                    end
                end
                random = rand(1..100)
                if random > 75 
                    @building = Building.new(
                        version: "chantier",
                        level: 1,
                        solo: solo,
                        zone: Zone.where(affinity: "neutre").shuffle.first.name,
                        side: "neutre",
                        cost: 200,
                        wood: 200   
                    )
                    if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                        @building.save
                    end
                end
                random = rand(1..100)
                if random > 75 
                    @building = Building.new(
                        version: "canon",
                        level: 1,
                        solo: solo,
                        zone: Zone.where(affinity: "neutre").shuffle.first.name,
                        side: "neutre",
                        cost: 150,
                        wood: 150   
                    )
                    if Zone.find_by(name: @building.zone).slot > Building.where(zone: @building.zone).count
                        @building.save
                    end
                end
        end
    end
end
