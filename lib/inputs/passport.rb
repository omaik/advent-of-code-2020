# frozen_string_literal: true

module Inputs
  class Passport < Base
    def call
      @input.split("\n\n").map { |x| Entities::Passport.new(x) }
    end
  end
end
