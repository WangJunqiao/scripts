import io
import sys


if (len(sys.argv) < 3):
    print 'Usage:\n' \
          'cmd input_file output_file'
    exit()

print "Parse file ", sys.argv[1]
input_file = sys.argv[1]
output_file = sys.argv[2]
fw = io.open(output_file, 'w')


def getVideoId(url):
    try:
        if (line.find('?') == -1):
            return -1
        first = line.split('?')[0];
        id = first.split('/')[2];
        return int(id)
    except ValueError:
        return -1

for line in io.open(input_file, 'r'):
    if (line.find('format=json') == -1): # check json format
        continue

    if (line.find('language=ja') != -1 or line.find('region=jp') != -1):
        continue

    videoId = getVideoId(line)  # check video id out of limit
    if (videoId < 0 or videoId > 879699):
        continue

    fw.write(line)

fw.close()

