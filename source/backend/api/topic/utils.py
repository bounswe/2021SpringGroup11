import requests


def topicname(id:int):
    """
        Returns name of the topic
        :id: id of the topic

    """
    
    url=f'https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=Q{id}&languages=en&format=json'
    resp=requests.get(url)
    
    if not resp.ok:
        raise ConnectionError("Error fetching topic name from Wikidata API.")
    
    return resp.json()["entities"][f'Q{id}']["labels"]["en"]["value"]


def get_topics(text: str):
    """
        Returns 7 entiteties from wikidata 
    """

    url = f'https://www.wikidata.org/w/api.php?action=wbsearchentities&search={text}&format=json&errorformat=plaintext&language=en&uselang=en&type=item'
    response = requests.get(url)

    data = response.json()
    
    ret = []

    data = data['search']

    for entity in data:
        ret.append(
            {
                'name': entity['label'],
                'id': int(entity['id'][1:]),
                'description': entity['description']
            })

    return ret


def get_related_topics(id:int):
    
    #url=f'https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=Q{id}&languages=en&format=json'
    url = f'https://www.wikidata.org/wiki/Special:EntityData/Q{id}.json'
    resp=requests.get(url)
    
    if not resp.ok:
        raise ConnectionError("Error fetching topic name from Wikidata API.")
    
    ret = []
    
    data = resp.json()["entities"][f'Q{id}']["claims"]

    for key, value in data.items():
        for item in value:
            try:
                ret.append({"ID": int(item['mainsnak']['datavalue']['value']['id'][1:])})
            except:
                pass
    
    return ret


def topicname(id:int):
    url=f'https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=Q{id}&languages=en&format=json'
    resp=requests.get(url)
    if not resp.ok:
        raise ConnectionError("Error fetching topic name from Wikidata API.")
    return resp.json()["entities"][f'Q{id}']["labels"]["en"]["value"]