import requests
import json
from django.conf import settings
from heybooster.helpers.database.mongodb import MongoDBHelper

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

def get_rate_n_effort(path_id: str):
    rating = 0
    effort = 0

    with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
        rates = list(db.find('pathRating', query={'path_id': path_id}))
        efforts = list(db.find('pathEffort', query={'path_id': path_id}))

    for rate in rates:
        rating += rate['rating']
    if rates:
        rating /= len(rates)

    for effort_document in efforts:
        effort += effort_document['effort']
    if efforts:
        effort /= len(efforts)

    return rating, effort

def path_is_enrolled(path_id: str, username: str) -> bool:
    with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
        relation = db.find_one('enroll', query={'username': username, 'path_id': path_id})
    
    return relation is not None

def path_is_followed(path_id: str, username: str) -> bool:
    with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
        relation = db.find_one('follow_path', query={'username': username, 'path_id': path_id})
    
    return relation is not None
