from Tokenizer import loadDictFromFile


import sys

if __name__ == '__main__':

    noWord = loadDictFromFile('./data/combine.word')
    while True:
        line = sys.stdin.readline()
        if not line:
            break
        (key,value) = line.decode('utf-8').strip().split('\t',1)
        if key not in noWord:
            print '\t'.join([key.encode('utf-8'), value.encode('utf-8')])
