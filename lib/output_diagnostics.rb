require 'pry'
class OutputDiagnostics

    attr_reader     :verb,
                    :path,
                    :param_value,
                    :request_lines

    def initialize(request_lines)
        @verb = extract_verb(request_lines)
        @path = extract_path(request_lines)
        @param_value = extract_param_value(request_lines)
        @protocol = extract_protocol(request_lines)
        @host = extract_host(request_lines)
        @port = extract_port(request_lines)
        @accept = extract_accept(request_lines)
    end

    def extract_verb(request_lines)
        request_lines = request_lines[0].split(" ")
        request_lines[0]
    end

    def extract_path(request_lines)
        path_line = request_lines[0].split(" ")
        path_line = path_line[1].split("?")
        path_line[0]       
    end

    def extract_param_value(request_lines)
        param_line = request_lines[0].split(" ")
        param_line = param_line[1].split("?")
        param_line = param_line[1].split("=") if param_line[1]
        param_line[1]
    end

    def extract_protocol(request_lines)
        request_lines = request_lines[0].split(" ")
        request_lines[2]
    end

    def extract_host(request_lines)
        request_lines = request_lines[1].split(" ")
        request_lines = request_lines[1].split(":")
        request_lines[0]
    end

    def extract_port(request_lines)
        request_lines = request_lines[1].split(" ")
        request_lines = request_lines[1].split(":")
        request_lines[1]
    end

    def extract_accept(request_lines)
        accept_line = request_lines.find { |line| line.include?("Accept:")}
        accept_line = accept_line.split(" ")
        accept_line[1]
    end

    def prepare_to_output_diagnostics
        diagnostic =
        ["Verb: #{@verb}",
        "Path: #{@path}",
        "Protocol: #{@protocol}",
        "Host: #{@host}",
        "Port: #{@port}",
        "Origin: #{@host}",
        "Accept: #{@accept}"]
    end

end