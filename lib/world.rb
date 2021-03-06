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
    @grid.seed(glider_pattern)
  end

  def glider_pattern
    glider = [[4,0],[4,1],[4,2],[2,1],[3,2]]
  end

  def boat_pattern
    glider = [[0,0],[0,1],[1,0],[2,1],[1,2]]
  end

  def stable_pattern
    # you need at least a 2x2 world
    glider = [[0,0],[1,0],[0,1],[1,1]]
  end

  def execute_moves(moves)
    moves.each{ |order|
      @board[order[:row]][order[:column]].alive = order[:alive]
    }
  end

  def tick(generations)
    0.upto(generations) do
      moves = []
      system("clear")
      @grid.show_board
      sleep(1)

      @board.each_index do |row|
        @board[row].each_index do |column|
          cell = @board[row][column]
          number_of_neighbors =  @grid.number_of_alive_cells_around(row,column) 
          # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
          moves << {row: row, column: column, alive: false} if cell.alive && number_of_neighbors < 2
          # Any live cell with more than three live neighbours dies, as if by overcrowding.
          moves << {row: row, column: column, alive: false} if cell.alive && number_of_neighbors > 3
          # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
          moves << {row: row, column: column, alive: true} if cell.alive && (number_of_neighbors == 2 || number_of_neighbors == 3)
          # Any dead cell with exactly three live neighbours cells will come to life.
          moves << {row: row, column: column, alive: true}if !cell.alive && number_of_neighbors == 3
        end
      end

      # the trick here is to execute all the move at the end of the tick
      execute_moves(moves)
    end
  end

end

# w = World.new(10,10,25)
