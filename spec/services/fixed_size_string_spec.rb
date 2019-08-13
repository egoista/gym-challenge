RSpec.describe FixedSizeString do
  describe '.convert' do
    context 'when does not pass :center_allign' do
      it 'returns a string of the passed size completed with whitespaces at left' do
        result = described_class.convert('a', 3)
        expect(result).to eq 'a  '
      end
    end

    context 'when does pass :center_allign' do
      it 'returns a string of the passed size centralized with whitespaces' do
        result = described_class.convert('a', 3, center_allign: true)
        expect(result).to eq ' a '
      end
    end
  end
end
