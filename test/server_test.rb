gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'

class ServerTest < Minitest::Test
    
    def test_it_exists
        conn = Faraday.new
        response = conn.get 'http://localhost:9292'
        assert response
    end

    def test_it_can_output_hello
        conn = Faraday.new
        response = conn.get 'http://localhost:9292/hello'
        assert_equal "Hello", response.body[21..25]
    end

    def test_it_can_output_diagnostics
        conn = Faraday.new
        response = conn.get 'http://localhost:9292/'
        assert_equal "GET", response.body[24..26]
    end

    def test_it_can_output_date_and_time
        conn = Faraday.new
        response = conn.get 'http://localhost:9292/datetime'
        time = Time.new
        assert_equal time.hour.to_s, response.body[21..22]
    end

    def test_it_can_accept_a_post
        conn = Faraday.new
        response = conn.post 'http://localhost:9292/'
        assert response
    end

    def test_it_can_start_a_game
        conn = Faraday.new
        response = conn.post 'http://localhost:9292/start_game'
        assert_equal TRUE, response.body.include?("start_game")
    end

    def test_it_can_redirect_to_game_results
        conn = Faraday.new
        response = conn.post 'http://localhost:9292/game?guess=10'
        assert_equal TRUE, response.body.include?("game")
    end
    
end