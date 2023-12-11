require './lib/players'

describe Players do
  subject(:plrs) { described_class.new }

  describe '#initialize' do
    context "shows player's markers and names" do
      it 'returns that player1 has marker V' do
        expect(plrs.marker1).to eq('V')
      end

      it 'returns that player2 has marker O' do
        expect(plrs.marker2).to eq('O')
      end

      it 'returns default name of player 1' do
        expect(plrs.player1).to eq('Player 1')
      end

      it 'returns default name of player 2' do
        expect(plrs.player2).to eq('Player 2')
      end
    end
  end
  
  describe '#player_name' do
    before do
      allow(plrs).to receive(:puts)
      allow(plrs).to receive(:gets).and_return("Joe\n", "Michael\n")
    end

    it 'sets names for player 1 and player 2' do
      plrs.player_name
      expect(plrs.instance_variable_get(:@player1)).to eq('Joe')
      expect(plrs.instance_variable_get(:@player2)).to eq('Michael')
    end

    it 'does not overwrite default names if empty input' do
      allow(plrs).to receive(:gets).and_return("\n", "\n")
      plrs.player_name
      expect(plrs.instance_variable_get(:@player1)).to eq('Player 1')
      expect(plrs.instance_variable_get(:@player2)).to eq('Player 2')
    end
  end

  describe '#current_player' do
    context 'shows the current player' do
      before do
        plrs.current_player
      end
      it 'shows that it is player 1 turn' do
        expect(plrs.player_marker).to eq('V')
      end

      it 'shows that it is player 2 turn' do
        plrs.current_player
        expect(plrs.player_marker).to eq('O')
      end
    end
  end
end