require 'colorize'
class Storm
    attr_accessor :name, :region, :details, :last_updated, :location, :movement, :wind_speed, :pressure, :url
    @@all = []
    def initialize(storm_hash)
        @name = storm_hash[:name]
        @last_updated = storm_hash[:last_updated]
        @location = storm_hash[:location]
        @movement = storm_hash[:movement]
        @wind_speed = storm_hash[:wind_speed]
        @pressure = storm_hash[:pressure]
        @url = storm_hash[:url] 
        # @region = 
        @@all << self
    end
    def self.create_storms_from_collection(current_storms)
        current_storms.each {|s| Storm.new(s)}
    end
    def self.all
        @@all
    end
    def self.display_all_storm_names
        sorted_storms = Storm.all.sort_by {|storm| storm.name}
        puts ''
        puts "                      ACTIVE STORMS:".blue
                sorted_storms.each do |storm| 
                    puts "                  #{storm.name}".green
                end
        puts ''
    end
    def self.find_by_name(input)
        selection = Storm.all.select {|storm| storm.name.upcase == input.upcase}
        if selection == []
            puts "Invalid input, please try again."
        else
            puts "#{selection.first.name}".blue
            puts "  Last Updated: ".green
            puts "      #{selection.first.last_updated} GMT".light_blue
            puts "  Location: ".green
            puts "      #{selection.first.location}".light_blue
            puts "  Movement: ".green
            puts "      #{selection.first.movement}".light_blue
            puts "  Wind Speed: ".green
            puts "      #{selection.first.wind_speed}".light_blue
            puts "  Pressure: ".green
            puts "      #{selection.first.pressure}".light_blue
            puts ''
            puts 'Would you like to see live radar of this storm?'
                base_path = "https://www.wunderground.com"
                answer = ''
                answer = gets.strip
                if answer.upcase == "Y" || answer.upcase == "YES"
                    if selection.first.url == nil
                        system("open '#{base_path + '/hurricane'}'")
                    else
                        system("open '#{base_path + selection.first.url.value}'")
                    end
                end
        end
    end
end
