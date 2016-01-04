gz_file = "production.log-#{(Time.now - 86400).strftime '%Y%m%d'}.gz"

if $*[0] == '--reload-data'
  puts "\nLoading all last day's production log from machine elsarails083:"
  cmd = %Q(scp -l 100000 junqiao.wang@elsarailsb083:/u/apps/api/current/log/#{gz_file} .)
  puts "#{cmd}"
  `#{cmd}`
  
  puts "\nDecompressing gzip file:"
  cmd = %Q(gzip -dv #{gz_file})
  puts "#{cmd}"
  `#{cmd}`
  
  file = gz_file[0, gz_file.size - 3]
  
  cmd = %Q(grep 'mozart' #{file} > production.log.mozart.only)
  `#{cmd}`
end

file = 'production.log.mozart.only'

puts "\nParsing all video index requests:"
cmd = %Q(grep -o '/videos?[a-zA-Z0-9?&%=_:\\.]*\\s' #{file} > video-index.log)
puts "#{cmd}"
`#{cmd}`

puts "\nParsing all video id requests:"
cmd = %Q(grep -o '/videos/[0-9]+\\?[a-zA-Z0-9?&%=_:\\.]*\\s' #{file} > video-id.log)
puts "#{cmd}"
`#{cmd}`

puts "\nParsing all show index requests:"
cmd = %Q(grep -o '/shows?[a-zA-Z0-9?&%=_:\\.]*\\s' #{file} > show-index.log)
puts "#{cmd}"
`#{cmd}`

puts "\nParsing all show id requests:"
cmd = %Q(grep -o '/shows/[0-9]+\\?[a-zA-Z0-9?&%=_:\\.]*\\s' #{file} > show-id.log)
puts "#{cmd}"
`#{cmd}`

