import sys

#utf8stdout = open(1, 'w', encoding='utf-8', closefd=False) # fd 1 is stdout
# Assume all the input is of the same 
def loadDictFromFile(filename):
    return  dict(x.decode('utf-8').strip().split('\t',1) for x in open(filename).readlines())


def bisegmentWord(key, dict):
    splits = [(x+" "+y, float(chDict[x])+float(chDict[y]))
        for (x,y) in [(key[0:pos],key[pos:]) for pos in xrange(1,len(key))] 
        if x in chDict and y in chDict]
    if len(splits)> 0:
        (x,y) = min(splits, key=lambda item:(item[1]))
        return x,y
    return None
    
if __name__ == "__main__":

    chDict = loadDictFromFile("merge.prob")
    while True:
        line = sys.stdin.readline()
        if not line:
            break;
        (key,value) = line.decode('utf-8').strip().split('\t',1)
        surfix = ""
        if len(key) > 3:
            tokens = bisegmentWord(key, chDict)
            if tokens is not None:
                x,y = tokens
                surfix = '\t'.join([x,str(y),str(y- float(value))])
        print '\t'.join([key.encode('utf-8') , value.encode('utf-8') ,surfix.encode('utf-8')]).rstrip()
        
        
