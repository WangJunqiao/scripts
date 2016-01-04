#ruby restapi-log-getter.rb

python restapi-url-filter.py --to-json video-id.log video-id.log.filtered
ruby to-siege-urls.rb video-id.log.filtered video-id.log.filtered.siege1 http://restapitest1.server.hulu.com:8080
ruby to-siege-urls.rb video-id.log.filtered video-id.log.filtered.siege3 http://restapitest3.server.hulu.com:3000

python restapi-url-filter.py --to-json --min-id -1 --contain only=id video-index.log video-index.log.filtered
ruby to-siege-urls.rb video-index.log.filtered video-index.log.filtered.siege1 http://restapitest1.server.hulu.com:8080
ruby to-siege-urls.rb video-index.log.filtered video-index.log.filtered.siege3 http://restapitest3.server.hulu.com:3000

cat video-index.log.filtered.siege1 | grep -v "show_id" | grep -v "company_id=" > video-index.log.filtered.siege1.fullscan

python restapi-url-filter.py --to-json show-id.log show-id.log.filtered
ruby to-siege-urls.rb show-id.log.filtered show-id.log.filtered.siege1 http://restapitest1.server.hulu.com:8080
ruby to-siege-urls.rb show-id.log.filtered show-id.log.filtered.siege3 http://restapitest3.server.hulu.com:3000

python restapi-url-filter.py --to-json --min-id -1 --contain only=id show-index.log show-index.log.filtered
ruby to-siege-urls.rb show-index.log.filtered show-index.log.filtered.siege1 http://restapitest1.server.hulu.com:8080
ruby to-siege-urls.rb show-index.log.filtered show-index.log.filtered.siege3 http://restapitest3.server.hulu.com:3000


