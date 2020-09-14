require 'colorize'
class CommandLineInterface

    def main
        greet_user
        create_objects
        capture_path_loop        
    end

    def greet_user
        puts '*****************************************************************'.magenta
        puts '*                                                               *'.magenta
        puts '*           Hello, welcome to the Hurricane CLI App!            *'.magenta
        puts '*                                                               *'.magenta
        puts '*****************************************************************'.magenta
        puts ''
        puts '            Generating storm data, just a moment.....            '.green
    end

    def create_objects
        storms = Scraper.scrape_storms_and_details
        Storm.create_storms_from_collection(storms) 

        regions = Scraper.scrape_regions_and_activity
        Region.create_regions_from_collection(regions)
    end

    def capture_path_loop
        input = " "
        puts ''
        puts '*****************************************************************'.magenta
        puts '*                                                               *'.magenta
        puts '*            To view region activity, enter "regions"           *'.magenta
        puts '*               For full report, enter "full report"            *'.magenta
        puts '*       Type storm name to see details of only that storm       *'.magenta
        puts '*              To exit the application, type "exit"             *'.magenta          
        puts '*                                                               *'.magenta
        puts '*****************************************************************'.magenta

        Storm.display_all_storms
        
        puts "Your wish is my command..."
        puts ''
        input = gets.strip
            if input.upcase == "REGIONS"
                Region.all.each do |region| 
                    puts ""
                    puts "#{region.name}".blue
                    puts "#{region.number_storms_active}".green
                end
                sleep(2)
                capture_path_loop
            elsif input.upcase == "FULL REPORT"
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
                    puts "Last Updated: #{storm.last_updated} GMT".green
                    puts "Location: #{storm.location}".green
                    puts "Movement: #{storm.movement}".green
                    puts "Wind Speed: #{storm.wind_speed}".green
                    puts "Pressure: #{storm.pressure}".green
                end
                sleep(5)
                capture_path_loop
            elsif input.upcase == "EXIT"
                say_goodbye
            else
                storm = Storm.find_by_name(input)
                sleep(2)
                capture_path_loop
            end
    end

    def say_goodbye
        puts '*****************************************************************'.magenta
        puts '*                                                               *'.magenta
        puts '*           Thanks for using the Hurricane CLI App!             *'.magenta
        puts '*                                                               *'.magenta
        puts '*****************************************************************'.magenta
        exit
    end
end