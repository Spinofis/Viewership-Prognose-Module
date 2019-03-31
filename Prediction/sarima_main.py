
import numpy as np
from datetime import datetime

from database import Database
from sarima.plotting import Plotting
from sarima.grid_search import GridSearch
from sarima.grid_search_model import GridSearchModel
from sarima.data_converter import DataConverter
from data_model.sarim_config_result import SarimaConfigResult
from enums.granulation import Granulation


print('time start', datetime.now())

db = Database()
dc = DataConverter()
grid_search = GridSearch(GridSearchModel(dc))
cfg_list = grid_search.sarima_configurations([168])
# df_minute=db.get_grp_none_aggregated()
df_hour = db.get_grp_aggregated_hourly('1')
# plotting=Plotting()
# time_series_minutes=np.array(df_minute["2"])
time_series_hours = np.array(df_hour["2"])
# lags=168
# # plotting.show_acf_and_pacf(time_series_hours,lags)

if __name__ == '__main__':
    scores = grid_search.grid_search(time_series_hours, cfg_list[501], True)
    print('time end', datetime.now())
    for cfg, rmse in scores[:10]:
        config_result = dc.sarima_cfg_tuples_to_object(cfg)
        config_result.rmse = rmse
        config_result.id_granulation = int(Granulation.hour)
        db.save_sarima_result(config_result)
