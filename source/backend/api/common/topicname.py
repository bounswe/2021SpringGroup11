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
    try:
        return resp.json()["entities"][f'Q{id}']["labels"]["en"]["value"]
    except:
        return ''
