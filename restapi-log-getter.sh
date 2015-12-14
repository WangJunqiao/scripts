scp -l 100000 elsarailsb083:/u/apps/api/current/log/production.log-20151210.gz .
gzip -dv production.log-20151210.gz
grep -o '/videos/[0-9]\+[a-zA-Z0-9?&%=_:\.]*' production.log-20151210 >final.log

