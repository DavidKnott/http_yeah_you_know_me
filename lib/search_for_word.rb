require 'pry'
module SearchForWord

    def self.search_for_word(word)
    return "<h1>Please enter a parameter for your word search" if word.nil?
    dictionary = load_dicationary
    word_search_result = check_to_see_if_word_is_in_dictionary(dictionary, word)
    return_answer_of_check(word_search_result)
    end

    def self.load_dictionary
        File.readlines("/usr/share/dict/words")
    end

    def self.check_if_word_is_in_dictionary(dictionary, word)
        dictionary.any? do |elem|
            elem.chomp("\n") == word
        end
    end

    def self.retrive_answer_of_check
    return "<h1>WORD is a known word</h1>" if word_search_result
    "<h1>WORD is not a known word</h1>"
    end

end