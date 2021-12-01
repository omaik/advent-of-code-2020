# frozen_string_literal: true

module Inputs
  class SeatMap < Base
    def call
      Entities::SeatMap.new(@input)
    end
  end
end
