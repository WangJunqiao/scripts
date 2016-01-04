import io
import sys
# sed "s/format=xml/format=json/g" no-jp.log > no-jp-json.log

usage = '''
Usage:
cmd option input_file output_file
option:
--to-json : change format=xml to format=json
--min-id : minimal id, default 0, set to -1 to allow no id situation
--max-id : maximal id
--contain : must contain some str.
'''


def parse_args():
    cnt = len(sys.argv)
    if (cnt < 3):
        print usage
        exit()
    args = {}
    args['contain'] = []
    args['input_file'] = sys.argv[cnt - 2]
    args['output_file'] = sys.argv[cnt - 1]
    i = 1
    while i < cnt - 2:
        if sys.argv[i] == '--to-json':
            args['--to-json'] = 1
        if sys.argv[i] == '--min-id':
            args['--min-id'] = int(sys.argv[i + 1])
            i += 1
        if sys.argv[i] == '--contain':
            args['contain'].append(sys.argv[i + 1])
            i += 1
        i += 1
    return args

def getVideoId(url):
    try:
        if (line.find('?') == -1):
            return -1
        first = line.split('?')[0];
        id = first.split('/')[2];
        return int(id)
    except ValueError:
        return -1
    except IndexError:
        return -1

if __name__ == '__main__':
    args = parse_args()
    fw = io.open(args['output_file'], 'w')
    for line in io.open(args['input_file'], 'r'):
        if '--to-json' in args:
            line = line.replace('format=xml', 'format=json')
            if line.find('format=json') == -1:
                line = line.strip('\n') + "&format=json\n"
        
        if (line.find('format=json') == -1): # default only json format
            continue

	    if (line.find('sort=release_with_popularity') != -1):
	        continue
     
        if (line.find('language=ja') != -1 or line.find('region=jp') != -1): # default no jp reqs
            continue
        
        cont = False
        for s in args['contain']:
            if (line.find(s) == -1):
                cont = true
        if cont:
            continue

        videoId = getVideoId(line)  # check video id out of limit
        if '--min-id' in args:
            min_id = args['--min-id']
        else:
            min_id = 0
        if '--max-id' in args:
            max_id = args['--max-id']
        else:
            max_id = 879699
        if (videoId < min_id or videoId > max_id):
            continue
    
        fw.write(line)
    
    fw.close()

