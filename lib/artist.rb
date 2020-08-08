class Artist
    attr_accessor :name, :profile_img_url

    def initialize(name, profile_img_url)
        @name = name
        @profile_img_url = profile_img_url
    end
end