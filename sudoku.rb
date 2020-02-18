class Sudoku
# Takes a board as a string in the format
# you see in the puzzle file. Returns
# something representing a board after
# your solver has tried to solve it.
# How you represent your board is up to you!
  attr_accessor :game_board
  def initialize(board_string)
    @game_board = board_string
  end

  def solve
  end

  # Returns a boolean indicating whether or not the provided board is solved.
  def finished?
  end

  def board
    return game_board
  end

  # Returns a string representing the current state of the board, well formatted for output to the screen. No `puts` here!
  def to_s
    output = ""
    game_board.each_char.with_index do |char, index|
        output += "#{char} "
        if (index + 1) % 9 == 0
            output += "\n"
        end
    end
    return output
  end
end

puzzle = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

game = Sudoku.new(puzzle)
puts game