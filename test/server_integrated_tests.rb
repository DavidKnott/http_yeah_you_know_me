gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'

class ServerTest < Minitest::Test
    
    

    def test_server_can_make_and_close_server

        conn = Faraday.new
        response = conn.get 'http://localhost:9292'
        p response.body

        # server.create_server
        # assert server
        # server.close_server
    end
    
end