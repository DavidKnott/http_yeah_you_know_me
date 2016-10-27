module Header

    def self.check_status_code_for_redirect(response, status_tracker, output)
        return make_a_redirect_header(response) if output == "redirect"
        make_a_normal_header(response, status_tracker)
    end

    def self.make_a_normal_header(response, status_tracker)
        ["http/1.1 #{status_tracker}",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{response.length}\r\n\r\n"].join("\r\n")
    end

    def self.make_a_redirect_header(response)
        ["http/1.1 302 Redirect",
        "location: http://localhost:9292/game",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{response.length}\r\n\r\n"].join("\r\n")
    end

end