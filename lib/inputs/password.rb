# frozen_string_literal: true

module Inputs
  class Password < Base
    def call
      @input.split("\n").map { |line| Entities::Password.new(line) }
    end
  end
end
