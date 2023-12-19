describe Database do
  describe '.db' do
    context 'when the environment is test' do
      before { allow(Config).to receive(:database_name).and_return('test.db') }

      it 'returns a SQLite3::Database object with test.db' do
        expect(described_class.db).to be_a(SQLite3::Database)
        expect(described_class.db.filename).to include('/test.db')
      end
    end

    context 'when the environment is development' do
      before { allow(Config).to receive(:database_name).and_return('cramming.db') }

      it 'returns a SQLite3::Database object with cramming.db' do
        expect(described_class.db).to be_a(SQLite3::Database)
        expect(described_class.db.filename).to include('/cramming.db')
      end
    end

    context 'when the environment is not test or development' do
      before { allow(Config).to receive(:database_name).and_return('production_cramming.db') }

      it 'returns a SQLite3::Database object with production_cramming.db' do
        expect(described_class.db).to be_a(SQLite3::Database)
        expect(described_class.db.filename).to include('/production_cramming.db')
      end
    end
  end

  describe '.setup' do
    it 'creates tables in the database' do
      described_class.setup
      expect(
        described_class
          .db
          .execute("SELECT name FROM sqlite_master WHERE type='table' AND name='verbs'")
          .empty?
      ).to be_falsey

      expect(
        described_class
          .db
          .execute("SELECT name FROM sqlite_master WHERE type='table' AND name='nouns'")
          .empty?
      ).to be_falsey

      expect(
        described_class
          .db
          .execute("SELECT name FROM sqlite_master WHERE type='table' AND name='adjectives'")
          .empty?
      ).to be_falsey
    end
  end

  describe '.drop' do
    let(:file_db) { described_class.db.filename }

    before { allow(Config).to receive(:database_name).and_return('some_database_name.db') }

    it 'deletes the database file' do
      described_class.setup
      expect(File.exist?(file_db)).to be_truthy
      described_class.drop
      expect(File.exist?(file_db)).to be_falsey
    end
  end
end
