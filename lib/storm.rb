
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
    # binding.pry
end