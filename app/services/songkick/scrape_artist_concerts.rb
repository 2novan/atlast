require 'nokogiri'
require 'open-uri'

module Songkick
  class ScrapeArtistConcerts
    def initialize(artist)
      @artist = artist
    end

    def call
      url = "https://www.songkick.com/search?page=1&per_page=10&query=#{@artist.name}&type=upcoming"

      html_file = URI.open(url).tap do |io|
        charset = io.charset { 'utf-8' }
        io.set_encoding(charset)
      end

      html_doc = Nokogiri::HTML(html_file, nil, Encoding::UTF_8.to_s)

      html_doc.xpath('//div[@class="subject"]').each do |element|
        concert = Concert.new
        concert.start_at = Time.parse(element.search(".date time").first.attribute('datetime').value)
        concert.name = element.search('p.summary a').text.strip.encode('utf-8')
        concert.location = element.search('p.location').text.strip.encode('utf-8')
        concert.artist_id = @artist.id
        concert.save!
      end
    end
  end
end
