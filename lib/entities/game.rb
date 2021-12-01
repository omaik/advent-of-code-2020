# frozen_string_literal: true

module Entities
  class Game
    def initialize(starting)
      @game_track = Hash.new { |h, k| h[k] = [] }
      @turn = starting.size
      starting.each.with_index(1) do |el, index|
        @game_track[el] << index
      end
      @last = starting.last
    end

    def play
      loop do
        @last = @game_track[@last].size < 2 ? 0 : @game_track[@last][-1].to_i - @game_track[@last][-2].to_i
        @turn += 1
        @game_track[@last] << @turn

        break if @turn == 30_000_000
      end
      @last
    end
  end
end
