describe Config do
  describe '.database_name' do
    context 'when APP_ENV is test' do
      before { allow(ENV).to receive(:fetch).with('APP_ENV').and_return('test') }

      it 'returns test.db' do
        expect(Config.database_name).to eq('test.db')
      end
    end

    context 'when APP_ENV is development' do
      before { allow(ENV).to receive(:fetch).with('APP_ENV').and_return('development') }

      it 'returns cramming.db' do
        expect(Config.database_name).to eq('cramming.db')
      end
    end

    context 'when APP_ENV is not set' do
      before { allow(ENV).to receive(:fetch).with('APP_ENV').and_return(nil) }

      it 'returns production_cramming.db' do
        expect(Config.database_name).to eq('production_cramming.db')
      end
    end
  end
end
