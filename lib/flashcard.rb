require_relative "flashcard/version"
require_relative "Card"
require_relative "menu"
require_relative "views"

require 'colorized_string'
require 'colorize'
require 'pry'
require 'csv'

def index 
  csv_file = 'flashcards.csv'

  greeting
  cards = populate_cards_array_from_csv(csv_file)
  while true 
    user_menu_option = menu_2
    case user_menu_option
    when 1
      while true
        question, answer = get_question_and_answer

        card = Card.new(question, answer, (cards.length + 1))
        cards << card

        save_card_to_csv(card, csv_file)

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
        rewrite_csv_after_delete(cards, csv_file)

        cards = populate_cards_array_from_csv(csv_file)

        delete_confirmation(input)

        break if handle_delete_another_card_response
      end
    when 3 
      while true
        if cards.empty?
            cards_unavailable
            next
        end
        selected_qty =  selected_card_quantity

        if cards.length < selected_qty      
          not_enough_cards
          next
        end

        sample_cards = cards.sample(selected_qty)
        sample_cards.each do |card|
          display_question(card)
        end

        puts 'would you like to practice again?[y/n]'
        input = gets.chomp.downcase

        if input == 'n'
          break
        end
      end
    when 4
      exit
    else
      puts "That is not an option"
    end
  end
end 

def populate_cards_array_from_csv(csv_file)
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, headers: true)

  csv.map.with_index do |row, index|
    Card.new(row["question"], row["answer"], (index + 1))  
  end
end

def save_card_to_csv(card, csv_file)
  CSV.open(csv_file, "a") do |csv|
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

def rewrite_csv_after_delete(cards, csv_file)
  CSV.open(csv_file, "w", :write_headers=> true, :headers => ["question","answer", "ID"]) do |csv|
    cards.each do |card| 
      csv << card.to_a
    end 
  end
end

def set_up_csv
  new_csv = "#{ARGV[0]}.csv"

  CSV.open(new_csv, "wb") do |csv|
    csv << ["question","answer", "ID"]
  end

  return new_csv
end 

index


