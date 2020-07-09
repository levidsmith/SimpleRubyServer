#2020 Levi D. Smith - levidsmith.com
require 'socket'

puts "Simple Telnet Server"
#strHostname = '127.0.0.1'
iPort = 23

#s = TCPSocket.open(strHostname, iPort)
server = TCPServer.open(iPort)
keepLooping = true
while (keepLooping)
    client = server.accept
    puts "client connected"
    client.puts(Time.now.ctime)

    iCount = 10
    while (iCount > 0)
        client.puts("Closing in #{iCount}")
        iCount -= 1
        sleep(1)
    end



    client.puts "Closing the connection"
    client.close
end