require 'pry'
require_relative './cell.rb'
class Grid
  attr_reader :board
  
  def initialize(rows=40,columns=40)
    @width  = rows
    @height = columns
    @board = Array.new(@height){ Array.new(@width)}
    initialize_the_board
  end

  def seed_a_cell(x,y)
    # ignore if out of bound
    @board[x][y].alive = true if in_bound?(x,y)
  end

  def number_of_alive_cells_around(x,y)
    neighbors_number = 0
    # |x|-|-|
    # |x|c|-|
    # |x|-|-|

    neighbors_number += 1 if in_bound?(x-1,y) and @board[x-1][y] and @board[x-1][y].alive
    neighbors_number += 1 if in_bound?(x-1,y+1) and @board[x-1][y+1] and @board[x-1][y+1].alive
    neighbors_number += 1 if in_bound?(x-1,y-1) and @board[x-1][y-1] and @board[x-1][y-1].alive

    # |-|x|-|
    # |-|c|-|
    # |-|x|-|

    neighbors_number += 1 if in_bound?(x,y+1) and @board[x][y+1] and @board[x][y+1].alive
    neighbors_number += 1 if in_bound?(x,y-1) and @board[x][y-1] and @board[x][y-1].alive

    # |-|-|x|
    # |-|c|x|
    # |-|-|x|

    neighbors_number += 1 if in_bound?(x+1,y+1) and @board[x+1][y+1] and @board[x+1][y+1].alive
    neighbors_number += 1 if in_bound?(x,y+1) and @board[x][y+1] and @board[x][y+1].alive
    neighbors_number += 1 if in_bound?(x-1,y+1) and @board[x-1][y+1] and @board[x-1][y+1].alive

    neighbors_number
  end

  def in_bound?(x,y)
    (0 <= x and x < @height) and ( 0<= y and  y < @width)
  end
  private

  def initialize_the_board
    @board.each_index{|x|
      @board[x].each_index{|y|
        @board[x][y] = Cell.new
      }
    }
  end


end

