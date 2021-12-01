# frozen_string_literal: true

module Entities
  module Commands
    class Collection
      def initialize(text)
        @text = text
        @context = Context.new
        create_commands
        @corrector = Corrector.new(@commands)
      end

      def call!(commands = @commands)
        loop do
          break if @context.position >= commands.size

          commands[@context.position].execute(@context)
        end
      end

      def call_with_correction
        commands = @corrector.commands
        @context = Context.new
        call!(commands)
        @context.acc
      rescue InfiniteLoop
        retry
      end

      def call
        call!
      rescue StandardError => e
        e.acc
      end

      def create_commands
        @commands = @text.split("\n").map { |x| One.new(x) }
      end
    end
  end
end
