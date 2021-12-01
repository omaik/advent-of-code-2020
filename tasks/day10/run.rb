# frozen_string_literal: true

module Tasks
  module Day10
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        hash = Hash.new(0)
        adapter_rank = numbers.last + 3
        numbers << adapter_rank
        numbers.unshift(0)
        numbers.each_cons(2) { |x, y| p [x, y]; hash[y - x] += 1 }

        p hash
        p hash[1] * hash[3]
      end

      def call2
        Entities::Graph.new(numbers).paths
      end

      def numbers
        @numbers ||= Inputs::NumberStream.new(INPUT_FILE_PATH).call.sort
      end
    end
  end
end
