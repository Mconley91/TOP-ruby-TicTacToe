# frozen_string_literal: true

# board should be an object, each row should be an object of 3 values
# each value should start blank but either be made X or O by user input
# a method or object state should track the turn number and which player's turn it currently is

class Game
  attr_accessor(:row1, :row2, :row3, :turn, :player_turn)

  def initialize(row1_arr, row2_arr, row3_arr)
    @turn = 1
    @player_turn = 'O'
    @row1 = row1_arr
    @row2 = row2_arr
    @row3 = row3_arr
  end

  def increment_turn
    @turn += 1
    @player_turn = @turn.even? ? 'X' : 'O'
  end

  def draw_board
    puts @row1.join(' ')
    puts @row2.join(' ')
    puts @row3.join(' ')
  end
end

def playing
  current_game = Game.new(%w[_ _ _], %w[_ _ _], %w[_ _ _])
  i = 1
  while i <= 3 # temporary loop for development
    puts 'Lets play Tic-Tac-Toe!'
    puts 'Enter the row number and column number you wish to play'
    puts "It is round: #{current_game.turn}. Player #{current_game.player_turn}'s turn"
    play = gets.chomp
    current_game.increment_turn
    current_game.draw_board
    i += 1 # increments test round
  end
end

playing
