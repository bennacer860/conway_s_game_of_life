require '../grid.rb'
require "minitest/autorun"

class TestGrid < Minitest::Test
  def setup
    @grid  = Grid.new(3,3)
    @board = @grid.board
  end

  def test_seed_a_cell
    @grid.seed_a_cell(0,0)
    @grid.seed_a_cell(1,1)
    @grid.seed_a_cell(22,33)
    assert @board[0][0].alive, "cell should alive here"
    assert @board[1][1].alive, "cell should alive here"  
  end

  def test_find_the_right_number_of_neighbors
    # add some alive cells 
    # |c|-|-|
    # |-|c|-|
    # |-|-|c|

    @board[0][0].alive = true
    @board[1][1].alive = true
    @board[2][2].alive = true
    assert_equal 1 , @grid.number_of_alive_cells_around(0,0)
    assert_equal 1 , @grid.number_of_alive_cells_around(2,2)
    assert_equal 2 , @grid.number_of_alive_cells_around(1,1)
  end

  def test_a_real_pattern
    # |c|c|-|
    # |c|c|-|
    # |-|-|-|

    @grid.seed_a_cell(0,0)
    @grid.seed_a_cell(1,0)
    @grid.seed_a_cell(0,1)
    @grid.seed_a_cell(1,1)

    assert_equal 3 , @grid.number_of_alive_cells_around(0,0)
    assert_equal 3 , @grid.number_of_alive_cells_around(0,1)
    assert_equal 3 , @grid.number_of_alive_cells_around(1,0)
    assert_equal 3 , @grid.number_of_alive_cells_around(1,1)
  end
end

