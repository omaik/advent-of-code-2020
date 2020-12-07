# frozen_string_literal: true

module Entities
  class QuestionGroup
    def initialize(line)
      @line = line
      parse_line
    end

    def total_questions_answered
      @questions.uniq.count
    end

    def questions_answered_by_all_people
      @questions_per_person.reduce(:&).count
    end

    private

    def parse_line
      @questions = @line.gsub(/\W/, '').split('')
      @questions_per_person = @line.split("\n").map(&:strip).map { |x| x.split('') }
    end
  end
end
