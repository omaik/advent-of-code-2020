# frozen_string_literal: true

module Tasks
  module Day5
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt"

      def call1
        seats.max_by(&:seat_id).seat_id
      end

      def call2
        sorted_seats = seats.map(&:seat_id).sort
        ((sorted_seats.first..sorted_seats.last).to_a - sorted_seats).first
      end

      def seats
        Inputs::Seat.new(INPUT_FILE_PATH).call
      end
    end
  end
end
