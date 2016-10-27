require 'pry'
require 'socket'
require './lib/router'
require './lib/output_diagnostics'
require './lib/header'

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
                request_lines = []
                while line = client.gets and !line.chomp.empty?
                    request_lines << line.chomp
                end

                debugging_diagnostic = diagnostics_for_debugging(request_lines)

                @router.set_variables(request_lines, @hello_counter, @counter)
                output = @router.router_decisions
                output = parse_output(output)
                
                response = "<html><head><pre>" + output + "\n" + debugging_diagnostic + "</pre></head><body</body></html>"
                headers = Header.check_status_code_for_redirect(response, @status_tracker, output)
                
                client.puts headers
                client.puts response

                client.close
                end
            end
    end

    def parse_output(output)
        current_status = output.pop
        check_to_see_if_game_has_already_started_and_return_status_code(current_status)
        output = output.join
        check_for_shutdown(output)
        move_counters_up_one_if_activated(output)
        output
    end

    def check_for_shutdown(output)
        @server_status = "off" if output.include?("Total")
    end

    def move_counters_up_one_if_activated(output)
        @hello_counter += 1 if output.include?("Hello")
        @counter += 1
    end

    def check_to_see_if_game_has_already_started_and_return_status_code(current_status)
        if status_tracker == "301 Moved Permanently" || status_tracker == "403 Forbidden" && current_status == "301 Moved Permanently"
            @status_tracker = "403 Forbidden" 
        else
            @status_tracker = current_status
        end
    end

    def diagnostics_for_debugging(request_lines)
        diagnostic = OutputDiagnostics.new(request_lines)
        diagnostic_output = diagnostic.prepare_to_output_diagnostics
        diagnostic_output.join("\n")
    end

    
end

if __FILE__ == $0
        server = Server.new
        server.create_server
end