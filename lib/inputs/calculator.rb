# frozen_string_literal: true

module Inputs
  class Calculator < Base
    def call
      @input.split("\n").map { |x| Entities::Calculator.new(x) }
    end
  end
end
