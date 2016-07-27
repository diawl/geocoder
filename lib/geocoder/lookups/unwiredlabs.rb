require 'geocoder/lookups/base'
require 'geocoder/results/unwiredlabs'

module Geocoder::Lookup
  class UnwiredLabs < Base

    def name
      'unwiredlabs.com'
    end

    def supported_protocols
      [:https]
    end

    def required_api_key_parts
      ['api_key']
    end

    def query_url(query)
      "#{protocol}://ap1.unwiredlabs.com/v2/address.php?type=geocoding&token=#{configuration.api_key}&format=json&q=#{query.sanitized_text}"
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)
      return doc
    end
  end
end