require 'pry'
require './lib/number_guessing_game'
require './lib/supporting_paths'

class Router 

    def set_variables(request_lines, hello_counter, counter)
        @diagnostic = OutputDiagnostics.new(request_lines)
        @supporting_paths = SupportingPaths.new(hello_counter, counter)
    end

    def router_decisions
        if @diagnostic.path.include?("game")
            return game_paths_decision
        elsif @diagnostic.path == "/"
            return ['', "200 OK"]
        elsif @diagnostic.path == "/hello" || @diagnostic.path ==  "/favicon.ico"
            return [@supporting_paths.hello_with_counter, "200 OK"]
        elsif @diagnostic.path == "/datetime"
            return [@supporting_paths.date_and_time, "200 OK"]
        elsif @diagnostic.path == "/word_search"
            return [SearchForWord.search_for_word(@diagnostic.param_value).to_s, "200 OK"]
        elsif @diagnostic.path == "/shutdown"
            return [@supporting_paths.stop_program_with_counter, "200OK "]
        elsif @diagnostic.path == "/force_error"
            return ["System Error", "500 Internal Server Error"]
        elsif @diagnostic.path == "/sleepy"
            sleep(10)
            return ["yawn...", "200 OK"]
        else 
            ["ERROR","404 Not Found"]
        end
    end

    def game_paths_decision
        if @diagnostic.verb == "POST" && @diagnostic.path == "/start_game"
            @number_game = NumberGuessingGame.new
            return [@number_game.start_game, "301 Moved Permanently"]
        elsif @diagnostic.verb == "GET" && @diagnostic.path == "/game"
            return [@number_game.guess_results, "200 OK"]
        elsif @diagnostic.verb == "POST" && @diagnostic.path == "/game"
            return [@number_game.make_guess(@diagnostic.param_value), "200 OK"]
        end
    end

    

end