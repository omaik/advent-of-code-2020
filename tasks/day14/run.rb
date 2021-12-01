# frozen_string_literal: true

module Tasks
  module Day14
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        Inputs::Program.new(INPUT_FILE_PATH).call.execute
      end

      def call2
        Inputs::Program.new(INPUT_FILE_PATH).call.execute2
      end
    end
  end
end
