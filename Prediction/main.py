import datetime as dt

from data_converter import DataConverter
from database import Database
from model import Model


n_input = 10
startTime = dt.datetime.now()
dc = DataConverter()
db = Database()
df = db.get_data_from_db()
model = Model()

train, test = dc.split_dataset(df.values)

score, scores = model.evaluate_model(train, test, n_input)
model.summarize_scores('cnn', score, scores)

print(dt.datetime.now() - startTime)
