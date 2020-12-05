# frozen_string_literal: true

module Entities
  class Seat
    def initialize(line)
      @line = line
      parse_line
    end

    def seat_id
      @front_position * 8 + @left_position
    end

    private

    def parse_line
      @front_position = convert_to_number(@line[0..6], 'B', 'F')
      @left_position = convert_to_number(@line[7..9], 'R', 'L')
    end

    def convert_to_number(string, one, zero)
      string.gsub(one, '1').gsub(zero, '0').to_i(2)
    end
  end
end
