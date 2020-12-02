# frozen_string_literal: true

module Entities
  class Password
    def initialize(line)
      @line = line

      parse_line
    end

    def valid_by_amount?
      (@start.to_i..@end.to_i).include?(@text.count(@letter))
    end

    def valid_by_position?
      (@text[@start.to_i - 1] + @text[@end.to_i - 1]).count(@letter) == 1
    end

    private

    def parse_line
      @start, @end, @letter, @text = @line.match(/(\d+)-(\d+) (\w): (\w+)/)[1..4]
    end
  end
end
