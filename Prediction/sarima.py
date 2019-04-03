
import numpy as np
from datetime import datetime
from pandas import Series

from database import Database
from plotting import Plotting
from data_model.sarim_config_result import SarimaConfigResult
from enums.granulation import Granulation
from problem_metadata import ProblemMetadata


def create_plots_for_sarima_analysis(df_grp_hours, channels_array):
    for i in range(len(channels_array)):
        id_chan = str(channels_array[i])
        series_grp_hours = Series(array_grp_hours)
        array_grp_hours = np.array(df_grp_hours[id_chan])
        plotting.show_time_series(series_grp_hours, True, id_chan+".png")
        lags = 168
        plotting.title = "Acf and Pacf for channel "+id_chan
        plotting.show_acf_and_pacf(
            series_grp_hours, lags, True, id_chan+".png")
        series_grp_hours = series_grp_hours.diff(lags)
        plotting.title = "Acf and Pacf after differencing with 168 lag for channel "+id_chan
        plotting.show_acf_and_pacf(
            series_grp_hours, lags, True, id_chan+"_differenced.png")
        plotting.show_time_series(
            series_grp_hours, True, id_chan+"_differenced.png")





def run_experiment(db):
    channels = db.get_channel()
    channels_array = np.array(channels["id_chan"])
    for i in range(len(channels_array)):
        id_chan = str(channels_array[i])
        df = db.get_grp_none_aggregated('1,2,3,4,5,6,7')
        series = Series(np.array(df[id_chan]))
        train, test = split_dataset(series)


db = Database()
plotting = Plotting()
# df_minute=db.get_grp_none_aggregated('1,2,3,4,5,6,7')
# df_grp_hours = db.get_grp_aggregated_hourly('1,2,3,4,5,6,7')


# Grid searching for sarima hyperparemeters
# if __name__ == '__main__':
#     scores = grid_search.grid_search(time_series_hours, cfg_list, False)
#     print('time end', datetime.now())
#     for cfg, rmse in scores[:10]:
#         config_result = dc.sarima_cfg_tuples_to_object(cfg)
#         config_result.rmse = rmse
#         config_result.id_granulation = int(Granulation.hour)
#         db.save_sarima_result(config_result)
