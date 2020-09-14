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
        puts "ACTIVE STORMS:".blue
                Storm.all.each do |storm| 
                    puts "#{storm.name}".green
                end
        puts ''
    end
    def self.find_by_name(input)
        selection = Storm.all.select {|storm| storm.name.upcase == input.upcase}
        if selection == []
            puts "Invalid input, please try again."
        else
            puts "#{selection.first.name}".blue
            puts "Last Updated: #{selection.first.last_updated} GMT".green
            puts "Location: #{selection.first.location}".green
            puts "Movement: #{selection.first.movement}".green
            puts "Wind Speed: #{selection.first.wind_speed}".green
            puts "Pressure: #{selection.first.pressure}".green
            puts ''
            puts 'Would you like to see live radar of this storm?'
                base_path = "https://www.wunderground.com"
                answer = ''
                answer = gets.strip
                if answer.upcase == "Y" || answer.upcase == "YES"
                    system("open '#{base_path + selection.first.url.value}'")
                end
        end
    end
end
