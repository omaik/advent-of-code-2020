# frozen_string_literal: true

module Entities
  class SeatMap
    class SeatLine
      def initialize(line)
        @line = line
      end

      def arrange
        initialize_seats
        @seats.map(&:next_position).join('')
      end

      private

      def initialize_seats
        @seats = @line.split('').map { |c| Seat.new(c) }
        link_seats
      end

      def link_seats
        @seats.each_cons(3) { |x, y, z| y.previous = x; y.next = z }
      end
    end
  end
end
