# frozen_string_literal: true

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

def input_validator(play_arr)
  valid_plays = %w[1 2 3]
  if valid_plays.include?(play_arr[0]) && valid_plays.include?(play_arr[1])
    true
  else
    false
  end
end

def update_board(play, current_game)
  play_arr = play.split(',')
  if !input_validator(play_arr)
    puts "Invalid Entry: Incorrect Input Format"
    return false
  end
  current_game.array.each_with_index do|value,index| 
    if play_arr[0] == index.to_s 
      value.each_with_index do|v,i| 
        if i.to_s == play_arr[1] 
          if current_game.array[index][i] == '_'
            current_game.array[index][i] = current_game.player_turn
          else
            puts 'Invalid Entry: Play has already been made'
            return false
          end
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
  player = current_game.player_turn
  top_row = current_game.array[1]
  mid_row = current_game.array[2]
  bot_row = current_game.array[3]
  #horizontal wins
  [top_row[1], top_row[2], top_row[3]].all? {|fields| fields == player} ? true :
  [mid_row[1], mid_row[2], mid_row[3]].all? {|fields| fields == player} ? true :
  [bot_row[1], bot_row[2], bot_row[3]].all? {|fields| fields == player} ? true :
  #vertical wins
  [top_row[1], mid_row[1], bot_row[1]].all? {|fields| fields == player} ? true :
  [top_row[2], mid_row[2], bot_row[2]].all? {|fields| fields == player} ? true :
  [top_row[3], mid_row[3], bot_row[3]].all? {|fields| fields == player} ? true :
  #diagnal wins
  [top_row[1], mid_row[2], bot_row[3]].all? {|fields| fields == player} ? true :
  [top_row[3], mid_row[2], bot_row[1]].all? {|fields| fields == player} ? true : false
end

current_game = Game.new([%w[+ 1 2 3], %w[1 _ _ _], %w[2 _ _ _], %w[3 _ _ _]])
puts 'Lets play Tic-Tac-Toe!'
puts 'Enter the row number and column number (separated by a comma) you wish to play'
current_game.draw_board

def playing(current_game)
  puts "It is round: #{current_game.turn}. Player #{current_game.player_turn}'s turn"
  while true
    play = gets.chomp
    if update_board(play, current_game)
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
        puts "It is round: #{current_game.turn}. Player #{current_game.player_turn}'s turn"
      end
    end
  end
end

playing(current_game)
