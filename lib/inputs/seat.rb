# frozen_string_literal: true

module Inputs
  class Seat < Base
    def call
      @input.split("\n").map { |line| Entities::Seat.new(line) }
    end
  end
end
