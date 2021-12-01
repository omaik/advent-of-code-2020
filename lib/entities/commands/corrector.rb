# frozen_string_literal: true

module Entities
  module Commands
    class Corrector
      def initialize(commands)
        @commands = commands
        @correction_index = 0
        @run = false
      end

      def commands
        correct if @run
        @run = true
        @commands
      end

      def correct
        @correction&.invert
        @correction = @commands[@correction_index..].detect { |x| %w[nop jmp].include?(x.command) }
        raise 'Nothing to correct' unless @correction

        @correction_index = @commands.index(@correction) + 1
        @correction.invert
      end
    end
  end
end
