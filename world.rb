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
      @grid.show_board
      @board.each_index do |x|
        @board[x].each_index do |y|
          cell = @board[x][y]
          number_of_neighbors =  @grid.number_of_alive_cells_around(x,y) 
          # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
          cell.alive = false if cell.alive and number_of_neighbors < 2  
          # Any live cell with more than three live neighbours dies, as if by overcrowding.
          cell.alive = false if cell.alive and number_of_neighbors > 3 
          # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
          cell.alive = true if cell.alive and number_of_neighbors > 1 
          # Any dead cell with exactly three live neighbours cells will come to life.
          cell.alive = false if !cell.alive and number_of_neighbors == 3 
        end
      end
    end
  end

end

w = World.new(3,2,4)
