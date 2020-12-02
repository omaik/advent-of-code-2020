# frozen_string_literal: true

require 'require_all'
require_all 'lib'
require_all 'tasks'

day = ENV['TASK_DAY']

puts Module.const_get("Tasks::Day#{day}::Run").new.call1
puts Module.const_get("Tasks::Day#{day}::Run").new.call2
