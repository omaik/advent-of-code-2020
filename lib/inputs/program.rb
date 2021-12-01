# frozen_string_literal: true

module Inputs
  class Program < Base
    def call
      Entities::Program.new(@input.split("\n"))
    end
  end
end
