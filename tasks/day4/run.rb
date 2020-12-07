# frozen_string_literal: true

module Tasks
  module Day4
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        passports.count(&:valid_by_keys?)
      end

      def call2
        passports.count { |x| x.valid_by_keys? && x.valid_by_values? }
      end

      def passports
        Inputs::Passport.new(INPUT_FILE_PATH).call
      end
    end
  end
end
