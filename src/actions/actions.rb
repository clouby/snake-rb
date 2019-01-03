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

    private
    
    def position_is_valid?(state, position)
        is_invalid = ((position.row >= state.grid.rows || position.row < 0) || (position.col >= state.grid.cols || position.col < 0))
        return false if is_invalid
        return !(state.snake.positions.include? position)
    end

    def calc_next_position(state)
        head_position = state.snake.positions.first
        case state.next_direction
        when :UP
            return Models::Coord.new(
                head_position.row - 1,
                head_position.col
            )
        when :DOWN
            return Models::Coord.new(
                head_position.row + 1,
                head_position.col
            )
        when :LEFT
            return Models::Coord.new(
                head_position.row,
                head_position.col - 1
            )
        when :RIGHT
            return Models::Coord.new(
                head_position.row,
                head_position.col + 1
            )
        end
    end

    def move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions
        state.snake.positions = new_positions
        state
    end

    def end_game(state)
        state.game_finished = true
        state
    end
    
end
