class World
  def initialize(x, y, generations = 10)
    # size of the world x,y
    @grid = Grid.new(x,y)
    @board = @grid.board
  end

   def tick(generation = 10)
    0.upto(generation) do
      @board.each_index do |x|
        @board[x].each_index do |y|
          cell = @board[x][y]
          # Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
          cell.alive = false if cell.alive and @grid.number_of_alive_cells_around(x,y) < 2  
          # Any live cell with more than three live neighbours dies, as if by overcrowding.
          cell.alive = false if cell.alive and @grid.number_of_alive_cells_around(x,y) > 3 
          # Any live cell with two or three live neighbours lives, unchanged, to the next generation.
          cell.alive = false if cell.alive and @grid.number_of_alive_cells_around(x,y) > 3 
          # Any dead cell with exactly three live neighbours cells will come to life.
          cell.alive = false if !cell.alive and @grid.number_of_alive_cells_around(x,y) == 3 
        end
      end
    end
  end

end



