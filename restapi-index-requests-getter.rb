gz_file = "production.log-2015#{(Time.now - 86400).strftime '%m%d'}.gz"
cmd = %Q(scp -l 100000 elsarailsb083:/u/apps/api/current/log/#{gz_file})
#cmd = %Q(ssh search@#{ip} "sh -cl 'grep GET log/#{name}-#{port}/result.log.#{(Time.now - 86400).strftime '%Y-%m-%d'}* >_merged_get_log'")
log "#{cmd}"
`#{cmd}`

cmd = %Q(gzip -dv #{gz_file})
log "#{cmd}"
`#{cmd}`

file = gz_file[0, gz_file.size - 3]
cmd = %Q(grep -o '/videos?[a-zA-Z0-9?&%=_:\.]*' #{file} > final.log)

