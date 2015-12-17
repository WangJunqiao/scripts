#!/usr/bin/env ruby

require "open-uri"
require "thread"
require "threadlimiter"

Thread.abort_on_exception = true

GALLARDO_HOST = 'http://restapitest1.server.hulu.com:8080'
RESTAPI_HOST = 'http://restapitest3.server.hulu.com:3000'

@url_file = $*[1]
print 'use file', @url_file, "\n"

def log str
  puts "[#{Time.now.strftime('%y%m%d_%H%M%S')}] #{str}"; STDOUT.flush
end

@response_time = Array.new
@stat_update_mutex = Mutex.new

def get_url(url)
  begin
    start_time = Time.now
    gallardo_time = 0
    open(GALLARDO_HOST + url) do |http|
      http.read
      status_code = http.status[0].to_i
      if status_code < 200 || status_code >= 300 then
        return
      end
    end
    gallardo_time = Time.now - start_time

    start_time = Time.now
    restapi_time = 0
    open(RESTAPI_HOST + url) do |http|
      http.read
      status_code = http.status[0].to_i
      if status_code < 200 || status_code >= 300 then
        return
      end
    end
    restapi_time = Time.now - start_time


  rescue Exception => e
    return
  end

  @stat_update_mutex.synchronize {
    @response_time << [gallardo_time, restapi_time]
  }
end

thread_limiter = ThreadLimiter.new(1)
total_videos_url = 0
file = File.open "out", "r"
ll = 1
file.each { |line|
  total_videos_url = total_videos_url + 1
  if total_videos_url == ll then
    puts ll
    ll *= 2
  end
  thread_limiter.fork(tmp_url = line) do
    get_url(tmp_url)
  end
}
puts "out of each"
thread_limiter.wait
puts "end wait"
log "total_videos_url = #{total_videos_url}"
if @response_time.size > 0 then
  log "result numbert = #{@response_time.size}"
  max_gallardo_time = 0
  max_restapi_time = 0
  total_gallardo_time = 0
  total_restapi_time = 0
  @response_time.each do |f|
    if f[0] > max_gallardo_time then
      max_gallardo_time = f[0]
    end
    if f[1] > max_restapi_time then
      max_restapi_time = f[1]
    end
    total_gallardo_time += f[0]
    total_restapi_time += f[1]
  end
  log "max_gallardo_time = #{max_gallardo_time}"
  log "max_restapi_time = #{max_restapi_time}"

  log "average gallardo time = #{total_gallardo_time / @response_time.size}"
  log "average restapi time = #{total_restapi_time / @response_time.size}"
end


