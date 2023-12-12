class Players 
  attr_reader :player1, :player2, :marker1, :marker2, :current_player

  def initialize(player1 = 'Player 1', player2 = 'Player 2')
    @player1 = player1
    @player2 = player2
    @marker1 = 'V'
    @marker2 = 'O'
    @current_player = nil
  end

  def player_name
    puts 'Player 1 your marker is V, what is your name?'
    name1 = gets.chomp
    @player1 = name1 unless name1.empty?

    puts 'Player 2 your marker is O, what is your name?'
    name2 = gets.chomp
    @player2 = name2 unless name2.empty?
  end

  def update_current_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def player_marker
    @current_player == @player1 ? @marker1 : @marker2
  end
end