require 'ripper'

module Entities
  class Calculator
    def initialize(string)
      @line = Ripper.tokenize(string).reject { |x| x == ' ' }
    end

    def calculate
      @without_order = true
      calculate_expression(@line.dup)
    end

    def calculate2
      @without_order = false
      calculate_expression(@line.dup)
    end

    def calculate_expression(line)
      loop do
        line = calculate_binary(line)

        break line[0] if line.size == 1
      end
    end

    def calculate_binary(line)
      left = false
      right = false
      operation = false
      loop do
        break if line.empty?
        token = line.shift

        case token.to_s
        when /\d+/
          if left
            right = token
          else
            left = token
          end
        when '('
          line.unshift(*calculate_parentesis(line))
        else
          operation = token
        end

        break if operation && left && right
      end

      if @without_order || operation == '+' || line.empty?
        line.unshift(eval("#{left} #{operation} #{right}"))
      else
        new_right = calculate_expression(line.unshift(right))
        line.replace([])

        line.unshift(eval("#{left} #{operation} #{new_right}"))
      end

      line
    end

    def calculate_parentesis(line)
      left_p_count = 1
      right_p_count = 0

      accum = []
      loop do
        el = line.shift
        if el == '('
          left_p_count += 1
        elsif el == ')'
          right_p_count += 1
          break if right_p_count == left_p_count
        end
        accum << el
      end

      calculate_expression(accum)
    end
  end
end
