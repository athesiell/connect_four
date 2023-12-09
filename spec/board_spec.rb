require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initalize' do 
    context 'it creates a board of 6 by 7' do
      it 'creates a row with length of 6' do
        expect(board.board.length).to eq(6)
      end

      it 'creates a columns with length of 7' do
      expect(board.board[0].length).to eq(7)
      end
    end
  end

  describe '#draw_board' do
    context 'it draws a board' do
      it 'returns a drawn board' do
        expected = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "],
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        expect(board.draw_board).to eq(expected)
      end
    end
  end
  
  describe '#horizontal_win' do
    context 'checks for horizontal space' do
      it "returns true if there's horizontal win" do
        some_board = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "],
          ["X", "X", "X", "X", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        board.instance_variable_set(:@board, some_board)
        expect(board.horizontal_win?).to be true
      end

      it 'returns false if there is no win' do
        false_board = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "],
          ["X", "X", "O", "X", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        board.instance_variable_set(:@board, false_board)
        expect(board.horizontal_win?).to be false
      end
    end
  end

  describe '#vertical_win' do
    context 'checks for vertical space' do
      it "returns true if there's vertical win" do
        new_board = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "],
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        board.instance_variable_set(:@board, new_board)
        expect(board.vertical_win).to be true
      end

      it "returns false if there's no vertical win" do
        nowin_board = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", "X", " ", " ", " ", " ", " "],
          [" ", "X", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        board.instance_variable_set(:@board, nowin_board)
        expect(board.vertical_win).to be false
      end
    end
  end

  describe '#diagonal_win' do
    context 'checks for diagonal space' do
      it 'returns true if there is a diagonal win' do
        diag_win = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", " ", "O", " ", " ", " ", " "],
          [" ", " ", " ", "O", " ", " ", " "], 
          [" ", " ", " ", " ", "O", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "]
        ]
        board.instance_variable_set(:@board, diag_win)
        expect(board.diagonal_win).to be true
      end

      it 'return false if there is no diagonal win' do
        diag = [
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", "O", " ", " ", " ", " ", " "], 
          [" ", " ", "X", " ", " ", " ", " "],
          [" ", " ", "O", "X", " ", " ", " "], 
          [" ", " ", "O", "X", "O", " ", " "], 
          [" ", " ", "X", "O", "X", " ", " "]
        ]
        board.instance_variable_set(:@board, diag)
        expect(board.diagonal_win).to be false
      end
    end
  end

end