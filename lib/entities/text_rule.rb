module Entities
  class TestRule
    def initialize(text)
      @rules, @string = text.split("\n\n")
      generate_rules
    end

    def call
      binding.pry

      zero_rule = @rules_hash['0'].gsub(' ', '')

      regexp_rule = Regexp.new('^' + zero_rule + '$')

      selected  = @string.split("\n").select do |line|
        regexp_rule.match(line)
      end

      binding.pry
    end

    def generate_rules
      @rules_hash = {}

      @rules.split("\n").each do |rule|
        @index, @rule = rule.match(/(\d+): (.+)$/)[1..2]

        @rules_hash[@index] = @rule.gsub("\"", '')
      end

      @rules_hash.each do |id, rule|
        convert_to_finite(rule)
      end
    end

     def convert_to_finite(rule)
        loop do
          index = rule.match(/\d+/)

          break unless index

          index = index[0]

          nested_rule = @rules_hash[index]

          rule.gsub!(/\b#{index}\b/, ' (' + nested_rule + ') ')
        end
      end
  end
end
