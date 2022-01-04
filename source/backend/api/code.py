from heybooster.helpers.database.mongodb import MongoDBHelper

DB_NAME= 'prod'
MONGO_URI= 'mongodb+srv://backend:CZi9OcZu3QZyWEoR@renaissance.pjjsy.mongodb.net/test?authSource=admin&replicaSet=atlas-br4g5g-shard-0&readPreference=primary&appname=MongoDB%20Compass&ssl=true'

with MongoDBHelper(uri=MONGO_URI, database=DB_NAME) as db:
    milestones = list(db.find('milestone', query={}))
    print(milestones)
    for milestone in milestones:
        db.find_and_modify('milestone', query={'_id': milestone['_id']}, type=1)