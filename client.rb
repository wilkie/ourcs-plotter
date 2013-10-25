require './lib/thoth/api.rb'
require 'readline'

HOSTS = ["localhost"]
PORTS = [9292]

API.discover(HOSTS, PORTS)

loop do
  line = Readline.readline("> ", true)

  tokens = line.split(' ')

  command = tokens.first
  tokens = tokens.drop(1)
  args = tokens.join(' ')

  case command
  when "query", "q"
    puts "Querying for interface #{args}..."
    API.query(args)
  when "list", "l"
    puts "Listing info for interface #{args}..."
    API.list(args)
  when "sync", "synch", "s"
    if args.empty?
      puts "Syncing for all interfaces..."
    else
      puts "Syncing for interface #{args}..."
    end
    API.sync(args)
  when "publish", "pub", "p"
    if tokens.count > 1
      interface = tokens.first
      implementation = tokens.drop(1).first
      puts "Publishing interface #{interface}'s #{implementation} implementation..."
      API.publish(interface)
      API.publish_implementation(interface, implementation)
    else
      interface = tokens.first
      implementation = nil
      puts "Publishing interface #{interface}..."
      API.publish(interface, implementation)
    end
  when "push"
    API.push(args)
  when "quit", "exit", "x"
    break
  else
    puts "Unknown command #{command}"
  end
end
