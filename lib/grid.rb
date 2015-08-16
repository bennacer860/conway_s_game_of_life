require_relative './cell.rb'
class Grid
  attr_reader :board

  def initialize(rows=40,columns=40)
    @width  = rows
    @height = columns
    @board = Array.new(@height){ Array.new(@width)}
    initialize_the_board
  end

  def show_board
    @board.each_index do |row|
      @board[row].each_index do |column|
        dispay =  @board[row][column].alive ? 'x': '.'
        print dispay
      end
      puts ""
    end
  end

  def seed_a_cell(row,column)
    # ignore if out of bound
    @board[row][column].alive = true if in_bound?(row,column)
  end

  def number_of_alive_cells_around(row,column)
    neighbors_number = 0
    # |x|-|-|
    # |x|c|-|
    # |x|-|-|

    neighbors_number += 1 if in_bound?(row-1,column) and @board[row-1][column] and @board[row-1][column].alive
    neighbors_number += 1 if in_bound?(row-1,column+1) and @board[row-1][column+1] and @board[row-1][column+1].alive
    neighbors_number += 1 if in_bound?(row-1,column-1) and @board[row-1][column-1] and @board[row-1][column-1].alive
    # |-|x|-|
    # |-|c|-|
    # |-|x|-|

    neighbors_number += 1 if in_bound?(row,column+1) and @board[row][column+1] and @board[row][column+1].alive
    neighbors_number += 1 if in_bound?(row,column-1) and @board[row][column-1] and @board[row][column-1].alive
    # |-|-|x|
    # |-|c|x|
    # |-|-|x|

    neighbors_number += 1 if in_bound?(row+1,column) and @board[row+1][column] and @board[row+1][column].alive
    neighbors_number += 1 if in_bound?(row+1,column+1) and @board[row+1][column+1] and @board[row+1][column+1].alive
    neighbors_number += 1 if in_bound?(row+1,column-1) and @board[row+1][column-1] and @board[row+1][column-1].alive

    neighbors_number
  end

  def in_bound?(row,column)
    (0 <= row and row < @width) and ( 0 <= column and column < @width)
  end

  private

  def initialize_the_board
    @board.each_index do |row|
      @board[row].each_index do |column|
        @board[row][column] = Cell.new
      end
    end
  end

end
