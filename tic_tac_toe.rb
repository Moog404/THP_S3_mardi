


# On attribut  un nom et un symbole pour chaque joueur 
class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

end


class Board
  attr_accessor :case, :stop_game
  def initialize
    @case = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @stop_game = false
  end

  def draw_board
    puts '|-----------------|       |-----------------|'
    puts "|  #{@case[0]}  |  #{@case[1]}  |  #{@case[2]}  |       |  1  |  2  |  3  |"
    puts '|-----------------|       |-----------------|'
    puts "|  #{@case[3]}  |  #{@case[4]}  |  #{@case[5]}  |       |  4  |  5  |  6  |"
    puts '|-----------------|       |-----------------|'
    puts "|  #{@case[6]}  |  #{@case[7]}  |  #{@case[8]}  |       |  7  |  8  |  9  |"
    puts '|-----------------|       |-----------------|'
  end


  def update_board(player)
    puts "#{player.name}(#{player.symbol})à toi de jouer!!! Entre une valeur de 1 à 9"
    print ">"
    value = gets.chomp.to_i
    value -= 1

    if
      @case[value] != ' '
      draw_board
      puts 'Cette case est déja utilisé, entrez une nouvelle valeur pour continuer'
      # @stop_game = true
      return false
    end

    @case[value] = player.symbol

    draw_board

    if win
      puts "#{player.name} à gagné !"
      @stop_game = true
    elsif !(@case.any? { |a| a == ' ' })
      puts 'match nul'
      @stop_game = true
    end
    true
  end

  #sert à verifier si un des joueur à entré une combinaison gagnante
  def win
    if  @case[0] != ' ' && @case[0] == @case[1] && @case[0] == @case[2] ||
        @case[3] != ' ' && @case[3] == @case[4] && @case[3] == @case[5] || 
        @case[6] != ' ' && @case[6] == @case[7] && @case[6] == @case[8] ||
        @case[0] != ' ' && @case[0] == @case[3] && @case[0] == @case[6] || 
        @case[1] != ' ' && @case[1] == @case[4] && @case[1] == @case[7] || 
        @case[2] != ' ' && @case[2] == @case[5] && @case[2] == @case[8] || 
        @case[0] != ' ' && @case[0] == @case[4] && @case[0] == @case[8] || 
        @case[2] != ' ' && @case[2] == @case[4] && @case[2] == @case[6]
      true
    else
      false
   end
  end
end


class Game
  attr_accessor :player1, :player2

  def initialize
    puts 'Entrez le nom du 1er joueur, celui-ci jouera avec les X:'
    print '>'
    @player1 = Player.new(gets.chomp, 'X')
    puts 'Entrez le nom du 2ème joueur: celui-ci jouera avec les O:'
    print '>'
    @player2 = Player.new(gets.chomp, 'O')
  end

  def go
    board = Board.new
    board.draw_board
    turn = true

    until board.stop_game
      # break if board.get_stop_game
    if  turn == true
        turn = false
        turn = !turn unless board.update_board(player1)
      else
        turn = true
        turn = !turn unless board.update_board(player2)
      end
    end
  end
end

Game.new.go

