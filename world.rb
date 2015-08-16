require_relative './grid.rb'

class World
  attr_reader :board
  def initialize(width, height, generations = 10)
    # size of the world x,y
    @grid = Grid.new(width,height)
    @board = @grid.board
    seeds
    tick(generations)
  end

  def seeds
    @grid.seed_a_cell(4,0)
    @grid.seed_a_cell(4,1)
    @grid.seed_a_cell(4,2)
    @grid.seed_a_cell(2,1)
    @grid.seed_a_cell(3,2)
  end

  def boat_pattern
    @grid.seed_a_cell(0,0)
    @grid.seed_a_cell(1,0)
    @grid.seed_a_cell(0,1)
    @grid.seed_a_cell(2,1)
    @grid.seed_a_cell(1,2)
  end

  def stable_pattern
    # you need at least a 2x2 world
    @grid.seed_a_cell(0,0)
    @grid.seed_a_cell(1,0)
    @grid.seed_a_cell(0,1)
    @grid.seed_a_cell(1,1)
  end

  def tick(generations)
    0.upto(generations) do
      system("clear")
      @grid.show_board
      sleep(1)
      future_orders = []

      @board.each_index do |row|
        @board[row].each_index do |column|
          cell = @board[row][column]
          number_of_neighbors =  @grid.number_of_alive_cells_around(row,column) 
          # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
          future_orders << {row: row, column: column, alive: false} if cell.alive and number_of_neighbors < 2
          # Any live cell with more than three live neighbours dies, as if by overcrowding.
          future_orders << {row: row, column: column, alive: false} if cell.alive and number_of_neighbors > 3
          # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
          future_orders << {row: row, column: column, alive: true} if cell.alive and (number_of_neighbors == 2 || number_of_neighbors == 3)
          # Any dead cell with exactly three live neighbours cells will come to life.
          future_orders << {row: row, column: column, alive: true}if !cell.alive and number_of_neighbors == 3
        end
      end

      # the trick here is to execute all the move at the end of the tick
      future_orders.each{ |order|
        @board[order[:row]][order[:column]].alive = order[:alive]
      }
    end
  end

end

w = World.new(10,10,5)
