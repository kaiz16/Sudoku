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
    # Pseudocode
    # 0 - Make a hash that will keep track of all possible numbers in each row and column. Let's just call it backtrack.
    # 1 - Loop while game hasn't finished
    # 2 - Find an empty space
    # 3 - Add it to the backtrack with row and column as key and empty array as value.
    # 5 - Loop from 1 to 9
    #  5a - Push it to the value (array) in step 3 if a number doesn't present in row, column and square
    # 6 - Make a condition that runs when we have no possible number for the cell.
      # 6a - Set the row and column of board to be empty (This resets the cell)
      # 6b - Delete the key and value from the hash (Because we set and added it to backtrack in step 3)
      # 6c - Set the row, column to backtrack's last row and column. 
      # 6d - Repeat until we have at least one possible number.
    # 7 - Set board's empty cell to the first item of the possible numbers. (board[row][col] = possible numbers's first item)
    # 8 - Delete first item of the possible numbers.
    # 9 - Repeat until board is full
    backtrack = {} 
    while !finished?
      empty_space = find_empty_cell()
      row = empty_space[0]
      col = empty_space[1]
      backtrack[[row, col]] = []
      (1..9).each do |number|
        if is_safe?(row,col,number)
          backtrack[[row, col]] << number
        end
      end
      # This condition only gets executed if we have no possible number
      while backtrack[[row, col]].empty?
        game_board[row][col] = 0
        backtrack.delete([row,col])
        row = backtrack.to_a.last[0][0]
        col = backtrack.to_a.last[0][1]
      end
        game_board[row][col] = backtrack[[row, col]].first
        backtrack[[row,col]].delete(backtrack[[row, col]].first)
    end
  end

  # Returns true if it's safe to place to a number
  def is_safe?(row_index, col_index, number)
    return !find_row(row_index).include?(number) && !find_column(row_index, col_index).include?(number) && !find_square(row_index, col_index).include?(number)
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

  # Returns row of the given cell
  def find_row(rowIndex)
    return game_board[rowIndex]
  end

  # Returns column of the given cell
  def find_column(rowIndex, colIndex, column = [])
    # Base case. Will return column once it's length equals to 9
    return column if column.length == 9
    column << game_board[rowIndex][colIndex]
    # Calling recursive method on the y axis (Both up and down)
        find_column(rowIndex - 1, colIndex, column) || 
        find_column(rowIndex + 1, colIndex, column)
  end

  # Returns cell's 3x3 square or grid
  def find_square(row_index, col_index)
    grid = []
    # Divide and multiply by three to make sure both row and column result at the 0th index of the grid.
    # For ex: If we want 3x3 grid of a cell that is in row 5 and column 6. Row would be at 3 and column would be at 6.
    row = (row_index / 3) * 3
    col = (col_index / 3) * 3
    for i in row..row + 2
        for j in col..col + 2
          grid << game_board[i][j]
        end
    end
    return grid
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