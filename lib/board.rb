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

  def vertical_win?

  end
end