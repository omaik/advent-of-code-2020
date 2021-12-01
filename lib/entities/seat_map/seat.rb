# frozen_string_literal: true

module Entities
  class SeatMap
    class Seat
      DIRECTIONS = [
        proc { |y, x| [y - 1, x - 1] },
        proc { |y, x| [y - 1, x + 1] },
        proc { |y, x| [y - 1, x] },
        proc { |y, x| [y, x - 1] },
        proc { |y, x| [y, x + 1] },
        proc { |y, x| [y + 1, x + 1] },
        proc { |y, x| [y + 1, x - 1] },
        proc { |y, x| [y + 1, x] }
      ].freeze

      attr_reader :y, :x, :char, :map

      def initialize(y, x, char, map)
        @y = y
        @x = x
        @char = char
        @map = map
      end

      def next_position
        return 'L' if char == '#' && neighbours.map(&:char).count('#') >= 4
        return '#' if char == 'L' && neighbours.map(&:char).count('#').zero?

        char
      end

      def next_by_visible
        return 'L' if char == '#' && visibles.map(&:char).count('#') >= 5
        return '#' if char == 'L' && visibles.map(&:char).count('#').zero?

        char
      end

      def neighbours
        [
          [y - 1, x - 1],
          [y - 1, x + 1],
          [y - 1, x],
          [y, x - 1],
          [y, x + 1],
          [y + 1, x + 1],
          [y + 1, x - 1],
          [y + 1, x]
        ].map do |yy, xx|
          map.fetch(yy, {})[xx]
        end.compact
      end

      def visibles
        DIRECTIONS.map do |direction|
          yy = y
          xx = x
          loop do
            yy, xx = direction.call(yy, xx)
            seat = map.fetch(yy, {})[xx]
            break unless seat
            break seat if seat.char == '#' || seat.char == 'L'
          end
        end.compact
      end
    end
  end
end
