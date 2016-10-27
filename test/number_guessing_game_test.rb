gem 'minitest'
require './lib/number_guessing_game'
require 'minitest/autorun'
require 'minitest/pride'

class NumberGuessingGameTest < Minitest::Test

    attr_accessor   :number_game

    def setup
        @number_game = NumberGuessingGame.new
    end

    def test_it_exists
        assert number_game
    end

    def test_it_initializes_with_a_random_number
        assert number_game.chosen_number
    end

    def test_it_initializes_with_a_guess_count_of_zero
        assert_equal 0, number_game.guess_count
    end

    def test_start_game_returns_good_luck
        expected = "<h1>Good luck!</h1>"
        assert_equal expected, number_game.start_game
    end

    def test_make_guess_increases_count_by_1
        number_game.make_guess(1)
        assert_equal 1, number_game.guess_count
    end

    def test_make_guess_returns_redirect
        assert_equal "redirect", number_game.make_guess(1)
    end

    def test_gets_results_return_if_guess_is_higher
        number_game.make_guess(101)
        expected = "<h1>You're on guess number #{number_game.guess_count} and your guess was to high</h1>"
        assert_equal expected, number_game.guess_results
    end

    def test_gets_results_return_if_guess_is_lower
        number_game.make_guess(-1)
        expected = "<h1>You're on guess number #{number_game.guess_count} and your guess was to low</h1>"
        assert_equal expected, number_game.guess_results
    end

    def test_gets_results_return_if_guess_is_correct
        number_game.make_guess(number_game.chosen_number)
        expected = "<h1>You're on guess number #{number_game.guess_count} and your guess as correct!</h1>"
        assert_equal expected, number_game.guess_results
    end

end