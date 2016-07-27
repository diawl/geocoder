require 'geocoder/lookups/base'
require 'geocoder/results/unwired_labs'

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
      "#{protocol}://ap1.unwiredlabs.com/v2/address.php?" + url_query_string(query)
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)
      puts doc
      if doc.is_a?(Array)
        return doc
      elsif doc.is_a?(Hash)
        case doc['message']
        when 'INVALID_REQUEST'
          raise_error(Geocoder::InvalidRequest) ||
            Geocoder.log(:warn, "UnwiredLabs Geocoding API error: invalid request.")
        when 'NO_TOKEN'
          raise_error(Geocoder::InvalidApiKey) ||
            Geocoder.log(:warn, "UnwiredLabs Geocoding API error: no token.")
        when 'INVALID_TOKEN'
          raise_error(Geocoder::InvalidApiKey) ||
            Geocoder.log(:warn, "UnwiredLabs Geocoding API error: invalid token.")
        end
      end
      return []
    end

    def query_url_params(query)
      params = {
        :type => "geocoding",
        :token => configuration.api_key,
        :q => query.sanitized_text
      }
    end
  end
end