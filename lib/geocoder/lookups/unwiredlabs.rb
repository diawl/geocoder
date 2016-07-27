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
      "#{protocol}://ap1.unwiredlabs.com/v2/address.php?type=#{type}&token=#{configuration.api_key}&format=#{format}q=#{query_params}"
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)

      if doc['error']
        if doc['error'] == 'invalid API key'
          raise_error(Geocoder::InvalidApiKey) || Geocoder.log(:warn, 'Invalid unwiredlabs API key.')
        else
          Geocoder.log(:warn, "Unwiredlabs API error: #{doc['error']}.")
        end

        return []
      else
        return [ doc ]
      end
    end
  end
end