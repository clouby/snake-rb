# Status Model of the Game

module Models
    module Direction
        UP = :UP
        RIGHT = :RIGHT
        LEFT = :LEFT
        DOWN = :DOWN
    end

    class Coord < Struct.new(:row, :col)
    end

    class Food < Coord
    end

    class Snake < Struct.new(:positions)
    end

    class Grid < Struct.new(:rows, :cols)
    end

    class State < Struct.new(:snake, :food, :grid, :next_direction, :game_finished)
    end

    def self.initial_state
        Models::State.new(
            Models::Snake.new([ 
                Models::Coord.new(1, 1),
                Models::Coord.new(0, 1),
                ]),
            Models::Food.new(7, 4),
            Models::Grid.new(8, 12),
            Direction::DOWN,
            false
        )
    end
end