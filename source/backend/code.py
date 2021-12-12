import requests
import json

url = 'https://www.wikidata.org/w/api.php?action=wbsearchentities&search=Earth&format=json&errorformat=plaintext&language=en&uselang=en&type=item'
#url = 'https://www.wikidata.org/w/api.php?action=wbsearchentities&search=desert&format=json&errorformat=plaintext&language=en&uselang=en&type=item&continue=7'
#url = 'https://www.wikidata.org/wiki/Special:EntityData/Q2.json'
response = requests.get(url)

with open('data2.json', 'w+') as outfile:
    json.dump(response.json(), outfile)