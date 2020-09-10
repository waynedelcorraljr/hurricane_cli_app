require 'pry'
class CommandLineInterface

    def main
        greet_user
        provide_paths
        capture_path        
    end

    def greet_user
        puts 'Hello, welcome to the Hurricane CLI App!'
    end

    def provide_paths
        storms = Scraper.scrape_storms_and_details
        hashed_storms = storms.map {|key, value| {name: key, details: value}}
        Storm.create_storms_from_collection(hashed_storms) 
        regions = Scraper.scrape_regions_and_activity
        Region.create_regions_from_collection(regions)
        puts 'To view all active storms, enter "active storms"'
        puts 'To view details of all active storms, enter "active storm details"'
        puts 'To view region activity, enter "region activity"'
        puts 'To exit the application, enter "exit"'

    end
    def capture_path
        input = " "
        puts "What would you like to see?"
        input = gets.strip
            if input == "active storm details"
                storm_list = Storm.all.map {|storm| {storm.name => storm.details}}
                puts storm_list
                capture_path
            elsif input == "active storms"
                storm_list = Storm.all.map {|storm| storm.name}
                puts storm_list
                capture_path
            elsif input == "region activity"
                region_list = Region.all.map {|region| {region.name => region.number_storms_active}}
                puts region_list
                capture_path
            elsif input == "exit"
                say_goodbye
            else
                puts "Invalid input, please try again."
                capture_path
            end
    end

    def say_goodbye
        puts "Thanks for using the Hurricane CLI App!"
        exit
    end
end