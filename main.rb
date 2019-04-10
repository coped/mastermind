class Gameboard
    attr_reader :over
    def initialize
        @number_of_turns = 12
        @secret_code = []
        make_code
        @secret_code
        @over = false
        @win = false
    end

    def check_code player_input
        correct_placement = 0
        correct_color = 0
        arr = @secret_code.dup
        player_input.each_with_index do |color, index|
            if color == arr[index]
                correct_placement += 1
                arr[index] = 0
                player_input[index] = 0
            end
        end

        arr.delete 0
        player_input.delete 0

        arr.each_with_index do |color, index|
            if player_input.include? color
                correct_color += 1
                arr[index] = 0
                player_input.delete(color)
            end
        end

        puts "\nCorrect color, correct placement: #{correct_placement}."
        puts "Correct color, but wrong placement: #{correct_color}"
        if correct_placement == 4
            @win = true
            @over = true
        end
        reduce_turn
    end

    def end_result
        puts @win ? "\nCorrectly solved the code. You win!" : "\nYou ran out of turns and lost!."
    end
    private

    def reduce_turn
        @number_of_turns -= 1
        puts "\n#{@number_of_turns} turns left."
        @over = true if @number_of_turns == 0
    end

    def make_code
        @colors = ["purple", "blue", "green", "yellow", "orange", "red"]
        4.times {@secret_code.push(@colors[rand(6)])}
    end
end

class Codebreaker
    def make_turn
        input = gets.chomp.downcase.strip
        input = input.split(" ")
        puts "\nPlayer guessed: #{input}"
        input
    end
end

breaker = Codebreaker.new
game = Gameboard.new
puts "The computer will make a random, 4 part sequence from these colors:"
puts "'purple', 'blue', 'green', 'yellow', 'orange', 'red'"
puts "\nGuess the sequence of 4 colors within 12 turns (separate guesses with a space)."
puts "['?' '?' '?' '?']"
puts ""
until game.over
    game.check_code breaker.make_turn
end
game.end_result