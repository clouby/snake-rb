# Dependencies
require_relative "./view/ruby2d"
require_relative "./model/state"

class App
    def start
        view = View::Ruby2dView.new
        initial_state = Models::initial_state
        view.render(initial_state)
    end

    def init_timer
        loop do
            sleep 0.5
            # Trigger movement

        end
    end
end

module Directions
    UP = :up
    DOWN = :down
end

next_direction = :up

case next_direction
when :up 
    puts "You press UP"
when :down
    puts "You press DOWN"
end