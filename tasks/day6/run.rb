# frozen_string_literal: true

module Tasks
  module Day6
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        groups.map(&:total_questions_answered).sum
      end

      def call2
        groups.map(&:questions_answered_by_all_people).sum
      end

      def groups
        Inputs::QuestionGroup.new(INPUT_FILE_PATH).call
      end
    end
  end
end
