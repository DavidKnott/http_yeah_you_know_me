gem 'minitest'
require './lib/output_diagnostics'
require 'minitest/autorun'
require 'minitest/pride'

class OutputDiagnosticsTest < Minitest::Test
    
    attr_reader :diagnostics,
                :request_lines

    def setup
        @request_lines =
        ["GET /hello?word=dog HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9", "Accept-Language: en-us", "Cache-Control: max-age=0", "Connection: keep-alive"]
        @diagnostics = OutputDiagnostics.new(@request_lines)
    end

    def test_it_exists
        assert diagnostics
    end

    def test_it_returns_verb
        verb = diagnostics.extract_verb(request_lines)
        assert_equal "GET", verb
    end
    
    def test_it_returns_path
        path = diagnostics.extract_path(request_lines)
        assert_equal "/hello", path
    end

    def test_it_returns_parameter_value
        param_value = diagnostics.extract_param_value(request_lines)
        assert_equal "dog", param_value
    end

    def test_request_lines_parser_returns_protocol
        protocol = diagnostics.extract_protocol(request_lines)
        assert_equal "HTTP/1.1", protocol
    end

    def test_request_lines_parser_returns_host
        host = diagnostics.extract_host(request_lines)
        assert_equal "127.0.0.1", host
    end

    def test_request_lines_parser_returns_port
        port = diagnostics.extract_port(request_lines)
        assert_equal "9292", port
    end

    def test_request_lines_parser_returns_origin
        origin = diagnostics.extract_host(request_lines)
        assert_equal "127.0.0.1", origin
    end

    def test_request_lines_parser_returns_accept
        accept = diagnostics.extract_accept(request_lines)
        accept_answer = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
        assert_equal accept_answer, accept
    end

    def test_it_prepares_to_output_diagnostics
        diagnostic = diagnostics.prepare_to_output_diagnostics
        answer = 
        ["Verb: GET", 
        "Path: /hello", 
        "Protocol: HTTP/1.1", 
        "Host: 127.0.0.1", "Port: 9292", 
        "Origin: 127.0.0.1", 
        "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"]
        assert_equal answer, diagnostic
    end

end