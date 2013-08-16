require 'bundler/setup'
require 'phoney'

require 'io/console'

Phoney.region = ARGV.first||'us'

input  = ''
prompt = "(Ctrl-C to exit) #[#{Phoney.region.country_abbr}]: "
print prompt

while ch = STDIN.getch do
  case ch.ord
  when 3   # Ctrl-C
    break
  when 127 # Backspace
    input = input[0..-2]
    print "\b"
  else
    input << ch
  end
  
  output = Phoney::Parser.parse input
  
  print "\r#{prompt}"
  print output
  
  print " "*100
  print "\b"*100
end

puts "\n^C Exiting - Goodbye"