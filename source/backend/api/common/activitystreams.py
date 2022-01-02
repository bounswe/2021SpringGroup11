

def activity_format(summary:str, username:str, obj_id:str, obj_name:str, aux=None):
    res={
        "@context":"https://www.w3.org/ns/activitystreams",
        "summary":summary,
        "actor":{
            "type":"Person",
            "name":username,
        },
        "object":{
            "id":obj_id,
            "type":"Document",
            "name":obj_name
        }
    }
    if aux:
        res["aux"]=aux
    return res


def activity_decode(record:dict):
    res=dict()
    for key in ["@context", "summary", "actor", "object"]:
        res[key]=record[key]
    return res

