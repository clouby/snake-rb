# Dependencies
require_relative "./view/ruby2d"
require_relative "./model/state"
require_relative "./actions/actions"

class App
    CURR_SPEED = 0.5
    
    def initialize
        @state = Models::initial_state
    end

    def start
        @view = View::Ruby2dView.new(self)
        timer_thread = Thread.new { init_timer(@view) }
        @view.start(@state)
        timer_thread.join
    end

    def init_timer(view)
        loop do
            if @state.game_finished
                puts "GAME OVER!"
                puts "SCORE: #{@state.snake.positions.length}"
                break
            end
            # Trigger movement
            @state = Actions::move_snake(@state)
            view.render(@state)
            sleep Actions::change_speed(@state, CURR_SPEED)
        end
    end

    def speed_runner(state)
        SPEED - (0.05 * ( state.snake.positions.length / 2 ))
    end

    def send_action(action, params)
        new_state = Actions.send(action, @state, params)
        if new_state.hash != @state.hash
            @state = new_state
            @view.render(@state)
        end
    end
end

app = App.new
app.start
