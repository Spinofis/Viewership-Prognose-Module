
import numpy as np
from datetime import datetime
from statsmodels.tsa.stattools import adfuller
from matplotlib import pyplot as plt
from pandas import Series
from pandas import array
from pandas import DataFrame

from database import Database
from plotting import Plotting
from enums.granulation import Granulation
from sarima_model.sarima_model import SarimaModel
from enums.method_type import Method_type
from enums.granulation import Granulation
from enums.month import Month


seasonal_diff = 168
lags = 336
rolling_window = 24


def test_stationarity(timeseries, id_chan):
    rolmean = DataFrame.rolling(timeseries, rolling_window).mean()
    rolstd = DataFrame.rolling(timeseries, rolling_window).std()
    plotting.show_stationary_test_plot(
        timeseries, rolmean, rolstd, True, id_chan)
    print('Results of Dickey-Fuller for channel'+id_chan)
    dftest = adfuller(timeseries, autolag='AIC')
    dfoutput = Series(dftest[0:4], index=[
        'Test Statistic', 'p-value', '#Lags Used', 'Number of Observations Used'])
    for key, value in dftest[4].items():
        dfoutput['Critical Value (%s)' % key] = value
    print(dfoutput)


def create_acf_and_pacf_plots(df_grp_hours, channels_array, save=False):
    for i in range(len(channels_array)):
        id_chan = str(channels_array[i])
        array_grp_hours = np.array(df_grp_hours[id_chan])
        series_grp_hours = Series(array_grp_hours)
        plotting.title = "Acf and Pacf for channel "+id_chan
        plotting.show_acf_and_pacf(
            series_grp_hours, lags, save, id_chan+".png")
        if(seasonal_diff > 0):
            series_grp_hours = series_grp_hours.diff(seasonal_diff)
            plotting.title = "Acf and Pacf after differencing with 168 lag for channel "+id_chan
            plotting.show_acf_and_pacf(
                series_grp_hours, lags, save, id_chan+"_differenced.png")


def create_series_plots(df_grp_hours, channels_array, save=False):
    for i in range(len(channels_array)):
        id_chan = str(channels_array[i])
        array_grp_hours = np.array(df_grp_hours[id_chan])
        series_grp_hours = Series(array_grp_hours)
        plotting.show_time_series(series_grp_hours, save, id_chan+".png")
        if(seasonal_diff > 0):
            series_grp_hours = series_grp_hours.diff(seasonal_diff)
            plotting.show_time_series(
                series_grp_hours, save, id_chan+"_differenced.png")


def run_sarima(df, channels_array, is_egxog=False):
    for i in range(len(channels_array)):
        id_chan = str(channels_array[i])
        print("Processing channel: "+id_chan)
        series = Series(np.array(df[id_chan]))
        egxog = None
        if(is_egxog):
            egxog = df.drop([id_chan], axis=1, inplace=True, errors='ignore')
        model = SarimaModel([(0, 0, 0), (0, 0, 0, 10080), "n"])
        rmse = model.evaluate_model(series, egxog, group_size)
        print(rmse)
        db.save_result(int(Method_type.Sarima_10080), int(
            Granulation.minute), id_chan, rmse)


db = Database()
plotting = Plotting()
channels = db.get_channels()
channels_array = np.array(channels["id_chan"])
df_grp_hours = db.get_grp_aggregated_hourly('1,2,3,4,5,6,7')
df_grp_minute = db.get_grp_none_aggregated('1,2,3,4,5,6,7')
group_size = 10080

create_series_plots(df_grp_hours, channels_array, True)
create_acf_and_pacf_plots(df_grp_hours, channels_array, True)

# for i in range(len(channels_array)):
#     id_chan = str(channels_array[i])
#     series = Series(array(df_grp_hours[id_chan]))
#     test_stationarity(series, id_chan)
run_sarima(df_grp_minute, channels_array, is_egxog=True)
