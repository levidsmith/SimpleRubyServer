#2020 Levi D. Smith - levidsmith.com
require 'socket'

puts "Simple Telnet Server"
iPort = 23

server = TCPServer.open(iPort)
keepLooping = true
while (keepLooping)
    client = server.accept
    puts "client connected"
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