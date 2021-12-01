# frozen_string_literal: true

module Inputs
  class ShipInstructions < Base
    def call
      @input.split("\n")
    end
  end
end
