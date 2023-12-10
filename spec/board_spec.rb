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

  describe '#place_marker' do
    context 'shows the board and marker in it' do
      before do
        allow(board).to receive(:draw_board)
        allow(board).to receive(:game_over?).and_return(false)
      end
      it 'returns marker of player in a board' do
        player_marker = 'O'
        column = 1
        board.place_marker(column, player_marker)
        expect(board.board[5][column - 1]).to eq(player_marker)
      end

      it 'checks if column is full and returns an error' do
        new_marker = 'X'
        old_marker = 'O'
        column = 3
        board.place_marker(column, old_marker)
        board.place_marker(column, new_marker)
        board.place_marker(column, old_marker)
        board.place_marker(column, new_marker)
        board.place_marker(column, old_marker)
        board.place_marker(column, new_marker)
        error_message = 'Invalid choice, the column is already full'
        new_placement = board.place_marker(column, new_marker)
        expect(new_placement).to eq(error_message)
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

  describe '#tie_game' do
    context 'it checks if the game ended with tie' do
      before do
        draw = Array.new(6) { Array.new(7, 'X') }
        allow(board).to receive(:horizontal_win?).and_return(false)
        allow(board).to receive(:diagonal_win).and_return(false)
        allow(board).to receive(:vertical_win).and_return(false)
        board.instance_variable_set(:@board, draw)
      end
      it 'returns true if the game ended with DRAW' do
        expect(board.tie_game).to be true
      end
    end
  end

  describe '#game_over' do
    context 'it checks if the game has ended' do
      before do
        allow(board).to receive(:horizontal_win?).and_return(false)
        allow(board).to receive(:diagonal_win).and_return(true)
        allow(board).to receive(:vertical_win).and_return(false)
        allow(board).to receive(:tie_game).and_return(false)
      end
      it 'returns true if the game ended' do
        expect(board.game_over?).to be true
      end
    end
  end
  
  describe '#end_game_cond' do
    context 'it shows appropriate message of the game' do
      it 'shows the message of the win' do
        allow(board).to receive(:horizontal_win?).and_return(true)
        message = "it was a horizontal win\n"
        expect { board.end_game_cond }.to output(message).to_stdout
      end

      it 'shows the message of the tie game' do
        allow(board).to receive(:horizontal_win?).and_return(false)
        allow(board).to receive(:diagonal_win).and_return(false)
        allow(board).to receive(:vertical_win).and_return(false)
        allow(board).to receive(:tie_game).and_return(true)
        tie_message = "game ended in a draw\n"
        expect { board.end_game_cond }.to output(tie_message).to_stdout
      end
    end
  end
end