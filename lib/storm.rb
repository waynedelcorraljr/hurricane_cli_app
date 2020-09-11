require 'pry'
require 'colorize'
class Storm
    attr_accessor :name, :region, :details
    @@all = []
    def initialize(storm_hash)
        @name = storm_hash[:name]
        @details = storm_hash[:details]
        @@all << self
    end
    def self.create_storms_from_collection(current_storms)
        current_storms.each {|s| Storm.new(s)}
    end
    def self.all
        @@all
    end
    def self.display_all_storms
        puts ''
        puts "ACTIVE STORMS:".green
                Storm.all.each do |storm| 
                    puts "#{storm.name}".blue
                end
        puts ''
    end
    def self.find_by_name(input)
        selection = Storm.all.select {|storm| storm.name == input}
        if selection == []
            puts "Invalid input, please try again."
        else
            puts "#{selection.first.details}".red
        end
    end
end
