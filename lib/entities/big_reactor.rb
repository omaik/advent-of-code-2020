module Entities
  class BigReactor
    def initialize(map)
      @space = Hash.new { |h, k| h[k] = define_w }

      map.split("\n").each.with_index do |line, line_index|
        line.split('').each.with_index do |x, char_index|
          @space[0][0][line_index][char_index] = x
        end
      end
    end

    def call
      6.times do
        turn
      end
      count = 0
      @space.each do |_index, z|
        z.each do |_ii, y|
          y.each do |_i, line|
            count += line.values.count('#')
          end
        end
      end
      count
    end

    def turn
      new_space = Hash.new { |h, k| h[k] = define_w }
      extend_space
      @space.keys.each do |w_index|
        @space[w_index].keys.each do |z_index|
          @space[w_index][z_index].keys.each do |y_index|
            @space[w_index][z_index][y_index].keys.each do |x_index|
              element = @space[w_index][z_index][y_index][x_index]

              neighbors = find_neighbors(w_index, z_index, y_index, x_index)
              new_element = if element == '#'
                              (2..3).include?(neighbors.count('#')) ? '#' : '.'
                            else
                              neighbors.count('#') == 3 ? '#' : '.'
                            end

              new_space[w_index][z_index][y_index][x_index] = new_element
            end
          end
        end
      end

      @space = new_space
    end

    def extend_z_space(space)
      ((space.keys.min.to_i - 1)..(space.keys.max.to_i + 1)).each do |z|
        space[z]
      end
      space.values.each do |area|
        ((area.keys.min.to_i - 1)..(area.keys.max.to_i + 1)).each do |y|
          area[y]
        end

        area.values.each do |line|
          area.keys.each do |x|
            line[x]
          end
        end
      end
    end

    def extend_space
      [@space.keys.min - 1, @space.keys.max + 1].each do |w|
        @space[w]
      end

      @space.values.each do |z|
        extend_z_space(z)
      end
    end

    def find_neighbors(w_index, z_index, y_index, x_index)
      neighbours = []
      ((w_index - 1)..(w_index + 1)).each do |w|
        ((z_index - 1)..(z_index + 1)).each do |z|
          ((y_index - 1)..(y_index + 1)).each do |y|
            ((x_index - 1)..(x_index + 1)).each do |x|
              next if x == x_index && y == y_index && z == z_index && w == w_index

              neighbours << @space[w][z][y][x]
            end
          end
        end
      end
      neighbours
    end

    def define_w
      Hash.new { |h, k| h[k] = define_z }
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
  end
end
