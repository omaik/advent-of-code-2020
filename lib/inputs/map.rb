# frozen_string_literal: true

module Inputs
  class Map < Base
    def call
      @input.split("\n").map { |line| line.split('') }
    end
  end
end
