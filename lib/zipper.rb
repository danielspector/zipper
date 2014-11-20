require "zipper/version"
require "zipper/finder"
require 'pry'
require 'faraday'
require 'hashie'
require 'json'
require "active_support/all"


module Zipper
  class Zip
    class << self
      def find(zip_code)
        make_request(url, zip_code)
      end

      def url
        "http://api.zippopotam.us/us"
      end

      def connection
        @connection ||= Faraday.new
      end

      private

      def make_request(url, zip_code)
        url = "#{url}/#{zip_code}" if zip_code.to_i > 0 && zip_code.to_s.length == 5
        response = get(url)
        if response.success?
          result = generate_parsed_response(response)
          binding.pry
          return result
        end
      end

      def generate_parsed_response(response)
        places = JSON.parse(response.body)["places"].first
        new_places_hash = {}
        places.each do |key, value|
          new_places_hash[key.gsub(" ", "_")] = value
        end
        return Zipper::Finder.new(new_places_hash)
      end

      def get(path)
        connection.get(path)
      end
    end
  end
end
