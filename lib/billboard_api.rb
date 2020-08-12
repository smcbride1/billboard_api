require 'nokogiri'
require 'open-uri'

ARTIST_100_URL = "https://www.billboard.com/charts/artist-100"
HOT_100_URL = "https://www.billboard.com/charts/hot-100"
BILLBOARD_200_URL = "https://www.billboard.com/charts/billboard-200"

class BillboardAPI
    @@cache_frequency = 86400

    @@artist_100_cache = {}
    @@artist_100_cache_time = 0
    def self.artist_100(cache=false)
        if cache && !(Time.now.to_i > @@artist_100_cache_time + @@cache_frequency)
            return @@artist_100_cache
        end
        @@artist_100_cache_time = Time.now.to_i
        document = Nokogiri::HTML.parse(open(ARTIST_100_URL))
        artists = document.css(".chart-list-item")
        @@artist_100_cache = artists.map do |artist|
            new_artist = create_artist_object(
                artist.attribute("data-title").value, 
                if artist.css(".chart-list-item__image-wrapper").css("img").length > 1
                    if artist.css(".chart-list-item__image-wrapper").css("img")[1].attributes.has_key?("data-src")
                        artist.css(".chart-list-item__image-wrapper").css("img")[1].attribute("data-src").value
                    else
                        artist.css(".chart-list-item__image-wrapper").css("img")[1].attribute("src").value
                    end
                else
                    artist.css(".chart-list-item__image-wrapper").css("img").attribute("data-src").value
                end
            )

        end
    end

    @@hot_100_cache = {}
    @@hot_100_cache_time = 0
    def self.hot_100(cache=false)
        if cache && !(Time.now.to_i > @@hot_100_cache_time + @@cache_frequency)
            return @@hot_100_cache
        end
        @@hot_100_cache_time = Time.now.to_i
        document = Nokogiri::HTML.parse(open(HOT_100_URL))
        songs = document.css(".chart-list__element")
        @@hot_100_cache = songs.map do |song|
            new_song = create_song_object(
                song.css(".chart-element__information__song").text, 
                song.css(".chart-element__information__artist").text, 
                if song.css(".chart-element__image").attribute("style").value == "" #Empty style attribute catch
                    ""
                else
                    song.css(".chart-element__image").attribute("style").value.split("('")[1].split("')")[0]
                end
            )
        end
    end

    @@billboard_200_cache = {}
    @@billboard_200_cache_time = 0
    def self.billboard_200(cache=false)
        if cache && !(Time.now.to_i > @@billboard_200_cache_time + @@cache_frequency)
            return @@billboard_200_cache
        end
        @@billboard_200_cache_time = Time.now.to_i
        document = Nokogiri::HTML.parse(open(BILLBOARD_200_URL))
        songs = document.css(".chart-list__element")
        @@billboard_200_cache = songs.map do |song|
            new_song = create_song_object(
                song.css(".chart-element__information__song").text, 
                song.css(".chart-element__information__artist").text, 
                if song.css(".chart-element__image").attribute("style").value == "" #Empty style attribute catch
                    ""
                else
                    song.css(".chart-element__image").attribute("style").value.split("('")[1].split("')")[0]
                end
            )
        end
    end

    def self.create_artist_object(name, img_url)
        {
            name: name,
            img_url: img_url
        }
    end

    def self.create_song_object(name, artist, img_url)
        {
            name: name,
            artist: artist,
            img_url: img_url
        }
    end

    def self.cache_frequency
        @@cache_frequency
    end

    def self.cache_frequency=(cache_frequency)
        @@cache_frequency = cache_frequency
    end
end