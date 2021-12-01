# frozen_string_literal: true

module Inputs
  class Tickets < Base
    def call
      Entities::TicketScanner.new(@input)
    end
  end
end
