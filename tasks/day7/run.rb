# frozen_string_literal: true

module Tasks
  module Day7
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        begs_specification.call
      end

      def call2
        begs_specification.call2
      end

      def begs_specification
        Inputs::BegSpecification.new(INPUT_FILE_PATH).call
      end
    end
  end
end
