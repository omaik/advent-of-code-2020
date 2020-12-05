# frozen_string_literal: true

module Tasks
  module Day3
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      # 247
      def call1(step_left = 3, step_bottom = 1)
        left_position = 0
        top_position = 0
        trees_count = 0

        loop do
          left_position += step_left
          top_position += step_bottom

          break if map[top_position].nil?

          length = map[top_position].length
          trees_count += 1 if map[top_position][left_position % length] == '#'
        end

        trees_count
      end

      # 2983070376
      def call2
        [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map { |x| call1(*x) }.reduce(:*)
      end

      private

      def map
        @map ||= Inputs::Map.new(INPUT_FILE_PATH).call
      end
    end
  end
end
