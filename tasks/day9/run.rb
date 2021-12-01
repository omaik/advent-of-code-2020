# frozen_string_literal: true

module Tasks
  module Day9
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        numbers.each_cons(26).detect { |group| !group[0..-2].combination(2).to_a.map(&:sum).include?(group.last) }.last
      end

      def call2
        number = call1
        agregator = []
        enumerator = numbers.each

        loop do
          if agregator.sum < number
            agregator << enumerator.next
          elsif agregator.sum > number
            agregator.shift
          elsif agregator.sum == number
            break agregator.min + agregator.max
          end
        end
      end

      def numbers
        Inputs::NumberStream.new(INPUT_FILE_PATH).call
      end
    end
  end
end
