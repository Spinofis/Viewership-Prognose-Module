import datetime as dt

from data_converter import DataConverter
from database import Database
from model import Model
from plotting import Plotting


n_input = 100
n_out = 1
startTime = dt.datetime.now()
dc = DataConverter()
db = Database()
df = db.get_grp_none_aggregated()
model = Model()
plotting = Plotting()

train, test = dc.split_dataset(df.values,n_out)

# X,y=dc.to_supervised(train,n_input,n_out)

# print(X.shape)
score, scores, predictions = model.evaluate_model(train, test, n_input)
model.summarize_scores('rmse', score, scores)

print(dt.datetime.now() - startTime)
