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

  def horizontal_win?
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
    tie_game || horizontal_win? || diagonal_win || vertical_win
  end

  def end_game_cond
    if horizontal_win?
      puts 'it was a horizontal win'
    elsif diagonal_win
      puts 'it was a diagonal win'
    elsif vertical_win
      puts 'it was a vertical win'
    elsif tie_game
      puts 'game ended in a draw'
    else
      puts 'keep playing'
    end
  end
end