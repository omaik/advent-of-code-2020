# frozen_string_literal: true

module Entities
  class BegSpecification
    class Beg
      attr_reader :color, :contained_colors

      def initialize(line)
        @line = line
        parse_line
      end

      def to_map
        { @color => @contained_colors }
      end

      def shiny_gold?
        @color == 'shiny gold'
      end

      private

      def parse_line
        beginning, ending = @line.split(' contain ')
        @color = beginning.match(/(.+) bags/)[1]
        @contained_colors = ending.split(',').map { |x| (x.match(/(\d+) (\w+ \w+) bag/) || '')[1..2] }.compact
      end
    end
  end
end
