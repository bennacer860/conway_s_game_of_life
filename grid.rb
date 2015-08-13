require 'pry'
require_relative './cell.rb'
class Grid
  attr_reader :board
  
  def initialize(width=40,height=40)
    @width  = width
    @height = height
    @board = Array.new(@width){ Array.new(@height)}
    initialize_the_board
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
    (0 <= x and x < @width) and ( 0<= y and  y < @height)
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

