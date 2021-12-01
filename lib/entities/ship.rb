# frozen_string_literal: true

module Entities
  class Ship
    attr_reader :north_position, :east_position

    def self.move_by_instructions(instructions_list)
      ship = new

      instructions_list.each do |instruction|
        ship.process_command(instruction[0], instruction[1..].to_i)
      end

      ship.north_position.abs + ship.east_position.abs
    end

    def self.move_by_waipoint(instructions_list)
      ship = WaipointShip.new

      instructions_list.each do |instruction|
        ship.process_command(instruction[0], instruction[1..].to_i)
      end

      ship.north_position.abs + ship.east_position.abs
    end

    def initialize
      @north_position = 0
      @east_position = 0
      @direction = %w[E S W N]
    end

    def process_command(command, value)
      @command = command
      @value = value

      process_relocation if %w[N E S W].include?(command)
      process_direction_change if %w[L R].include?(command)
      process_forward if command == 'F'
    end

    private

    def process_relocation
      case @command
      when 'N'
        @north_position += @value
      when 'S'
        @north_position -= @value
      when 'E'
        @east_position += @value
      when 'W'
        @east_position -= @value
      end
    end

    def process_direction_change
      case @command
      when 'L'
        @direction = @direction.rotate(-@value / 90)
      when 'R'
        @direction = @direction.rotate(@value / 90)
      end
    end

    def process_forward
      @command = @direction.first
      process_relocation
    end
  end

  class Waipoint
    attr_accessor :north, :east

    LEFT_DIRECTIONS = {
      'NW' => 'SW',
      'SW' => 'SE',
      'SE' => 'NE',
      'NE' => 'NW'
    }.freeze

    RIGHT_DIRECTIONS = {
      'NW' => 'NE',
      'NE' => 'SE',
      'SE' => 'SW',
      'SW' => 'NW'
    }.freeze

    def initialize(north, east)
      @north = north
      @east = east
      @direction = 'NE'
    end

    def step
      [@direction[0] == 'S' ? -@north : @north, @direction[1] == 'W' ? -@east : @east]
    end

    def rotate(direction, steps)
      @direction_map = get_direction_map(direction)
      steps.times do
        @direction = @direction_map[@direction].clone
      end
      @north, @east = @east, @north if steps.odd?
    end

    def get_direction_map(direction)
      direction == 'L' ? LEFT_DIRECTIONS : RIGHT_DIRECTIONS
    end

    def relocate(side, value)
      relocate_x(side, value) if %w[W E].include?(side)
      relocate_y(side, value) if %w[N S].include?(side)
    end

    def relocate_x(side, value)
      if @direction[1] == side
        @east += value
      else
        @east -= value
        if @east.negative?
          @direction[1] = side
          @east = @east.abs
        end
      end
    end

    def relocate_y(side, value)
      if @direction[0] == side
        @north += value
      else
        @north -= value
        if @north.negative?
          @direction[0] = side
          @north = @north.abs
        end
      end
    end
  end

  class WaipointShip
    attr_reader :north_position, :east_position

    def initialize
      @north_position = 0
      @east_position = 0
      @waypoint = Waipoint.new(1, 10)
    end

    def process_command(command, value)
      @command = command
      @value = value

      if command == 'R'
        p '-------------'
        p @waypoint
      end

      process_relocation if %w[N E S W].include?(command)
      process_direction_change if %w[L R].include?(command)
      process_forward if command == 'F'
      p [command, value, self] if command == 'R'
    end

    def process_relocation
      @waypoint.relocate(@command, @value)
    end

    def process_direction_change
      steps = @value / 90

      @waypoint.rotate(@command, steps)
    end

    def process_forward
      @north_position += @waypoint.step[0] * @value
      @east_position += @waypoint.step[1] * @value
    end
  end
end
