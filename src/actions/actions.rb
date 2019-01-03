require_relative "./../model/state"
# Define module Actions
module Actions
    def self.move_snake(state)
        next_position = calc_next_position(state)
        if position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end
    end

    def self.change_direction(state, direction)
        state
    end

    private
    
        def self.position_is_valid?(state, position)
            is_invalid = ((position.row >= state.grid.rows || position.row < 0) || (position.col >= state.grid.cols || position.col < 0))
            return false if is_invalid
            return !(state.snake.positions.include? position)
        end

        def self.calc_next_position(state)
            head_position = state.snake.positions.first
            case state.next_direction
            when Models::Direction::UP
                return Models::Coord.new(
                    head_position.row - 1,
                    head_position.col
                )
            when Models::Direction::DOWN
                return Models::Coord.new(
                    head_position.row + 1,
                    head_position.col
                )
            when Models::Direction::LEFT
                return Models::Coord.new(
                    head_position.row,
                    head_position.col - 1
                )
            when Models::Direction::RIGHT
                return Models::Coord.new(
                    head_position.row,
                    head_position.col + 1
                )
            end
        end

        def self.move_snake_to(state, next_position)
            new_positions = [next_position] + state.snake.positions[0...-1]
            state.snake.positions = new_positions
            state
        end

        def self.end_game(state)
            state.game_finished = true
            state
        end
    
end
