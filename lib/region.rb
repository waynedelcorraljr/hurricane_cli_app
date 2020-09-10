class Region
    attr_accessor :name, :number_storms_active
    @@all = []
    def initialize(region_hash)
        @name = region_hash[:region]
        @number_storms_active = region_hash[:active_storms]
        @@all << self
    end
    def self.create_regions_from_collection(region_activity_hash_hash)
        region_activity_hash_hash.each {|r| Region.new(r)}
    end
    def self.all
        @@all
    end
    # def storms
    #     Storm.all.map {|s| s.region == self}
    # end
end