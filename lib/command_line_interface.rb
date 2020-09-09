class CommandLineInterface

    def main
        greet_user
        provide_paths
        capture_path
        #return requested data ask user again for input (choice)
        say_goodbye
    end

    def greet_user
        puts 'Hello, welcome to the Hurricane CLI App!'
    end

    def provide_paths
        #displays choices 
    end

    def capture_path
        puts "What would you like to do?"
        gets.strip
        #return requested data ask user again for input (choice)
    end

    def say_goodbye
        puts "Thanks for using the Hurricane CLI App!"
        exit
    end
end