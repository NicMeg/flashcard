require_relative "flashcard/version"
require_relative "Card"
require_relative "menu"
require_relative "views"
require 'colorized_string'
require 'colorize'

require 'pry'
require 'csv'




def index 
  greeting
  cards = populate_cards_array_from_csv
  while true 
    user_menu_option = menu_2
    case user_menu_option
    when 1
      while true
        question, answer = get_question_and_answer

        card = Card.new(question, answer, (cards.length + 1))
        cards << card

        save_card_to_csv(card)

        break if handle_add_another_card_response
      end
    when 2
      while true
        if cards.empty?
          handle_empty_cards
          break
        end
        
        print_all_cards(cards)

        input = delete_card_number.to_i

        cards.delete_at(input - 1)
        rewrite_csv_after_delete(cards)

        cards = populate_cards_array_from_csv

        delete_confirmation(input)

        break if handle_delete_another_card_response
      end
    when 3 
      if cards.empty?
          cards_unavailable
          next
      end
      selected_qty =  selected_card_quantity

      if cards.length < selected_qty      ## I am not sure if this is required
      puts "There is not enough cards"
      next
      end

      sample_cards = cards.sample(selected_qty)
      sample_cards.each do |card|
        display_question(card)
      end
    when 4
      exit
    else
      puts "That is not an option"
    end
  end
end 

def populate_cards_array_from_csv
  csv_text = File.read('flashcards.csv')
  csv = CSV.parse(csv_text, headers: true)

  csv.map.with_index do |row, index|
    Card.new(row["question"], row["answer"], (index + 1))  
  end
end

def save_card_to_csv(card)
  CSV.open("flashcards.csv", "a") do |csv|
    csv << card.to_a
  end 
end

def handle_add_another_card_response
  input = add_another_card(success: true)

  if input == 'n'
    return true
  elsif input != 'y'
    incorrect_entry
    
    input = add_another_card

    return false
  end
end

def handle_delete_another_card_response
  input = delete_another_card

  if input == 'n'
    return true
  elsif input != 'y'
    incorrect_entry
    
    input = delete_another_card

    return false
  end
end

def rewrite_csv_after_delete(cards)
  CSV.open("flashcards.csv", "w", :write_headers=> true, :headers => ["question","answer", "ID"]) do |csv|
    cards.each do |card| 
      csv << card.to_a
    end 
  end
end

index


