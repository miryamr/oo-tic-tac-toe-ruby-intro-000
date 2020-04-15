require 'pry'
class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
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

  def move(index, player_token = "X")
    @board[index] = player_token
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
      puts "Please enter 1-9:"
      user_input = gets.strip
      index = input_to_index(user_input)
      if valid_move?(index) && current_player
        turn_count
        move(index, player_token = "X")
        display_board
      else
        turn
      end
    end

 def turn_count
   @board.count{|token| token == "X" || token == "O"}
 end

 def current_player
   if turn_count.even?
   return "X"
 else
   return "O"
   end
 end

 def won?
     WIN_COMBINATIONS.detect do |winning_array|
       if @board[winning_array[0]] == @board[winning_array[1]] && @board[winning_array[1]] == @board[winning_array[2]] && position_taken?(winning_array[0])
         return winning_array
       end
     end
   end

   def full?
       @board.all? do |each_index|
         each_index == "X" || each_index == "O"
       end
       end

  def draw?
   !won? && full?
  end

  def over?
   won? || draw?
  end

  def winner
    combo_array = won?
      if combo_array
        return @board[combo_array[0]] #in a winning combo the tokens match so [0] or [1] [2] will all give the same result
      end
      return nil
  end

  def play
  until over?
      turn
  end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
