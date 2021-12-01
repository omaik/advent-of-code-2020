# frozen_string_literal: true

module Tasks
  module Day18
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        Inputs::Calculator.new(INPUT_FILE_PATH).call.map(&:calculate).sum
      end

      def call2
        Inputs::Calculator.new(INPUT_FILE_PATH).call.map(&:calculate2).sum
      end
    end
  end
end
