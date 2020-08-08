require 'nokogiri'
require 'open-uri'
require 'pry'
require './artist'

ARTIST_100_URL = "https://www.billboard.com/charts/artist-100"

class BillboardAPI
    def self.artist_100
        document = Nokogiri::HTML.parse(open(ARTIST_100_URL))
        artists = document.css(".chart-list-item")
        artists.map do |artist|
            new_artist = Artist.new(
                artist.attribute("data-title").value, 
                if artist.css(".chart-list-item__image-wrapper").css("img").length > 1
                    artist.css(".chart-list-item__image-wrapper").css("img")[1].attribute("data-src").value
                else
                    artist.css(".chart-list-item__image-wrapper").css("img").attribute("data-src").value
                end
            )
        end
    end
end