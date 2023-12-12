require_relative 'board'
require_relative 'players'

class ConnectFour
  def initialize
    @board = Board.new
    @players = Players.new
  end

  def play
    @board.draw_board
    @players.player_name
    @board.draw_board
    game_loop
  end

  def game_loop
    until @board.game_over? do
      @players.update_current_player
      marker = @players.player_marker
      puts "#{@players.current_player} its your turn"
      column = gets.chomp.to_i
      @board.place_marker(column, marker)
      @board.draw_board
      @board.game_over? ? break : @board.tie_game
    end
    @board.end_game_cond(@players.current_player)
  end
end

class Interface
  def initialize
    puts <<~HEREDOC

    CONNECT FOUR 

    Welcome the CONNECT FOUR GAME!

    The goal is to connect four pieces either HORIZONTALLY, VERTICALLY OR DIAGONALLY

    Wins the player who manages to connect four pieces first

    Good Luck and Have Fun!

    HEREDOC
  end

  def play_game
    game = ConnectFour.new
    game.play
  end
end

start = Interface.new
start.play_game
