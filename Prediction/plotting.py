
from matplotlib import pyplot
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf


class Plotting:

    __acf_pacf_path = "C:\Bieżące projekty (szkoła nauka)\Viewership-Prognose-Module\Prediction\saved plots\\acf_pacf\\"
    __series_path = "C:\Bieżące projekty (szkoła nauka)\Viewership-Prognose-Module\Prediction\saved plots\series\\"
    __test_stationarity_path = "C:\Bieżące projekty (szkoła nauka)\Viewership-Prognose-Module\Prediction\saved plots\\test_stationarity\\"

    y_label = "grp"
    x_label = "hours"
    title = ""

    def show_acf_and_pacf(self, time_series, lags, save=False, file_name=""):
        pyplot.title = self.title
        pyplot.figure()
        axis = pyplot.subplot(2, 1, 1)
        plot_acf(time_series, ax=axis, lags=lags)
        pyplot.xlabel = self.x_label
        pyplot.ylabel = self.y_label
        axis = pyplot.subplot(2, 1, 2)
        plot_pacf(time_series, ax=axis, lags=lags)
        pyplot.xlabel = self.x_label
        pyplot.ylabel = self.y_label
        if(save):
            pyplot.savefig(self.__acf_pacf_path+file_name)
        else:
            pyplot.show()

    def show_time_series(self, time_series, save=False, file_name=""):
        pyplot.figure()
        pyplot.plot(time_series)
        pyplot.title = self.title
        pyplot.xlabel = self.x_label
        pyplot.ylabel = self.y_label
        if(save):
            pyplot.savefig(self.__series_path+file_name)
        else:
            pyplot.show()

    def show_stationary_test_plot(self, timeseries, rolmean, rolstd, save=False, file_name=""):
        fig = pyplot.figure(figsize=(12, 8))
        orig = pyplot.plot(timeseries, color='blue', label='Original')
        mean = pyplot.plot(rolmean, color='red', label='Rolling Mean')
        std = pyplot.plot(rolstd, color='black', label='Rolling Std')
        pyplot.legend(loc='best')
        pyplot.title('Rolling Mean & Standard Deviation')
        if(save):
            pyplot.savefig(self.__test_stationarity_path+file_name)
        else:
            pyplot.show()
