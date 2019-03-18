import datetime as dt
import numpy as np

from cnn.multistep.data_converter import DataConverter
from cnn.multistep.model import Model
from database import Database
from plotting import Plotting
from enums.granulation import Granulation
from enums.method_type import Method_type

id_chan = 2
y_index = 3
n_input = 168
n_out = 24
startTime = dt.datetime.now()
dc = DataConverter()
db = Database()
df = db.get_grp_aggregated_hourly()
model = Model(dc)
plotting = Plotting()

train, test = dc.split_dataset(df.values, n_out)


# score, scores, predictions = model.evaluate_model(
#     train, test, n_input, n_out, y_index)
# model.summarize_scores('rmse', score, scores)

# db.save_result(int(Method_type.Cnn_multivariate_multistep),
#                int(Granulation.hour), id_chan, score)

# print(dt.datetime.now() - startTime)


channels = db.get_channel()

channels_array = np.array(channels["id_chan"])

for i in range(len(channels_array)):
    print(channels_array[i])
