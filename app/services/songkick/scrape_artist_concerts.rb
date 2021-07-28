require 'nokogiri'
require 'open-uri'

module Songkick
  class ScrapeArtistConcerts
    def initialize(artist)
      @artist = artist
    end

    def call
      url = "https://www.songkick.com/search?page=1&per_page=10&query=#{@artist.name}&type=upcoming"

      html_file = URI.open(URI.escape(url))
      html_doc = Nokogiri::HTML(html_file, nil, Encoding::UTF_8.to_s)
      html_doc.search('.concert.event').each do |element|
        songkick_id = element.search('a.thumb').attribute('href').value.match(/(concerts\/)(?<id>\d+)-/)[:id].to_i
        concert = Concert.find_or_create_by(songkick_id: songkick_id)

        concert.update!(
          start_at: Time.parse(element.search(".date time").first.attribute('datetime').value),
          name: element.search('div p.summary a').text.strip.encode('utf-8'),
          location: element.search('div p.location').text.strip.encode('utf-8'),
          artist_id: @artist.id
        )
      end
    end
  end
end
