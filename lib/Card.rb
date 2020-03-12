
# Card Class - Question & Answer
class Card
  attr_reader :question, :answer, :index
  
  def initialize(question, answer, index)
    @question = question
    @answer = answer
    @index = index
  end

  def print_card
    puts "-" * 40
    puts "|                                      |"
    puts "  Flashcard ##{index} \n Question: #{question} \n Answer: #{answer}\n "
    # puts
    # puts "-" * 40
  end

  def display_question
    puts @question
  end

  def display_answer
    puts @answer
  end

  def to_a
    [@question, @answer, @index]
  end

  # Any methods I think off that would be handy add here
  # Only add methods as required.
end