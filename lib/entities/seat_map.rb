# frozen_string_literal: true

module Entities
  class SeatMap
    def initialize(text)
      @text = text
    end

    def stabilize(strategy = :next_position)
      loop do
        initialize_seats

        new_text = @map.each_value.map do |line|
          line.each_value.map(&strategy).join('')
        end.join("\n")

        puts '========'
        puts new_text

        break if @text == new_text

        @text = new_text
      end

      @text.count('#')
    end

    def initialize_seats
      lines = @text.split("\n")
      @map = Hash.new { |h, k| h[k] = {} }
      lines.each.with_index do |line, index|
        line.each_char.with_index do |char, inner_index|
          @map[index][inner_index] = Seat.new(index, inner_index, char, @map)
        end
      end
    end
  end
end
