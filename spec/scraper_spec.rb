# frozen_string_literal: true

require 'scraper'

describe Scraper do
  let(:scraper) { Scraper.new }

  before(:each) do
    stub_const('Scraper::HOME_URL', 'spec/mock_html_files/home.html')
  end

  describe '#print_list' do
    # it 'works for one page in JSON format' do
    #   expect{scraper.print_list(1, 'json')}.to output(`[
    #      {
    #        "artist": "GELLERT SPA FULL DAY ENTRANCE TICKET",
    #        "city": "Budapest",
    #        "venue": "Gellert Thermal Spa",
    #        "date": "WED 7TH NOV, 2018 9:00am",
    #        "price": "Sold Out"
    #      },
    #      {
    #        "artist": "BOPUC'S THE HEART OF WINTER 8-WEEK, WINTER POP UP CHOIR FOR ALL",
    #        "city": "Newcastle upon tyne",
    #        "venue": "Space Six",
    #        "date": "WED 7TH NOV, 2018 6:00pm",
    #        "price": "69.55"
    #      },
    #      {
    #        "artist": "((BOUNCE)) DEMONSTRATION EVENING",
    #        "city": "Nottingham",
    #        "venue": "Fiesta Dance Centre",
    #        "date": "WED 7TH NOV, 2018 7:00pm",
    #        "price": "Cancelled"
    #      }
    #    ]`).to_stdout
    # end

    it 'works for one page in view format' do
      expect { scraper.print_list(1, 'view') }.to output("Artist: GELLERT SPA FULL DAY ENTRANCE TICKET\nCity: Budapest\nVenue: Gellert Thermal Spa\nDate: WED 7TH NOV, 2018 9:00am\nPrice: Sold Out\n\nArtist: BOPUC'S THE HEART OF WINTER 8-WEEK, WINTER POP UP CHOIR FOR ALL\nCity: Newcastle upon tyne\nVenue: Space Six\nDate: WED 7TH NOV, 2018 6:00pm\nPrice: 69.55\n\nArtist: ((BOUNCE)) DEMONSTRATION EVENING\nCity: Nottingham\nVenue: Fiesta Dance Centre\nDate: WED 7TH NOV, 2018 7:00pm\nPrice: Cancelled\n\n").to_stdout
    end
  end
end
