# frozen_string_literal: true

module Tasks
  module Day16
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        Inputs::Tickets.new(INPUT_FILE_PATH).call.validate
      end

      def call2
        Inputs::Tickets.new(INPUT_FILE_PATH).call.find_order
      end
    end
  end
end
