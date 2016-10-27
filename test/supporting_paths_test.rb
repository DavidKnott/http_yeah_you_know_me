gem 'minitest'
require './lib/output_diagnostics'
require './lib/supporting_paths'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SupportingPathsTest < Minitest::Test

    attr_reader     :supporting_paths

    def setup
        @supporting_paths = SupportingPaths.new(1, 1)
    end

    def test_it_exists
        assert supporting_paths
    end

    def test_it_returns_hello_world_with_counter
        expected = "<h1>Hello, World! (#{1})</h1>"
        assert_equal expected, supporting_paths.hello_with_counter
    end

    def test_it_returns_date_and_time
        time = Time.new
        expected = "<h1>" + time.strftime("%I:%M%p on %A, %B %d, %Y") + "</h1>"
        assert_equal expected, supporting_paths.date_and_time
    end

    def test_it_returns_amount_of_total_requests
        expected = "<h1>Total Requests: #{1}</hi>"
        assert_equal expected, supporting_paths.stop_program_with_counter
    end
end