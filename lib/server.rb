require 'pry'
require 'socket'
require './lib/router'
require './lib/output_diagnostics'

class Server

    attr_reader     :router

    attr_accessor   :server_status,
                    :counter,
                    :status_tracker

    def initialize
        @server_status = "on"
        @counter = 1
        @hello_counter = 1
        @status_tracker = 200
        @tcp_server = TCPServer.new(9292)
        @router = Router.new
    end

    def create_server
            while server_status == "on" do 
                Thread.start(@tcp_server.accept) do |client|
                puts "Ready for a request"
                request_lines = []
                while line = client.gets and !line.chomp.empty?
                    request_lines << line.chomp
                end
                puts "Got this request:"
                puts request_lines.inspect
                puts "Sending response."
                output = "<h1>tester<h1>"
            

                second_start = true if @status_tracker == "301 Moved Permanently"
                
                debugging_diagnostic = diagnostics_for_debugging(request_lines)

                @router.set_variables(request_lines, @hello_counter, @counter)
                output = @router.router_decisions
                current_status = output.pop

                if current_status == "301 Moved Permanently" && second_start
                    @status_tracker = "403 Forbidden" 
                else
                    @status_tracker = current_status
                end


                output = output.join
                @server_status = "off" if output.include?("Total")
                @hello_counter += 1 if output.include?("Hello")
                @counter += 1

                response = "<pre>" + output + "\n" + debugging_diagnostic + "</pre>"
                response = "<html><head>#{response}</head><body></body></html>"
                
                headers = make_a_normal_header(response, @status_tracker)
                headers = make_a_redirect_header(response) if output == "redirect"
                
                client.puts headers
                client.puts response

                puts ["Wrote this response:", headers, output].join("\n")
                client.close
                puts "\nResponse complete, waiting for next request."
                end
            end
    end

    def move_counters_up_one_if_activated(output)
        @hello_counter += 1 if output.include?("Hello")
        @counter += 1
    end

    def diagnostics_for_debugging(request_lines)
        diagnostic = OutputDiagnostics.new(request_lines)
        diagnostic_output = diagnostic.prepare_to_output_diagnostics
        diagnostic_output.join("\n")
    end

    def make_a_normal_header(response, status_tracker)
        ["http/1.1 #{status_tracker}",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{response.length}\r\n\r\n"].join("\r\n")
    end

    def make_a_redirect_header(response)
        ["http/1.1 302 redirecting",
        "location: http://localhost:9292/game",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{response.length}\r\n\r\n"].join("\r\n")
    end

    
end

if __FILE__ == $0
        server = Server.new
        server.create_server
end