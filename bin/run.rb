require_relative "../config/environment"

class Run
    attr_accessor :user
    def initialize
        puts "Welcome to the Dictionary Helper!".blue.bold

        puts "Please enter your username to begin:" # prompt user
        username = gets.chomp

        if User.find_by_name(username)
            @user = User.find_by_name(username) # find by username and store in @user variable
            puts "Welcome back, #{user.name}!"
        else
            @user = User.create(name: username)
            puts "Nice to meet you, #{user.name}. Your account was successfully created."
        end
    end
end

Run.new