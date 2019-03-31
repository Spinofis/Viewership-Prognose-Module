from naive.model import Model
from database import Database
from enums.method_type import Method_type
from enums.granulation import Granulation
import numpy as np

db=Database()
model=Model()
df=db.get_grp_none_aggregated()
channels = db.get_channel()
channels_array = np.array(channels["id_chan"])

shift_back=1440
for i in range(len(channels_array)):
    id_chan=channels_array[i]
    name_chan=str(id_chan)
    rmse=model.evaluate_model_a_was_week_ago(np.array(df[name_chan]),shift_back)
    db.save_result(int(Method_type.Naive_as_was_week_ago),int(Granulation.minute),id_chan,rmse)

for i in range(len(channels_array)):
    id_chan=channels_array[i]
    name_chan=str(id_chan)
    rmse=model.evaluate_model_avg_weekdays_ago(np.array(df[name_chan]),shift_back)
    db.save_result(int(Method_type.Naive_avg_weekdays_ago),int(Granulation.minute),id_chan,rmse)
