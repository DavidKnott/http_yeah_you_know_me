class SupportingPaths

    def initialize(hello_counter, counter)
        @counter = counter
        @hello_counter = hello_counter
    end
    

    def hello_with_counter
        "<h1>Hello, World! (#{@hello_counter})</h1>"
    end

    def date_and_time
        time = Time.new
        "<h1>" + time.strftime("%I:%M%p on %A, %B %d, %Y") + "</h1>"
    end

    def stop_program_with_counter
        "<h1>Total Requests: #{@counter}</hi>"
    end

end