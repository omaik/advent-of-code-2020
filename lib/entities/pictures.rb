module Entities
  class Picture

    attr_accessor :title, :lines

    def initialize(input)
      @lines = input.split("\n")
      @title = @lines.shift
      @lines.map! { |x| x.split('') }
    end


    def top_border
      @lines[0]
    end

    def bottom_border
      @lines[-1]
    end

    def left_border
      @lines.map { |x| x[0] }
    end

    def right_border
      @lines.map { |x| x[-1] }
    end

    def native_borders
      [top_border, left_border, right_border, bottom_border]
    end

    def reversed_borders
      native_borders.map(&:reverse)
    end

    def borders
      native_borders + reversed_borders
    end
  end

  class Pictures
    def initialize(input)
      @pictures = input.split("\n\n").map { |x| Picture.new(x) }
    end

    def call
      select_top_left.map{|x| x.title}
    end

    def select_top_left
      @pictures.select do |picture|
        (picture.borders - (@pictures - [picture]).map(&:borders).flatten(1).uniq).size == 4
      end
    end
  end
end
