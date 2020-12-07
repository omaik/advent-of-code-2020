# frozen_string_literal: true

module Inputs
  class BegSpecification < Base
    def call
      Entities::BegSpecification.new(@input)
    end
  end
end
