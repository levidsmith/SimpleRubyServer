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
			elsif (strInput.upcase == "N")
				numberGuess(client)
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
		client.puts("N) Number Guessing Game" + "\r")
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

def numberGuess(client)
	r = Random.new
	iRand = r.rand(100) + 1
	iGuess = -1
	iNumGuesses = 0
	
#	client.puts("Random Number: #{iRand}\r")
	client.puts("Guess the number from 1 to 100\r")
	
	while (iGuess != iRand)
		iGuess = client.gets.chomp.to_i
		iNumGuesses += 1
		
		strColor1 = 27.chr + "[1;34;42m"
		strColor2 = 27.chr + "[1;31;41m"
		strColor3 = 27.chr + "[1;33;44m"
		strColor4 = 27.chr + "[0;35;47m"
		strColor5 = 27.chr + "[1;35;44m"

		
		if (iGuess > iRand)
			
			client.write(strColor1 + "#{iGuess}: " + strColor2 + "Lower")
		elsif (iGuess < iRand)
			client.write(strColor1 + "#{iGuess}: "  + strColor2 + "Higher")
		elsif (iGuess == iRand)
			client.puts(strColor3 + "Correct!\r\n" + strColor4 + "#{iNumGuesses}" + strColor5 + " total guesses\r\n")
		end
		
		client.puts(27.chr + "[0m\r")
		
	end
end


startServer()