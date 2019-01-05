# Dependencies
require "minitest/autorun"
require "minitest/mock"
require_relative "./../src/actions/actions"
require_relative "./../src/model/state"

class ActionTest < Minitest::Test
    def setup
        @initial_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(7, 4),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )
    end

    def test_move_snake
        expected_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(2, 1),
                Models::Coord.new(1, 1)
                ]),
            Models::Food.new(7, 4),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )

        actual_state = Actions::move_snake(@initial_state)

        assert_equal actual_state, expected_state
    end

    def test_change_direction_invalid
        expected_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(7, 4),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )
        actual_state = Actions::change_direction(@initial_state, Models::Direction::UP)
        assert_equal actual_state, expected_state
    end

    def test_change_direction_valid
        expected_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(7, 4),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )
        actual_state = Actions::change_direction(@initial_state, Models::Direction::DOWN)
        assert_equal actual_state, expected_state
    end

    def test_snake_grow
        initial_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(2, 1),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )

        actual_state = Actions::move_snake(initial_state)
        assert_equal(actual_state.snake.positions, [ 
            Models::Coord.new(2, 1),
            Models::Coord.new(1, 1),
            Models::Coord.new(0, 1)
            ])
    end

    def test_generate_food
        initial_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(2, 1),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )

        expected_state = Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(2, 1),
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(0, 0),
            Models::Grid.new(8, 12),
            Models::Direction::DOWN,
            false
        )

        Actions.stub(:rand, 0) do
            actual_state = Actions::move_snake(initial_state)
            assert_equal actual_state, expected_state
        end
    end
end