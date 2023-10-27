require_relative "../config/environment"

class Run
    attr_accessor :user
    def initialize
        puts "Welcome to the Dictionary Helper!".blue.bold

        puts "Please enter your username to begin:".red # prompt user
        username = gets.chomp

        if User.find_by_name(username)
            @user = User.find_by_name(username) # find by username and store in @user variable
            puts "Welcome back, #{user.name}!".red
        else
            @user = User.create(name: username)
            puts "Nice to meet you, #{user.name}. Your account was successfully created.".red
        end

        is_active = true

        while is_active do 
            choice = menu 

            if choice.downcase == ".exit"
                is_active = false # way to get out of while loop is to make is_active false
                puts "Thank you for using Dictionary Helper! See you next time, #{user.name}!".blue.bold
            elsif choice.downcase == ".dictionary"
                system("clear")
                dictionary
            elsif choice.downcase == ".synonym"
                system("clear")
                synonym
            elsif choice.downcase == ".word-list"
                system("clear")
                puts "Word List"
            else 
                system("clear")
                puts "Command not found!".red.bold
            end
        end
    end

    def menu
        puts "Menu:".blue.bold
        puts "#{".dictionary".green.bold}\t - to search for a word's definition"
        puts "#{".synonym".green.bold}\t - to explore synonyms of words"
        puts "#{".word-list".green.bold}\t - to view previously saved words"
        puts "#{".exit".green.bold}\t\t - to exit out of Dictionary Helper"

        puts "Please enter your choice from the options above:".red
        gets.chomp 
    end

    def dictionary
        is_dictionary = true

        while is_dictionary do
            puts "Enter the word you would like meaning of (enter .back to return to main menu):".red
            user_input = gets.chomp 

            if user_input == ".back"
                is_dictionary = false
            else
                word_data = DictionaryAPI.get_word(user_input)

                if !word_data.empty?
                    meanings = word_data[:meanings]

                    meanings.each_with_index do |meaning, index|
                    part_of_speech = meaning["partOfSpeech"]
                    definitions = meaning["definitions"]
                    
                    puts "Meaning #{index + 1}: #{part_of_speech}".blue.bold
                    definitions.each_with_index do |definition, def_index|
                        puts "Definition #{def_index + 1}: #{definition["definition"]}".blue
                    end
                end
                elsif word_data.empty? 
                    puts "Word not found."
                end 
            end
        end
    end

    def synonym
        is_synonym = true

        while is_synonym do

            synonyms_found = false

            puts "Enter the word you would like the synonym of:".red
            user_input = gets.chomp 

            if user_input == ".back"
                is_synonym = false
            else
                word_data = DictionaryAPI.get_word(user_input)

                if !word_data.empty?
                    meanings = word_data[:meanings]

                    meanings.each_with_index do |meaning, index|
                    part_of_speech = meaning["partOfSpeech"]
                    synonyms = meaning["synonyms"]
                    
                    if !synonyms.empty?
                        puts "Synonyms for #{user_input}:".blue.bold
                        synonyms.each do |synonym|
                            puts " - #{synonym}".blue
                        end
                    elsif synonyms_found # If no synonyms are found
                        puts "No synonyms found for #{user_input}".red
                    end
                end
                else
                    puts "Word not found."
                end
            end
        end
    end
end



Run.new