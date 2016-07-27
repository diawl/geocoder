require 'geocoder/results/base'

module Geocoder::Result
  class UnwiredLabs < Base
    def coordinates
      ['lat', 'lon'].map{ |coordinate_name| @data[coordinate_name] }
    end
  end
end