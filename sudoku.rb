class Sudoku
# Takes a board as a string in the format
# you see in the puzzle file. Returns
# something representing a board after
# your solver has tried to solve it.
# How you represent your board is up to you!
  attr_accessor :game_board
  attr_reader :initial_board
  def initialize(board_string)
    @initial_board = board_string # Saves the original state of the board
    @game_board = [] # Store the board as 2D array (Easy to modify and print)
    row = []
    board_string.each_char.with_index do |cell, index|
      row << cell.to_i
      if (index + 1) % 9 == 0
        @game_board << row
        row = []
      end
    end
  end

  def solve
  end

  def find_empty_cell
    game_board.each_with_index do |row, rowIndex|
      row.each_with_index do |col, colIndex|
        if col == 0
          return [rowIndex, colIndex]
        end
      end
    end
    return false
  end

  # Returns a boolean indicating whether or not the provided board is solved.
  def finished?
    return false if game_board.any?{|row| row.include?(0)}
    return true
  end

  # Returns original state of the board
  def board
    initial_board
  end

  # Returns a string representing the current state of the board, well formatted for output to the screen. No `puts` here!
  def to_s
=begin
      -------------------------
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      -------------------------
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      -------------------------
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      | - - - | - - - | - - - | 
      -------------------------
=end
    output = "-" * 25 + "\n" 
    game_board.each_with_index do |row, rowIndex|
      formatter = "| "
      row.each_with_index do |col, colIndex|
        col = "-" if col == 0 # Replace 0s with "-"
        formatter += "#{col} "
        formatter += "| " if (colIndex + 1) % 3 == 0 
      end
      output += formatter + "\n" # new line after each row
      output += "-" * 25 + "\n" if (rowIndex + 1) % 3 == 0 # Add lines if rowIndex is divisable by 3
    end
    return output
  end
end

puzzle = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

game = Sudoku.new(puzzle)
puts game