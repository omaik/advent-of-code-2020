module Entities
  class Meals
    def initialize(input)
      @meals = input.split("\n").map { |x| Meal.new(x) }
      @allergens = Hash.new { |h, k| h[k] = Allergen.new(k) }
      @result = {}
    end

    def call
      @meals.each do |meal|
        meal.set_allergents(@allergens)
      end

      loop do
        allergen = @allergens.detect do |k, a|
          a.ingridients.count == 1
        end[1]

        ingridient = allergen.ingridients.first
        @result[allergen.name] = ingridient

        @allergens.delete(allergen.name)
        @allergens.each do |k, all|
          all.delete_ingridient(ingridient)
        end

        break if @allergens.empty?
      end

      @meals.inject(0) { |acc, meal| acc + (meal.ingridients - @result.values).count }

      @result.to_a.sort_by { |x| x[0] }.map { |x| x[1] }.join(',')
    end
  end
end


module Entities
  class Meal

    attr_reader :ingridients
    def initialize(input)
      @ingridients, @allergens = input.match(/(.*) \(contains(.*)\)/)[1..2]

      @ingridients = @ingridients.split(' ')
      @allergens = @allergens.strip.split(', ')
    end

    def set_allergents(accum)
      @allergens.each do |i|
        accum[i].ingridients_list << @ingridients
      end
    end
  end
end


module Entities
  class Allergen
    attr_accessor :name, :ingridients_list
    def initialize(name)
      @name = name
      @ingridients_list = []
    end

    def ingridients
      @ingridients_list.reduce(&:&)
    end

    def delete_ingridient(i)
      @ingridients_list.each { |x| x.delete(i)}
    end
  end
end
