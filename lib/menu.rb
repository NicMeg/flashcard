def menu
  sleep 1
  system "clear"
  puts "*" * 30
  puts "         Flashcard APP        ".on_red.bold
  puts "*" * 30
  puts "-" * 30
  puts "1. Add flashcards".blue
  puts "2. Remove flashcards"
  puts "3. Practice with flashcards"
  puts "4. Exit"
  puts "5. TTY Prompt Tests"
  puts "-" * 30
  puts "Select option 1, 2, 3, or 4."
  print ">"
  user_input = gets.chomp.to_i

  return user_input
end

# User profile to save questions
# Score for successful


