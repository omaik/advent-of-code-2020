# frozen_string_literal: true

module Inputs
  class QuestionGroup < Base
    def call
      @input.split("\n\n").map { |x| Entities::QuestionGroup.new(x) }
    end
  end
end
