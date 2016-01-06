#!/bin/bash

function exec_with_print() {
    echo $1
    `$1`
}

function exec_with_13() {
    # $1 video-id.log.filtered
    sed 's/^/http:\/\/restapitest1.server.hulu.com:8080/g' $1  > $1.siege1
    exec_with_print "siege -c8 -t3M -b -i -q -f $1.siege1"
    sed 's/^/http:\/\/restapitest3.server.hulu.com:3000/g' $1  > $1.siege3
    exec_with_print "siege -c8 -t3M -b -i -q -f $1.siege3"
}

log="video-id.log"
exec_with_print "python restapi-url-filter.py --to-json $log $log.filtered"
exec_with_13 $log.filtered

log="show-id.log"
exec_with_print "python restapi-url-filter.py --to-json $log $log.filtered"
exec_with_13 $log.filtered

log="video-index.log"
exec_with_print "python restapi-url-filter.py --to-json --min-id -1 --contain only=id $log $log.filtered"
cat $log.filtered | grep -v show_id | grep -v company_id= > $log.filtered.noindex
cat $log.filtered | grep show_id > $log.filtered.index
cat $log.filtered | grep -v show_id | grep company_id= >> $log.filtered.index
exec_with_13 $log.filtered
exec_with_13 $log.filtered.noindex
exec_with_13 $log.filtered.index

log="show-index.log"
exec_with_print "python restapi-url-filter.py --to-json --min-id -1 --contain only=id $log $log.filtered"
cat $log.filtered | grep -v show_id | grep -v company_id= > $log.filtered.noindex
cat $log.filtered | grep show_id > $log.filtered.index
cat $log.filtered | grep -v show_id | grep company_id= >> $log.filtered.index
exec_with_13 $log.filtered
exec_with_13 $log.filtered.noindex
exec_with_13 $log.filtered.index

cat video-id.log.filtered > all.log.filtered
cat show-id.log.filtered >> all.log.filtered
cat video-index.log.filtered >> all.log.filtered
cat show-index.log.filtered >> all.log.filtered
exec_with_13 all.log.filtered


