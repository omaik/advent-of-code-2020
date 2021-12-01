# frozen_string_literal: true

module Entities
  class Program
    def initialize(lines)
      @memory = {}
      @lines = lines
      @mask = nil
    end

    def execute
      @lines.each do |line|
        execute_line(line)
      end
      @memory.values.sum
    end

    def execute2
      @lines.each do |line|
        execute_line2(line)
      end
      binding.pry

      @memory.values.sum
    end

    def execute_line(line)
      set_mask(line) if line.start_with?('mask')
      write_variable(line) if line.start_with?('mem')
    end

    def execute_line2(line)
      set_mask(line) if line.start_with?('mask')
      write_variable_by_mask(line) if line.start_with?('mem')
    end

    def set_mask(line)
      @mask = line.split(' = ')[1]
    end

    def write_variable(line)
      index, value = line.match(/mem\[(\d+)\] = (\d+)/)[1..2]

      byte_code = value.to_i.to_s(2).reverse
      @memory[index] = @mask.reverse.each_char.map.with_index do |c, i|
        if c == 'X'
          byte_code[i] || '0'
        else
          c
        end
      end.reverse.join.to_i(2)
    end

    def write_variable_by_mask(line)
      index, value = line.match(/mem\[(\d+)\] = (\d+)/)[1..2]

      byte_code = index.to_i.to_s(2).reverse
      addresses = @mask.reverse.each_char.map.with_index.with_object([[]]) do |(c, i), agregator|
        byte = case c
               when '0'
                 byte_code[i].to_i
               when '1'
                 1
               when 'X'
                 'X'
               end

        if byte == 'X'
          left = agregator.map { |x| x + [0] }
          right = agregator.map { |x| x + [1] }
          agregator.replace(left + right)
        else
          agregator.each { |x| x << byte }
        end
        # p agregator
        # p ''
        # sleep 1
      end

      addresses.map! { |x| x.reverse.join.to_i(2) }

      addresses.each do |x|
        @memory[x] = value.to_i
      end
    end
  end
end
