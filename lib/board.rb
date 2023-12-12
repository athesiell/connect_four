class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def draw_board
    @board.each do |row|
      puts row.join('|')
    end
    puts'--------------'
    puts '1 2 3 4 5 6 7'
    @board
  end

  def place_marker(column, marker)
    row_position = 5
    while row_position >= 0
      if @board[row_position][column - 1] == ' '
        @board[row_position][column - 1] = marker
        return true
      end
      row_position -= 1
    end
    'Invalid choice, the column is already full'
  end

  def horizontal_win
    @board.each do |row|
      return true if row[0..3].all? { |cell| cell == row[0] && cell != ' ' } 
      return true if row[1..4].all? { |cell| cell == row[1] && cell != ' ' } 
      return true if row[2..5].all? { |cell| cell == row[2] && cell != ' ' } 
      return true if row[3..6].all? { |cell| cell == row[3] && cell != ' ' } 
    end
    false
  end

  def vertical_win
    (0..6).each do |i|
      (0..2).each do |j|
        if @board[j][i] == @board[j+1][i] && 
          @board[j+1][i] == @board[j+2][i] && 
          @board[j+2][i] == @board[j+3][i] && 
          @board[j][i] != ' '
          return true
        end
      end
    end
    false
  end

  def diagonal_win
    (0..6).each do |i|
      (0..5).each do |j|
        if @board[j][i] == @board[j-1][i-1] &&
           @board[j-1][i-1] == @board[j-2][i-2] &&
           @board[j-2][i-2] == @board[j-3][i-3] &&
           @board[j][i] != ' '
           return true
        elsif @board[j][i] == @board[j-1][i+1] &&
          @board[j-1][i+1] == @board[j-2][i+2] &&
          @board[j-2][i+2] == @board[j-3][i+3] &&
          @board[j][i] != ' '
          return true
        end
      end
    end
    false
  end

  def tie_game
    @board.each do |row|
      return false if row.include?(" ")
    end
    true
  end

  def game_over?
    tie_game || horizontal_win || diagonal_win || vertical_win
  end

  def end_game_cond(player)
    if horizontal_win
      puts "#{player} you win with 4 horizontal pieces"
    elsif diagonal_win
      puts "#{player} you win with 4 diagonal pieces"
    elsif vertical_win
      puts "#{player} you win with 4 vertical pieces"
    elsif tie_game
      puts 'Nobody won, game ended in a draw'
    end
  end
end