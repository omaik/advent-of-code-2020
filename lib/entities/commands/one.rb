# frozen_string_literal: true

module Entities
  module Commands
    class One
      attr_reader :command

      def initialize(line)
        @command, @arg = line.split(' ')
      end

      def invert
        @command = @command == 'nop' ? 'jmp' : 'nop'
      end

      def execute(context)
        @context = context
        execute_add if @command == 'acc'
        execute_jmp if @command == 'jmp'
        execute_nop if @command == 'nop'
      end

      def execute_add
        @context.add(@arg.to_i)
        @context.jump(1)
      end

      def execute_jmp
        @context.jump(@arg.to_i)
      end

      def execute_nop
        @context.jump(1)
      end
    end
  end
end
