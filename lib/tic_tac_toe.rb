class TicTacToe

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end
  
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player) #edit for OO
      display_board
    else
      turn
    end
  end

  def turn_count
    turns = 0
    @board.each do |player|
      if player == "X" or player == "O"
        turns += 1
      end
    end
    return turns
  end

  def current_player
    turns = turn_count
    return turns % 2 == 0 ? "X":"O"
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]
      win_val1 = @board[win_index_1]
      win_val2 = @board[win_index_2]
      win_val3 = @board[win_index_3]
      if win_val1 == win_val2 && win_val2 == win_val3 && position_taken?(win_index_1)
        return combo
      end
    end
    return false
  end

  def full?
    @board.detect{|val| val == " "} ? false : true
  end

  def draw?
    won? ? false :full?
  end

  def over?
    (won? || draw?) ? true : false
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    until over? do
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end

  end
end
