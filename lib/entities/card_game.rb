$game_id = 0
module Entities
  class CardGame
    def initialize(player1_input, player2_input)
      @player1_stack = player1_input.split("\n").map(&:to_i)
      @player2_stack = player2_input.split("\n").map(&:to_i)
      $game_id += 1
      @turns = []
    end

    def call
      play_game

      calculate_result
    end

    def play_sub_game
      res = play_game

      if res == 'shit'
        puts [$game_id, 'shit happened']
        1
      else
        @player1_stack.empty? ? 2 : 1
      end
    end

    def play_game
      loop do
        break if @player1_stack.empty? || @player2_stack.empty?
        turn = [@player1_stack.dup, @player2_stack.dup]

        if @turns.include? turn
          break 'shit'
        end

        @turns << turn

        # p [$game_id, @player1_stack, @player2_stack]
        player1_card = @player1_stack.shift
        player2_card = @player2_stack.shift

        if player1_card <= @player1_stack.size && player2_card <= @player2_stack.size
          winner = self.class.new(@player1_stack.first(player1_card).join("\n"), @player2_stack.first(player2_card).join("\n")).play_sub_game
          if winner == 1
            @player1_stack.push(player1_card, player2_card)
          else
            @player2_stack.push(player2_card, player1_card)
          end
        elsif player1_card > player2_card
          @player1_stack.push(player1_card, player2_card)
        else
          @player2_stack.push(player2_card, player1_card)
        end
      end
    end

    def calculate_result
      stack = @player1_stack.empty? ? @player2_stack : @player1_stack

      stack.reverse.each.with_index(1).inject(0) do |accum, (el, index)|
        accum + el * index
      end
    end
  end
end
