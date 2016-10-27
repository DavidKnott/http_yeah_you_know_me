gem 'minitest'
require './lib/search_for_word'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'


class SearchForWordTest < Minitest::Test
    include SearchForWord

    def test_it_can_open_dictionary
        assert_equal 235886, SearchForWord.load_dictionary.length
    end

    def test_it_can_check_if_a_word_is_in_dictionary
        dictionary = SearchForWord.load_dictionary
        word_search_result = SearchForWord.check_if_word_is_in_dictionary(dictionary, "dog")
        assert_equal TRUE, word_search_result
    end

    def test_it_can_check_if_a_word_is_not_in_dictionary
        dictionary = SearchForWord.load_dictionary
        word_search_result = SearchForWord.check_if_word_is_in_dictionary(dictionary, "alskd")
        assert_equal FALSE, word_search_result
    end

    def test_it_can_handle_a_nil_word
        nil_result = SearchForWord.search_for_word(nil)
        nil_expected = "<h1>Please enter a parameter for your word search"
        assert_equal nil_expected, nil_result
    end

end