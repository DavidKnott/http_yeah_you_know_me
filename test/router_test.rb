gem 'minitest'
require './lib/number_guessing_game'
require './lib/supporting_paths'
require './lib/output_diagnostics'
require './lib/router'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class RouterTest < Minitest::Test
    
    attr_reader     :router,
                    :request_lines
                    
    attr_accessor   :diagnostics

    def setup
        @request_lines = 
        ["POST /start_game HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9", "Accept-Language: en-us", "Cache-Control: max-age=0", "Connection: keep-alive"]
        @diagnostic = OutputDiagnostics.new(request_lines)
  
        @router = Router.new
    end

    def test_it_exists
        assert router
    end

    def test_it_can_set_supporting_paths
        actual = router.set_variables(request_lines, 1, 1)
        result = "<h1>Total Requests: 1</hi>"
        assert_equal result, actual.stop_program_with_counter
    end

    def test_router_decisions_if_path_includes_game_and_starts_game
        router.set_variables(request_lines, 1, 1)
        actual = router.router_decisions
        expected = ["<h1>Good luck!</h1>", "301 Moved Permanently"]
        assert_equal expected, actual
    end

end