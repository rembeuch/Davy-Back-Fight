class PersosController < ApplicationController
    def self.creation(solo)
        solo.persos.destroy_all
        @perso = Perso.new(
            name: "Luffy",
            side: "pirate",
            health: "neutre",
            captured: false,
            diplomatie: 10,
            charisme: 30,
            discretion: 2,
            fight: 50,
            recrutement: true,
            trainer: true,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
            special: true
        )
        @perso.save
        @perso = Perso.new(
            name: "Zoro",
            side: "pirate",
            health: "neutre",
            captured: false,
            diplomatie: 10,
            charisme: 40,
            discretion: 5,
            fight: 40,
            recrutement: false,
            trainer: true,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
        )
        @perso.save
        @perso = Perso.new(
            name: "Nami",
            side: "pirate",
            health: "neutre",
            captured: false,
            diplomatie: 40,
            charisme: 20,
            discretion: 40,
            fight: 15,
            recrutement: false,
            trainer: false,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
        )
        @perso.save
        @perso = Perso.new(
            name: "Baggy",
            side: "pirate",
            health: "neutre",
            captured: false,
            diplomatie: 10,
            charisme: 30,
            discretion: 20,
            fight: 35,
            recrutement: false,
            trainer: false,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
        )
        @perso.save
        @perso = Perso.new(
            name: "Garp",
            side: "marine",
            health: "neutre",
            captured: false,
            diplomatie: 15,
            charisme: 50,
            discretion: 15,
            fight: 50,
            recrutement: true,
            trainer: true,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
            special: true
        )
        @perso.save
        @perso = Perso.new(
            name: "Smoker",
            side: "marine",
            health: "neutre",
            captured: false,
            diplomatie: 15,
            charisme: 30,
            discretion: 25,
            fight: 40,
            recrutement: false,
            trainer: true,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
            special: true
        )
        @perso.save
        @perso = Perso.new(
            name: "Tashigi",
            side: "marine",
            health: "neutre",
            captured: false,
            diplomatie: 45,
            charisme: 20,
            discretion: 25,
            fight: 30,
            recrutement: false,
            trainer: false,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
            special: true
        )
        @perso.save
        @perso = Perso.new(
            name: "Morgan",
            side: "marine",
            health: "neutre",
            captured: false,
            diplomatie: 5,
            charisme: 30,
            discretion: 10,
            fight: 25,
            recrutement: false,
            trainer: false,
            innovation: false,
            moving: false,
            mission: false,
            solo: solo,
            special: true
        )
        @perso.save
    end

    def self.attribut(solo)
        @marines = Perso.all.select{|perso| perso.solo == solo && perso.side == "marine"}
        @pirates = Perso.all.select{|perso| perso.solo == solo && perso.side == "pirate"}

        @marines.each do |marine|
            marine.zone = Zone.where(affinity: "marine").shuffle.first.name
            marine.save
        end

        @pirates.each do |pirate|
            pirate.zone = Zone.where(affinity: "pirate").shuffle.first.name
            pirate.save
        end

    end

    def move_perso
        @solo = current_user.solo
        @perso = Perso.find(params[:id])
        @new_zone = Zone.find_by(name: params[:perso][:zone])
        @actual_zone = Zone.find_by(name: @perso.zone)
        @travel_days = (@new_zone.position - @actual_zone.position).abs
        
        @perso.update(zone: params[:perso][:zone], moving: true, moving_days: @travel_days)
    end
end
