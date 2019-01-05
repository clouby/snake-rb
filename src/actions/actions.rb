require_relative "./../model/state"
# Define module Actions
module Actions
    def self.move_snake(state)
        next_position = calc_next_position(state)
        if position_is_food?(state, next_position)
            state = grow_snake_to(state, next_position)
            generate_food(state)
        elsif position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end
    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.curr_direction = direction
        else
            puts "Invalid direction"
        end
        state
    end

    def self.change_speed(state, curr_speed)
        curr_speed - ( curr_speed * ( state.snake.positions.length / ( state.grid.rows * state.grid.cols ) ) ) 
    end

    private

        def self.generate_food(state)
            # rand
            new_food = Models::Food.new(rand(state.grid.rows), rand(state.grid.cols))
            state.food = new_food
            state
        end

        def self.position_is_food?(state, next_position)
            (state.food.row == next_position.row) && (state.food.col == next_position.col)
        end

        def self.grow_snake_to(state, next_position)
            new_snake = [next_position] + state.snake.positions
            state.snake.positions = new_snake
            state
        end
    
        def self.position_is_valid?(state, position)
            is_invalid = ((position.row >= state.grid.rows || position.row < 0) || (position.col >= state.grid.cols || position.col < 0))
            return false if is_invalid
            return !(state.snake.positions.include? position)
        end

        def self.calc_next_position(state)
            head_position = state.snake.positions.first
            case state.curr_direction
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

        def self.next_direction_is_valid?(state, direction)
            case state.curr_direction
            when Models::Direction::UP
                return true if direction != Models::Direction::DOWN
            when Models::Direction::DOWN
                return true if direction != Models::Direction::UP
            when Models::Direction::LEFT
                return true if direction != Models::Direction::RIGHT
            when Models::Direction::RIGHT
                return true if direction != Models::Direction::LEFT
            end
            return false
        end
    
end
