class NumberGuessingGame

    attr_reader  :chosen_number

    attr_accessor   :guess_count,
                    :guess

    def initialize
        @chosen_number = Random.new.rand(0..100)
        @guess_count = 0
        @guess = nil
    end

    def start_game
        "<h1>Good luck!</h1>"
    end

    def make_guess(guess)
        @guess = guess.to_i
        @guess_count += 1
        return "redirect"
    end

    def guess_results
        return "Please make a guess" if chosen_number.nil?
        case @guess <=> chosen_number
        when -1 then return "<h1>You're on guess number #{guess_count} and your guess was to low</h1>"
        when 1  then return "<h1>You're on guess number #{guess_count} and your guess was to high</h1>"
        when 0 then return "<h1>You're on guess number #{guess_count} and your guess as correct!</h1>"
        end
    end

end
