require 'pry'
require 'colorize'
class CommandLineInterface

    def main
        greet_user
        create_objects
        capture_path_loop        
    end

    def greet_user
        puts '*****************************************************************'.yellow
        puts '*                                                               *'.yellow
        puts '*           Hello, welcome to the Hurricane CLI App!            *'.yellow
        puts '*                                                               *'.yellow
        puts '*****************************************************************'.yellow
    end

    def create_objects
        storms = Scraper.scrape_storms_and_details
        hashed_storms = storms.map {|key, value| {name: key, details: value}}
        Storm.create_storms_from_collection(hashed_storms) 
        regions = Scraper.scrape_regions_and_activity
        Region.create_regions_from_collection(regions)

    end
    def capture_path_loop
        input = " "
        puts ''
        puts '*****************************************************************'.yellow
        puts '*                                                               *'.yellow
        puts '*            To view region activity, enter "regions"           *'.yellow
        puts '*               For full report, enter "full report"            *'.yellow
        puts '*       Type storm name to see details of only that storm       *'.yellow
        puts '*              To exit the application, type "exit"             *'.yellow          
        puts '*                                                               *'.yellow
        puts '*****************************************************************'.yellow

        Storm.display_all_storms
        
        puts "Your wish is my command..."
        puts ''
        input = gets.strip
            if input == "regions"
                Region.all.each do |region| 
                    puts ""
                    puts "#{region.name}".blue
                    puts "#{region.number_storms_active}".green
                end
                sleep(5)
                capture_path_loop
            elsif input == "full report"
                Region.all.each do |region| 
                    puts ""
                    puts "#{region.name}".blue
                    puts "#{region.number_storms_active}".green
                end
                puts ""
                puts "Storms are listed in the above Region order (Atlantic -> Indian)".red
                Storm.all.each do |storm| 
                    puts ""
                    puts "#{storm.name}".blue
                    puts "#{storm.details}".green
                end
                sleep(10)
                capture_path_loop
            elsif input == "exit"
                say_goodbye
            else
                storm = Storm.find_by_name(input)
                sleep(5)
                capture_path_loop
            end
    end

    def say_goodbye
        puts '*****************************************************************'.yellow
        puts '*                                                               *'.yellow
        puts '*           Thanks for using the Hurricane CLI App!             *'.yellow
        puts '*                                                               *'.yellow
        puts '*****************************************************************'.yellow
        exit
    end
end