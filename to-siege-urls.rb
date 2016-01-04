puts $*.size
if $*.size < 3
  puts 'Usage: cmd input_file output_file http://aaa.com'
  exit(0)
end

input_file = $*[0]
output_file = $*[1]
head = $*[2]

File.open(output_file, 'w') do |f|
  File.open(input_file).each do |line|
    f.puts head + line
  end
end

