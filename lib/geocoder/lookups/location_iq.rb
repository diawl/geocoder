require 'geocoder/lookups/base'
require 'geocoder/results/location_iq'

module Geocoder::Lookup
  class LocationIQ < Base

    def name
      'locationiq.org'
    end

    def supported_protocols
      [:http]
    end

    def required_api_key_parts
      ['api_key']
    end

    def query_url(query)
      "#{protocol}://locationiq.org/v1/search.php?" + url_query_string(query)
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)
      if doc.is_a?(Array)
        return doc
      elsif doc.is_a?(Hash)
        case doc['error']
        when 'No key'
          raise_error(Geocoder::InvalidApiKey) ||
            Geocoder.log(:warn, "LocationIQ Geocoding API error: no token.")
        when 'Invalid key'
          raise_error(Geocoder::InvalidApiKey) ||
            Geocoder.log(:warn, "LocationIQ Geocoding API error: invalid token.")
        end
      end
      return []
    end

    def query_url_params(query)
      params = {
        :format => "json",
        :key => configuration.api_key,
        :q => query.sanitized_text
      }
    end
  end
end