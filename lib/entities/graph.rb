# frozen_string_literal: true

module Entities
  class GraphChunk
    def initialize(numbers, beginning = 0)
      @numbers = numbers
      @beginning = beginning
    end

    def paths
      @count = 0

      path_branch([@beginning, @numbers[0]], 1)
      path_branch([@beginning], 1)

      @count
    end

    def path_branch(array, index)
      return if index > @numbers.size
      return if chain_broken?(array)

      (@count += 1) && return if array.last == @numbers.max

      path_branch(array + [@numbers[index]], index + 1)
      path_branch(array, index + 1)
    end

    def chain_broken?(array)
      (array.last - array.last(2).first) > 3
    end
  end
end

module Entities
  class Graph
    def initialize(numbers)
      @numbers = numbers
      @beginning = 0
      @destination = numbers.max + 3
    end

    def paths
      chunks = split_by_gap_of_3(@numbers)
      chunks.select { |x| x.size > 1 }.map { |x| GraphChunk.new(x, [x[0] - 3, 0].max).paths }.inject(:*)
    end

    def split_by_gap_of_3(array)
      chunks = []
      index = 0

      array.each_cons(2) do |x, y|
        chunks[index] ||= []

        if y - x < 3
          chunks[index] << x
        else
          chunks[index] << x
          index += 1
        end
      end

      chunks.last << array.last
      chunks
    end
  end
end
