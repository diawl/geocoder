require 'geocoder/results/base'

module Geocoder::Result
  class LocationIq < Base
    def coordinates
      ['lat', 'lon'].map{ |coordinate_name| @data[coordinate_name] }
    end

    def address
      @data['display_name']
    end

    def type
      @data['type']
    end
  end
end