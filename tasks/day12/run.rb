# frozen_string_literal: true

module Tasks
  module Day12
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        Entities::Ship.move_by_instructions(Inputs::ShipInstructions.new(INPUT_FILE_PATH).call)
      end

      def call2
        Entities::Ship.move_by_waipoint(Inputs::ShipInstructions.new(INPUT_FILE_PATH).call)
      end

      def seat_map; end
    end
  end
end
