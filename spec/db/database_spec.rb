describe Database do
  after { ENV['APP_ENV'] = 'test' }

  describe '.db' do
    context 'when the environment is test' do
      before { ENV['APP_ENV'] = 'test' }

      it 'returns a SQLite3::Database object with test.db' do
        expect(described_class.db).to be_a(SQLite3::Database)
        expect(described_class.db.filename).to include('/test.db')
      end
    end

    context 'when the environment is development' do
      before { ENV['APP_ENV'] = 'development' }

      it 'returns a SQLite3::Database object with cramming.db' do
        expect(described_class.db).to be_a(SQLite3::Database)
        expect(described_class.db.filename).to include('/cramming.db')
      end
    end

    context 'when the environment is not test or development' do
      before { ENV['APP_ENV'] = 'production' }

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

    it 'deletes the database file' do
      described_class.setup
      expect(File.exist?(file_db)).to be_truthy
      described_class.drop
      expect(File.exist?(file_db)).to be_falsey
    end
  end
end
