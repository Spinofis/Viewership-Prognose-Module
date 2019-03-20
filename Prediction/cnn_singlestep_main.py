
import numpy as np

from database import Database
from cnn.single_step.data_converter import DataConverter
from cnn.single_step.model import Model
from enums.granulation import Granulation
from enums.method_type import Method_type

db=Database()
dc=DataConverter()
model=Model(dc)
df=db.get_grp_aggregated_hourly()
train,test=dc.split_dataset(df.values)
n_input=168
channels = db.get_channel()
channels_array = np.array(channels["id_chan"])
for i in range(len(channels_array)):
    y_index = i
    id_chan = channels_array[i]
    score, predictions = model.evaluate_model(
        train, test, n_input, y_index)
    db.save_result(int(Method_type.Cnn_multivariate_singlestep),
                   int(Granulation.hour), id_chan, score)
