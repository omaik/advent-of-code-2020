# frozen_string_literal: true

module Tasks
  module Day8
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        commands.call
      end

      def call2
        commands.call_with_correction
      end

      def commands
        Inputs::Command.new(INPUT_FILE_PATH).call
      end
    end
  end
end
