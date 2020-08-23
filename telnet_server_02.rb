#2020 Levi D. Smith - levidsmith.com
require 'socket'

puts "Simple Telnet Server"
iPort = 23

#Read ANSI file
f = File.open("TEST.ANS", "r")
strAnsiText = f.read
f.close()

#replace newlines with carriage return + line feed
strAnsiText.gsub! "\n", "\n\r"

server = TCPServer.open(iPort)
keepLooping = true
while (keepLooping)
    client = server.accept
    puts "client connected"
	
	client.puts(strAnsiText)
	
    client.puts(Time.now.ctime + "\r")

    iCount = 10
    while (iCount > 0)
        client.puts("Closing in #{iCount}\r")
        iCount -= 1
        sleep(1)
    end

    client.puts "Closing the connection\r"
    client.close
end