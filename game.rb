# frozen_string_literal: true

# board should be an object, each row should be an object of 3 values
# each value should start blank but either be made X or O by user input
# a method or object state should track the turn number and which player's turn it currently is

class Game
  attr_accessor(:array, :turn, :player_turn)

  def initialize(array)
    @turn = 1
    @player_turn = 'O'
    @array = array
  end

  def increment_turn
    self.turn += 1
    self.player_turn = self.turn.even? ? 'X' : 'O'
  end

  def draw_board
    puts self.array[0].join(' ')
    puts self.array[1].join(' ')
    puts self.array[2].join(' ')
    puts self.array[3].join(' ')
  end
end

def update_board(play, current_game)
  play_arr = play.split(',')
  current_game.array.each_with_index do|value,index| 
    if play_arr[0] == index.to_s 
      value.each_with_index do|v,i| 
        if i.to_s == play_arr[1] 
          return current_game.array[index][i] == '_' ? current_game.array[index][i] = current_game.player_turn  : 'invalid play'
        end 
      end
    end
  end
end

def check_for_tie(current_game)
  if current_game.array.all? {|array| array.all? {|sub_array| sub_array != '_'}}
    true
  end
end

def check_for_winner(current_game)
  if current_game.array[1][1] == current_game.player_turn && current_game.array[1][2] == current_game.player_turn && current_game.array[1][3] == current_game.player_turn
    true
  else
    false
  end
end

current_game = Game.new([%w[+ 1 2 3], %w[1 _ _ _], %w[2 _ _ _], %w[3 _ _ _]])
puts 'Lets play Tic-Tac-Toe!'
puts 'Enter the row number and column number (separated by a comma) you wish to play'
current_game.draw_board

def playing(current_game)

  while true
    puts "It is now round: #{current_game.turn}. Player #{current_game.player_turn}'s turn"
    play = gets.chomp
    if update_board(play, current_game) != 'invalid play'
      current_game.draw_board
      if check_for_winner(current_game)
        puts "Game Over: Player #{current_game.player_turn} wins the game!"
        break
      end
      if check_for_tie(current_game)
        puts "Game Over: It's a tie!"
        break
      else
        current_game.increment_turn
      end
    end
  end
  
end

playing(current_game)
