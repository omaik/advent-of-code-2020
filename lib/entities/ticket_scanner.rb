module Entities
  class TicketScanner
    def initialize(input)
      @specs, @my_ticket, @nearby_tickets = input.split("\n\n")
      @columns_indexes = Hash.new { |h, k| h[k] = [] }
      @result = {}
      @my_ticket = @my_ticket.split("\n")[1].split(",").map(&:to_i)
    end

    def validators
      @specs.scan(/(\d+)-(\d+) or (\d+)-(\d+)/).map { |x, y, z, a| ->(el) { (x.to_i..y.to_i).include?(el) || (z.to_i..a.to_i).include?(el) } }
    end

    def validate
      @nearby_tickets.split("\n")[1..].map { |line| p validate_line(line) }.flatten.compact.sum
    end

    def find_order
      @columns = @nearby_tickets.split("\n")[1..].reject { |x| validate_line(x).any? }.map { |x| x.split(',') }

      validators.each.with_index do |validator, validator_index|
        (0...validators.length).each do |column_index|
          if @columns.map { |x| x[column_index] }.all? { |el| validator.call(el.to_i) }
            @columns_indexes[validator_index] << column_index
          end
        end
      end

      # puts "finish validating"

      # binding.pry
      loop do
        break if @columns_indexes.all? { |k, v| v.empty? }
        p @result
        p @columns_indexes
        # sleep 1

        @columns_indexes.select { |k, v|(v - @result.values).one? }.each do |k, v|
          @result[k] = v[0]
        end

        @columns_indexes.each do |k, v|
          @result.each_value {|c| v.delete(c) }
        end

      end

      (0..5).map do |x|
        @my_ticket[@result[x]]
      end.inject(:*)
    end

    def validate_line(line)
      line.split(',').map do |number|
        next number.to_i unless validators.any? { |v| v.call(number.to_i) }

        nil
      end.compact
    end
  end
end
