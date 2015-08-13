require '../grid.rb'
require "minitest/autorun"

class TestGrid < Minitest::Test
  def setup
    @grid  = Grid.new(3,3)
    @board = @grid.board
  end

  def test_find_the_right_number_of_neighbors
    # add some alive cells 
    # |c|-|-|
    # |-|c|-|
    # |-|-|c|
  
    assert 1
    @board[0][0].alive = true
    @board[1][1].alive = true
    @board[2][2].alive = true
    assert_equal 1 , @grid.number_of_alive_cells_around(0,0)
    assert_equal 1 , @grid.number_of_alive_cells_around(2,2)
    assert_equal 2 , @grid.number_of_alive_cells_around(1,1)
  end


  def test_that_will_be_skipped
    assert 1

  end
end
