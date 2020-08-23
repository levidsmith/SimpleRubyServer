#2020 Levi D. Smith - levidsmith.com
require 'socket'


def startServer()
	puts "Simple Telnet Server"
	iPort = 23

	#Read ANSI file
	f = File.open("MEADOWS.ANS", "r")
	strAnsiText = f.read
	f.close()

	#replace newlines with carriage return + line feed
	strAnsiText.gsub! "\n", "\n\r"

	server = TCPServer.open(iPort)
	keepLooping = true
	while (keepLooping)
		client = server.accept
		puts "client connected"
	
		client.puts(strAnsiText + "\r")
	
		client.puts(Time.now.ctime + "\r")
		
		displayMenu(client)

		while client.gets
			strInput = $_.chomp!
			puts "Client input: " + strInput
			
			if (strInput.upcase == "X")
				puts "Disconnecting client"
#				keepLooping = false
				break
			elsif (strInput.upcase == "C")
				countToTen(client)
				displayMenu(client)
			elsif (strInput.upcase == "T")
				displayTime(client)
				displayMenu(client)
			else
				client.puts("Invalid command: #{strInput}\r")
			end
			
		end

		client.puts "Closing the connection\r"
		client.close
		sleep(2)
	end

end

def displayMenu(client)
		client.puts("C) Count to Ten" + "\r")
		client.puts("T) Display Time" + "\r")
		client.puts("X) Exit" + "\r")

end

def countToTen(client)
    iCount = 1
    while (iCount <= 10)
        client.puts("Counting #{iCount}\r")
        iCount += 1
        sleep(1)
    end

end

def displayTime(client)
		client.puts(Time.now.ctime + "\r")

end


startServer()