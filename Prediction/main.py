import datetime as dt

from data_converter import DataConverter
from database import Database
from model import Model
from plotting import Plotting


n_input = 168
startTime = dt.datetime.now()
dc = DataConverter()
db = Database()
df = db.get_data_from_db()
model = Model()
plotting = Plotting()

train, test = dc.split_dataset(df.values)

score, scores, predictions = model.evaluate_model(train, test, n_input)
model.summarize_scores('rmse', score, scores)

print(dt.datetime.now() - startTime)

