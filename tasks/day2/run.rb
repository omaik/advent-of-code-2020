# frozen_string_literal: true

module Tasks
  module Day2
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      # 580
      def call1
        passwords.count(&:valid_by_amount?)
      end

      def call2
        passwords.count(&:valid_by_position?)
      end

      private

      def passwords
        Inputs::Password.new(INPUT_FILE_PATH).call
      end
    end
  end
end
