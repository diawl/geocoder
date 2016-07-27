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
      "#{protocol}://ap1.unwiredlabs.com/v2/address.php?" + url_query_string(query)
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)
      puts doc
      if doc['status'] == "OK"
        return doc
      elsif doc['status'] == "error"
        puts doc['message']
        return []
      end
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