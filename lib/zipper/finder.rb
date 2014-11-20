module Zipper
  class Finder
    attr_accessor :city, :state, :full_state

    def initialize(hash)
      hash.each do |key, value|
        case key
        when "place_name"
          self.city = value
        when "state_abbreviation"
          self.state = value
        when "state"
          self.full_state = value
        end
      end
    end
  end
end
