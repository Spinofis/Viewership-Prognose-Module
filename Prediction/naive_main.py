from naive.model import Model
from database import Database
from enums.method_type import Method_type
from enums.granulation import Granulation
import numpy as np

db=Database()
model=Model()
df=db.get_grp_aggregated_hourly()
channels = db.get_channel()
channels_array = np.array(channels["id_chan"])
step_back=24
for i in range(len(channels_array)):
    id_chan=channels_array[i]
    name_chan=str(id_chan)
    rmse=model.evaluate_model(np.array(df[name_chan]),step_back)
    db.save_result(int(Method_type.Naive_avg_yesterday),int(Granulation.hour),id_chan,rmse)
