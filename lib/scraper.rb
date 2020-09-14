require 'nokogiri'
require 'open-uri'
class Scraper
SITE = "https://www.wunderground.com/hurricane" 

def self.scrape_regions_and_activity
    doc = Nokogiri::HTML(open(SITE))
    region_activity_hash = {}
    regions = doc.css('.ng-star-inserted').css('.basin-row').children.map {|e| e.css('span').text}.reject{|e| e == ""} 
    region_activity_hash[:atlantic_ocean] = regions[0]
    region_activity_hash[:eastern_pacific] = regions[1]
    region_activity_hash[:western_pacific] = regions[2]
    region_activity_hash[:central_pacific] = regions[3]
    region_activity_hash[:southern_hemisphere] = regions[4]
    region_activity_hash[:indian_ocean] = regions[5]
    region_activity_hash_hash = region_activity_hash.map {|key, value| {region: key.to_s.gsub("_", " ").upcase, active_storms: value}}
    region_activity_hash_hash
end

def self.scrape_storms_and_details
    doc = Nokogiri::HTML(open(SITE))
    storm_modules = doc.css('.storm')
    storm_hash_arr = storm_modules.map do |storm|
        {
            name: storm.css('h4').text,
            last_updated: storm.css('strong').first.text, #needs "GMT" timezone noted
            location: storm.css('strong')[1].text,
            movement: storm.css('strong')[2].text,
            wind_speed: storm.css('strong')[3].text,
            pressure: storm.css('strong').last.text,
            url: storm.css('a.button').attribute('href') #returns Attr not value, value must be called.
        }
    end
end

end