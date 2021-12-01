# frozen_string_literal: true

module Entities
  module Commands
    class InfiniteLoop < StandardError
      attr_reader :acc

      def initialize(acc)
        @acc = acc

        super
      end
    end

    class Context
      attr_reader :position, :acc

      def initialize
        @acc = 0
        @position = 0
        @position_stack = [0]
      end

      def add(number)
        @acc += number
      end

      def jump(number)
        @position += number
        raise InfiniteLoop, @acc if @position_stack.include?(@position)

        @position_stack << @position
      end
    end
  end
end
