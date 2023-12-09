class Quiz
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def call; end
end
