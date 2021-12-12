import requests
import json

def get_related_topics(id:int):
    
    #url=f'https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=Q{id}&languages=en&format=json'
    url = f'https://www.wikidata.org/wiki/Special:EntityData/Q{id}.json'
    resp=requests.get(url)
    
    if not resp.ok:
        raise ConnectionError("Error fetching topic name from Wikidata API.")
    
    ret = []
    
    #with open('data3.json', 'w+') as outfile:
    #    json.dump(resp.json(), outfile)

    print(f'Q{id}')
    data = resp.json()["entities"][f'Q{id}']["claims"]

    for key,value in data.items():
        for item in value:
            try:
                ret.append(int(item['mainsnak']['datavalue']['value']['id'][1:]))
            except:
                pass
    
    return ret
