import datetime as dt

from data_converter import DataConverter
from database import Database
from model import Model


n_input = 48
startTime = dt.datetime.now()
dc = DataConverter()
db = Database()
df = db.get_data_from_db()
model = Model()

train, test = dc.split_dataset(df.values)

score, scores, predictions = model.evaluate_model(train, test, n_input)
model.summarize_scores('cnn', score, scores)

print(dt.datetime.now() - startTime)
print(predictions)

# train_x, train_y = dc.to_supervised(train, n_input)

# print(train_x[-1, :, 1])
