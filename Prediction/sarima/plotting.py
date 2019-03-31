from matplotlib import pyplot
from statsmodels.graphics.tsaplots import plot_acf,plot_pacf

class Plotting:
    def show_acf_and_pacf(self,time_series,lags):
        pyplot.figure()
        axis=pyplot.subplot(2,1,1)
        plot_acf(time_series,ax=axis,lags=lags)
        axis=pyplot.subplot(2,1,2)
        plot_pacf(time_series,ax=axis,lags=lags)
        pyplot.show()