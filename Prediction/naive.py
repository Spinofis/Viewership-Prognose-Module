from database import Database
from enums.method_type import Method_type
from enums.granulation import Granulation
import numpy as np
import math



def evaluate_forecast( prediction, actual, shift_back):
    s = 0
    for i in range(len(prediction)):
        actual_index = i+shift_back
        if(actual_index <= len(actual)):
            s += (actual[actual_index]-prediction[i])**2
    score = math.sqrt(s/len(actual))
    return score

def evaluate_model_avg_weekdays_ago( data, shift_back):
    prediction = list()
    for i in range(len(data)):
        previous = data[0:i+1:shift_back]
        if(len(previous) > 0):
            prediction.append(sum(previous)/len(previous))
    return evaluate_forecast(prediction, data, 0)

def evaluate_model_a_was_week_ago( data, shift_back):
    prediction = list()
    for i in range(len(data)):
        week_ago = i-shift_back
        if(week_ago >= 0):
            prediction.append(data[week_ago])
    return evaluate_forecast(prediction, data, shift_back)


db=Database()
df=db.get_grp_none_aggregated('1,2,3,4,5,6,7')
channels = db.get_channel()
channels_array = np.array(channels["id_chan"])

shift_back=1440
for i in range(len(channels_array)):
    id_chan=channels_array[i]
    name_chan=str(id_chan)
    rmse=evaluate_model_a_was_week_ago(np.array(df[name_chan]),shift_back)
    db.save_result(int(Method_type.Naive_as_was_week_ago),int(Granulation.minute),id_chan,rmse)

for i in range(len(channels_array)):
    id_chan=channels_array[i]
    name_chan=str(id_chan)
    rmse=evaluate_model_avg_weekdays_ago(np.array(df[name_chan]),shift_back)
    db.save_result(int(Method_type.Naive_avg_weekdays_ago),int(Granulation.minute),id_chan,rmse)
