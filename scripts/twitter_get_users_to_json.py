# -*- coding: utf-8 -*-

import sys
import json
import redis
import twitter
from twitter__login import login
from twitter__util import getUserInfo

names = []

#list of name in json
src = './data/names.json'

#file to write
dest = './data/userdata.json'


#read all names
with open(src) as f:
    d = json.load(f)
    for item in d:
        names.append(item['name'])

#log into twitter
t = login()
r = redis.Redis()

# create a list to store results
data = []

namecomma = ",".join([str(x) for x in names]) 
print namecomma

#request data
data = getUserInfo(t, r, screen_names=namecomma, verbose=True )

# separate arrays of 100 names for API requests
for i in range(len(names[::100])):
    s = (i-1)*99
    e = i*99
    q = []
    for item in names[s:e]:
        q.append(item)
    #print len(req)


#write in json file
s = json.dumps(data)
f = open( dest, 'a')
f.write(s + "\n")
f.close()




