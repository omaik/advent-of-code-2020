# frozen_string_literal: true

module Inputs
  class Command < Base
    def call
      Entities::Commands::Collection.new(@input)
    end
  end
end
