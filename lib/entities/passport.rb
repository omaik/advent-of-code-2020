module Entities
  class Passport
    HEIGHT_VALIDATOR = lambda { |x|
      match = x.match(/(\d+)(cm|in)/)
      return false unless match

      num, unit = match[1..2]
      range = (unit == 'cm' ? 150..193 : 59..76)
      range.include?(num.to_i)
    }

    REQUIRED_KEYS = %w[byr iyr eyr hgt hcl ecl pid].freeze
    VALIDATORS = { 'byr' => ->(x) { (1920..2002).include?(x.to_i) },
                   'iyr' => ->(x) { (2010..2020).include?(x.to_i) },
                   'eyr' => ->(x) { (2020..2030).include?(x.to_i) },
                   'hgt' => HEIGHT_VALIDATOR,
                   'hcl' => ->(x) { /^#[0-9a-f]{6,6}$/ === x },
                   'ecl' => ->(x) { %w[amb blu brn gry grn hzl oth].include?(x) },
                   'pid' => ->(x) { /^\d{9,9}$/ === x } }.freeze

    def initialize(line)
      @line = line
    end

    def valid_by_keys?
      (REQUIRED_KEYS - attributes.keys).empty?
    end

    def valid_by_values?
      VALIDATORS.all? { |k, v| attributes[k] && v.call(attributes[k]) }
    end

    def attributes
      @attributes ||= @line.scan(/(\w+):(\S*)/).to_h
    end
  end
end
