
      user_input = TTY::Prompt.new


def greeting
  puts 'Hello welocome to FlashcardApp'
  sleep 1
  puts 'Lets get started 🤗🤗🤗'
end

def get_question_and_answer 
  puts "Whats your question?"
  print "> "
  question = gets.chomp.to_s
  puts "Whats your answer?"
  print ">"
  answer = gets.chomp.to_s
  return [
    question,
    answer
  ]
end 

def print_all_cards(cards)
  cards.each do |card| 
    card.print_card
  end
end

def add_another_card(success: false)
  success_message if success

  sleep 1
  puts "Add another flashcard? (y/n)"
  print ">"

  input = gets.chomp

  return input
end

def success_message
  print "Card Successfully added!"
  puts ""
end

def delete_card_number
  puts "Enter card number:"
  print ">"
  input = gets.chomp

  return input
end

def delete_confirmation(input)
  print "Card #{input} deleted."
  puts ""
  sleep 0.5
end

def incorrect_entry
  puts 'Incorrect entry'
end

def handle_empty_cards
  puts 'There are no cards to delete'
end

def delete_another_card
  sleep 1
  puts "Delete another flashcard? (y/n)"
  print ">"

  input = gets.chomp

  return input
end

def cards_unavailable
  puts "There are no cards available."
end

def selected_card_quantity
  puts "How many cards would you like to practice?"
  input = gets.chomp.to_i

  return input
end

def display_question(card)
  puts "-" * 25
  puts
  puts "Question:"
  puts
  card.display_question
  puts
  print "Write answer: "
  user_answer(card)
  puts 
  puts "-" * 25
end   

def user_answer(card)
  print "> "
  user_input = gets.chomp
  if user_input == card.answer
    puts "Good Job!"
    puts "-" * 25
  else
    puts "Too bad."
    puts "The correct answer is #{card.answer}."
  end
end