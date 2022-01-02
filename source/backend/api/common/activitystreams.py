import time
from datetime import datetime as dt

def activity_format(summary:str, username:str, obj_id:str, obj_name:str, action="Create", aux=None):
    res={
        "@context":"https://www.w3.org/ns/activitystreams",
        "summary":summary,
        "type": action,
        "actor":{
            "type":"Person",
            "name":username,
        },
        "object":{
            "id":obj_id,
            "type":"Document",
            "name":obj_name
        }
        "published":dt.fromtimestamp(time.time()).isoformat()
    }
    if aux:
        res["aux"]=aux
    return res


def activity_decode(record:dict):
    res=dict()
    for key in ["@context", "summary", "type", "actor", "object", "published"]:
        res[key]=record[key]
    return res

