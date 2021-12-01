module Entities
  class Reactor
    def initialize(map)
      @space = Hash.new { |h, k| h[k] = define_z }

      map.split("\n").each.with_index do |line, line_index|
        line.split('').each.with_index do |x, char_index|
          @space[0][line_index][char_index] = x
        end
      end
    end

    def call
      6.times do
        turn
        # write_space

        count = 0
        @space.each do |_index, y|
          y.each do |_i, line|
            count += line.values.count('#')
          end
        end
        count
        # binding.pry
      end
      count = 0
      @space.each do |_index, y|
        y.each do |_i, line|
          count += line.values.count('#')
        end
      end
      count
    end

    def turn
      new_space = Hash.new { |h, k| h[k] = define_z }
      extend_space
      @space.keys.each do |z_index|
        @space[z_index].keys.each do |y_index|
          @space[z_index][y_index].keys.each do |x_index|
            element = @space[z_index][y_index][x_index]
            neighbors = find_neighbors(z_index, y_index, x_index)
            new_element = if element == '#'
                            (2..3).include?(neighbors.count('#')) ? '#' : '.'
                          else
                            neighbors.count('#') == 3 ? '#' : '.'
                          end

            new_space[z_index][y_index][x_index] = new_element
          end
        end
      end

      @space = new_space
    end

    def extend_space
      [@space.keys.min - 1, @space.keys.max + 1].each do |z|
        @space[z]
      end
      @space.values.each do |area|
        [(area.keys.min || 0) - 1, (area.keys.max || 0) + 1].each do |y|
          area[y]
        end

        area.values.each do |line|
         area.keys.each do |x|
            line[x]
          end
        end
      end
    end

    def find_neighbors(z_index, y_index, x_index)
      neighbours = []
      ((z_index - 1)..(z_index + 1)).each do |z|
        ((y_index - 1)..(y_index + 1)).each do |y|
          ((x_index - 1)..(x_index + 1)).each do |x|
            next if x == x_index && y == y_index && z == z_index

            neighbours << @space[z][y][x]
          end
        end
      end
      neighbours
    end

    def define_z
      Hash.new { |h, k| h[k] = define_y }
    end

    def define_y
      Hash.new { |h, k| h[k] = define_x }
    end

    def define_x
      '.'
    end

    def write_space
      @space.sort.each do |z_index, area|
        puts ''
        puts "Z: #{z_index}"
        area.sort.each do |y_index, line|
          next unless line.values.include?('#')

          puts line.sort.map { |x| "#{x[0]}:#{x[1]}" }.join('')
        end
      end
    end
  end
end
