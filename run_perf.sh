#!/bin/bash

echo 'siege -c8 -t1M -b -i -q -f video-index.log.filtered.siege1'
      siege -c8 -t1M -b -i -q -f video-index.log.filtered.siege1

echo 'siege -c8 -t1M -b -i -q -f video-index.log.filtered.siege3'
      siege -c8 -t1M -b -i -q -f video-index.log.filtered.siege3

echo 'siege -c8 -t1M -b -i -q -f video-id.log.filtered.siege1'
      siege -c8 -t1M -b -i -q -f video-id.log.filtered.siege1

echo 'siege -c8 -t1M -b -i -q -f video-id.log.filtered.siege3'
      siege -c8 -t1M -b -i -q -f video-id.log.filtered.siege3


echo 'siege -c8 -t1M -b -i -q -f show-index.log.filtered.siege1'
      siege -c8 -t1M -b -i -q -f show-index.log.filtered.siege1

echo 'siege -c8 -t1M -b -i -q -f show-index.log.filtered.siege3'
      siege -c8 -t1M -b -i -q -f show-index.log.filtered.siege3

echo 'siege -c8 -t1M -b -i -q -f show-id.log.filtered.siege1'
      siege -c8 -t1M -b -i -q -f show-id.log.filtered.siege1

echo 'siege -c8 -t1M -b -i -q -f show-id.log.filtered.siege3'
      siege -c8 -t1M -b -i -q -f show-id.log.filtered.siege3

