# frozen_string_literal: true

module Tasks
  module Day13
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        number, buses = data

        step = number

        bus, step = loop do
          bus = buses.detect { |x| (step % x).zero? }
          break [bus, step] if bus

          step += 1
        end

        (step - number) * bus
      end

      def call2
        data = data2

        first = data.shift
        data.each.with_object({ sync_point: 0, step: first[0] }) do |el, options|
          value = options[:sync_point].step(by: options[:step]) do |value|
            break value if ((value + el[1]) % el[0]).zero?
          end

          options[:sync_point] = value
          options[:step] *= el[0]
        end[:sync_point]
      end

      # def call2
      #   p data2
      #   result = data2.each_cons(2).inject(nil) do |step, (element1, element2)|
      #     step ||= element1[0]
      #     p "Step: #{step}"
      #     value =  step.step(by: step) do |value|
      #       p "Value: #{value}"
      #       break value if (value + element2[1]) % element2[0] == 0
      #     end

      #     value.lcm(step)
      #   end

      #   p "Result: #{result}"
      #   data2.map { |x, y| (result + y) % x }
      # end

      def data2
        data = File.readlines(INPUT_FILE_PATH).map(&:strip!)
        data[1].split(',').map.with_index { |x, i| [x, i] }.reject { |x| x[0] == 'x' }.each { |x| x[0] = x[0].to_i }
      end

      def data
        data = File.readlines(INPUT_FILE_PATH).map(&:strip!)
        numbers = data[1].split(',')
        numbers.delete('x')

        [data[0].to_i, numbers.map(&:to_i)]
      end
    end
  end
end
