require_relative 'quiz'

class ControlPanel
  def initialize(collection)
    @quiz = Quiz.new(collection)
  end

  def greetings
    <<-TEXT
      Привет!
      Как дела?
      Рад тебя видеть!
    TEXT
  end
end
