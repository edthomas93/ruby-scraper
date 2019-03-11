# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'

class Scraper
  HOME_URL = 'https://www.wegottickets.com/searchresults/all'

  attr_reader :counter, :concert_links

  def print_list(number, type)
    data = Nokogiri::HTML(open(HOME_URL))
    error_handling(type, data, number)
    desired_pages_of_concerts(number)
    print_info(type)
  end

  def error_handling(type, data, number)
    max_page_number = data.css('.block-group.advance-filled.section-margins.padded.text-center').text.split[15].strip.to_i
    raise "There are only #{max_page_number} pages to view" if number > max_page_number
    raise "Please enter 'json' or 'view' as the 2nd argument" unless type == 'json' || type == 'view'
  end

  def create_json_file
    File.open('public/temp.json', 'w+') do |file|
      file.write(@pretty_json)
    end
  end

  def desired_pages_of_concerts(number)
    @concert_links = []
    @counter = 1
    while @counter <= number
      if ENV['ENVIRONMENT'] == 'test'
        all_pages = "spec/mock_html_files/home.html"
      else
        all_pages = "https://www.wegottickets.com/searchresults/page/#{@counter}/all#paginate"
      end
      @page_data = Nokogiri::HTML(open(all_pages))
      get_concert_links
      @counter += 1
    end
  end

  def get_concert_links
    all_concerts_info = @page_data.css('.content.block-group.chatterbox-margin')
    links_to_concerts = all_concerts_info.css('.block.diptych.text-right a')
    links_to_concerts.each do |link|
      @concert_links << link['href']
    end
  end

  def print_info(type)
    @json_format = []
    @concert_links.each do |link|
      concert_data = Nokogiri::HTML(open(link))
      if type == 'json'
        @json_format << json(concert_data)
      elsif type == 'view'
        puts details(concert_data)
      end
    end
    if type == 'json'
      @pretty_json = JSON.pretty_generate(@json_format)
      puts @pretty_json
    end
  end

  def json(concert)
    { artist: get_artist(concert), city: get_city(concert), venue: get_venue(concert), date: get_date(concert), price: get_price(concert) }
  end

  def details(concert)
    ['Artist: ' + get_artist(concert), 'City: ' + get_city(concert), 'Venue: ' + get_venue(concert), 'Date: ' + get_date(concert), 'Price: ' + get_price(concert), '']
  end

  def get_artist(concert)
    concert.css('.left.full-width-mobile.event-information.event-width h1').text
  end

  def get_city(concert)
    concert.at_css('.venue-details h2').text.split(':')[0].capitalize.strip
  end

  def get_venue(concert)
    concert.at_css('.venue-details h2').text.split(':')[1].strip
  end

  def get_date(concert)
    concert.css('.venue-details h4').text
  end

  def get_price(concert)
    if concert.css('.BuyBox.block span').text.include? 'SOLD OUT'
      'Sold Out'
    elsif concert.css('.BuyBox.block span').text.include? 'CANCELLED'
      'Cancelled'
    else
      concert.at_css('.BuyBox.block strong').text
    end
  end
end
