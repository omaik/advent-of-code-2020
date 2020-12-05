# frozen_string_literal: true

module Tasks
  module Day4
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      # 202
      def call1
        passports.count(&:valid_by_keys?)
      end

      # 137
      def call2
        passports.count { |x| x.valid_by_keys? && x.valid_by_values? }
      end

      def passports
        Inputs::Passport.new(INPUT_FILE_PATH).()
      end
    end
  end
end
