from database import Database
from enums.method_type import Method_type
from enums.granulation import Granulation
from enums.month import Month
import numpy as np
import math


def split_dataset(data):
    data_count = len(data)
    end_train = round(data_count*0.5)
    end_train = end_train-(end_train % 10080)
    end_test = data_count-(data_count % 10080)
    train, test = data[0:end_train], data[end_train:end_test]
    return train, test


def evaluate_forecast(prediction, actual):
    s = 0
    for i in range(len(prediction)):
        s += (actual[i]-prediction[i])**2
    score = math.sqrt(s/len(actual))
    return score


def evaluate_model_as_was_time_ago(data, shift_back):
    prediction = list()
    train, test = split_dataset(data)
    for i in range(len(test)):
        week_ago = i-shift_back+len(train)
        prediction.append(data[week_ago])
    return evaluate_forecast(prediction, test)


db = Database()
df = db.get_grp_none_aggregated('1,2,3,4,5,6,7')
channels = db.get_channels()
channels_array = np.array(channels["id_chan"])

shift_back = 10080
for i in range(len(channels_array)):    
    id_chan = channels_array[i]
    name_chan = str(id_chan)
    rmse = evaluate_model_as_was_time_ago(np.array(df[name_chan]), shift_back)
    db.save_result(int(Method_type.Naive_as_was_week_ago),
                   int(Granulation.minute), id_chan, rmse)
