gz_file = "production.log-#{(Time.now - 86400).strftime '%Y%m%d'}.gz"

puts '\nLoading all production log from machine elsarails083:'
cmd = %Q(scp -l 100000 junqiao.wang@elsarailsb083:/u/apps/api/current/log/#{gz_file} .)
puts "#{cmd}"
`#{cmd}`

puts '\nDecompressing gzip file:'
cmd = %Q(gzip -dv #{gz_file})
puts "#{cmd}"
`#{cmd}`

puts '\nParsing all video urls:'
file = gz_file[0, gz_file.size - 3]
cmd = %Q(grep -o '/videos?[a-zA-Z0-9?&%=_:\.]*' #{file} > all-video-urls.log)
puts "#{cmd}"
`#{cmd}`

puts '\nParsing all show urls:'
file = gz_file[0, gz_file.size - 3]
cmd = %Q(grep -o '/shows?[a-zA-Z0-9?&%=_:\.]*' #{file} > all-show-urls.log)
puts "#{cmd}"
`#{cmd}`

