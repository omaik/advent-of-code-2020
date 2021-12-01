# frozen_string_literal: true

module Tasks
  module Day11
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        seat_map.stabilize
      end

      def call2
        seat_map.stabilize(:next_by_visible)
      end

      def seat_map
        Inputs::SeatMap.new(INPUT_FILE_PATH).call
      end
    end
  end
end
