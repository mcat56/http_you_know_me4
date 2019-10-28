# Library that contains TCPServer
require 'socket'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

loop do
  # Wait for a Request
  # When a request comes in, save the connection to a variable
  puts 'Waiting for Request...'
  connection = server.accept

  # Read the request line by line until we have read every line
  puts "Got this Request:"
  request_lines = []
  line = connection.gets.chomp
  while !line.empty?
    request_lines << line
    line = connection.gets.chomp
  end

  # Print out the Request
  puts request_lines

  # Generate the Response
  puts "Sending response."

  if request_lines[0].split[0] == 'GET'
    output = "<html>Hello</html>"
    status = 'http/1.1 200 ok'
  elsif request_lines[0].split[0] == 'POST'
    output = "<html>post</html>"
    status = '202'
  elsif request_lines[0].split[0] == 'PATCH'
    output = "<html>patch</html>"
    status = '405'
  elsif request_lines[0].split[0] == 'DELETE'
    output = "<html>delete</html>"
    status = '401'
  end



  response = status + "\r\n" + "\r\n" + output

  # Send the Response
  connection.puts response

  # close the connection
  connection.close
end
