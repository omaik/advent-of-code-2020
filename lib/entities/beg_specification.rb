# frozen_string_literal: true

module Entities
  class BegSpecification
    def initialize(lines)
      @parsed_lines = parsed_lines(lines)
      @map = {}
      @shiny_gold_counters = []
      @begs_sum = 0
    end

    def call
      create_map
      traverse_map
      @shiny_gold_counters.uniq.count
    end

    def call2
      create_map
      traverse_from_shiny_gold_map
    end

    def traverse_from_shiny_gold_map
      shiny_gold = @parsed_lines.detect(&:shiny_gold?)

      aggregate_begs(shiny_gold.contained_colors)
      @begs_sum
    end

    def aggregate_begs(colors, multiplier = 1)
      colors.each do |count, color|
        @begs_sum += count.to_i * multiplier
        dependent_line = find_line(color)
        aggregate_begs(dependent_line.contained_colors, multiplier * count.to_i)
      end
    end

    def create_map
      @parsed_lines.each do |line|
        @map.merge!(line.to_map)
      end
    end

    def traverse_map
      @parsed_lines.each do |line|
        @original_line = line.color
        traverse_one(line)
      end
    end

    def traverse_one(line)
      line.contained_colors.each do |_count, color|
        dependent_line = find_line(color)
        if dependent_line.shiny_gold?
          @shiny_gold_counters << @original_line

          break
        end
        traverse_one(dependent_line)
      end
    end

    def find_line(color)
      @parsed_lines.detect { |x| x.color == color }
    end

    private

    def parsed_lines(lines)
      lines.split("\n").map { |x| Beg.new(x) }
    end
  end
end
