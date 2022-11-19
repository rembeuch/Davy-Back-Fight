class BoatsController < ApplicationController
    def self.creation(solo)
        solo.boats.destroy_all
        @shuffle_zones = Zone.all.select{|z| z.solo == solo}.in_groups_of(Zone.all.select{|z| z.solo == solo}.length / 3).to_a
        @marine_zones = @shuffle_zones[0]
        @pirate_zones = @shuffle_zones[1]
    
        @marine_zones.each do |zone|
            @boat = Boat.new(
            version: "barque",
            level: 1,
            zone: zone.name,
            side: "marine",
            wood: 100,
            cost: 100,
            solo: solo
            )
            @boat.save

            @boat = Boat.new(
                version: "caravelle",
                level: 2,
                zone: zone.name,
                side: "marine",
                wood: 200,
                cost: 200,
                solo: solo
                )
            @boat.save
        end
        @pirate_zones.each do |zone|
            @boat = Boat.new(
            version: "barque",
            level: 1,
            zone: zone.name,
            side: "pirate",
            wood: 100,
            cost: 100,
            solo: solo
            )
            @boat.save

            @boat = Boat.new(
                version: "caravelle",
                level: 2,
                zone: zone.name,
                side: "pirate",
                wood: 200,
                cost: 200,
                solo: solo
                )
            @boat.save
        end
    end

    def destroy_boat
        @boat = Boat.find(params[:boat])
        @zone = Zone.find_by(name: @boat.zone)
        @boat.destroy
        # respond_to do |format|
        #     format.html
        #     format.text { render partial: 'solos/chantiers_modal.html', locals: { zone: @zone } }
        # end
        redirect_to solo_path(current_user.solo)
    end
end
