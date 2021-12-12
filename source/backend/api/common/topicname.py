import requests


def topicname(id:int):
    url=f'https://www.wikidata.org/w/api.php?action=wbgetentities&props=labels&ids=Q{id}&languages=en&format=json'
    resp=requests.get(url)
    if not rep.ok:
        throw ConnectionError("Error fetching topic name from Wikidata API.")
    return resp.json()["entities"][f'Q{id}']["labels"]["en"]["value"]