from math import sqrt
from multiprocessing import cpu_count
from joblib import Parallel
from joblib import delayed
from warnings import catch_warnings
from warnings import filterwarnings
from statsmodels.tsa.statespace.sarimax import SARIMAX
from sklearn.metrics import mean_squared_error


class GridSearchModel:

    __dc = None

    def __init__(self, dc):
        self.__dc = dc

    def sarima_forecast(self, history, config):
        order, sorder, trend = config
        model = SARIMAX(history, order=order, seasonal_order=sorder, trend=trend,
                        enforce_stationarity=False, enforce_invertibility=False)
        model_fit = model.fit(disp=False)
        yhat = model_fit.predict(len(history), len(history))
        return yhat[0]

    def measure_rmse(self, actual, predicted):
        return sqrt(mean_squared_error(actual, predicted))

    def walk_forward_validation(self, data, cfg):
        predictions = list()
        train, test = self.__dc.split_dataset(data)
        history = [x for x in train]
        for i in range(len(test)):
            yhat = self.sarima_forecast(history, cfg)
            predictions.append(yhat)
            history.append(test[i])
        error = self.measure_rmse(test, predictions)
        return error

    def score_model(self, data, cfg, debug=False):
        result = None
        key = str(cfg)
        if debug:
            result = self.walk_forward_validation(data, cfg)
        else:
            try:
                with catch_warnings():
                    filterwarnings("ignore")
                    result = self.walk_forward_validation(data, cfg)
            except:
                error = None
        if result is not None:
            print(' > Model[%s] %.3f' % (key, result))
        return (cfg, result)
