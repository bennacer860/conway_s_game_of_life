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

  def seed(coordinates)
    coordinates.each do |coordinate|
      seed_a_cell(coordinate[0],coordinate[1])
    end
  end

  def seed_a_cell(row,column)
    # ignore if out of bound
    @board[row][column].alive = true if in_bound?(row,column)
  end

  def number_of_alive_cells_around(row,column)
    alive_neighbors = [
      # |x|-|-|
      # |x|c|-|
      # |x|-|-|
      alive?(row-1, column),
      alive?(row-1, column+1),
      alive?(row-1, column-1),

      # |-|x|-|
      # |-|c|-|
      # |-|x|-|
      alive?(row, column+1),
      alive?(row, column-1),

      # |-|-|x|
      # |-|c|x|
      # |-|-|x|
      alive?(row+1, column),
      alive?(row+1, column+1),
      alive?(row+1, column-1),
    ].count(true)
  end

  private 

  def in_bound?(row,column)
    (0 <= row && row < @width) && ( 0 <= column && column < @width)
  end

  def alive?(row, column)
       exists?(row, column) && @board[row][column].alive
  end

  def exists?(row, column)
      in_bound?(row, column) && @board[row][column]
  end

  def initialize_the_board
    @board.each_index do |row|
      @board[row].each_index do |column|
        @board[row][column] = Cell.new
      end
    end
  end

end
