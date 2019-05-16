
from statsmodels.tsa.statespace.sarimax import SARIMAX
from numpy import array
from numpy import split
from math import sqrt


class SarimaModel:

    config = None
    model_fit = None

    def __init__(self, config):
        self.config = config

    def split_dataset(self, data, group_size):
        if(data is None):
            return None
        data_count = len(data)
        data_count = data_count - data_count % group_size
        data = data[0:data_count-1]
        group_count = None
        group_count = data_count/group_size
        end_train = (int)(round(group_count*0.5, 0)*group_size)
        start_test = (int)(end_train-data_count)
        train, test = data[0:end_train], data[start_test:]
        train = array(split(train, len(train)/group_size))
        test = array(split(test, len(test)/group_size))
        return train, test

    def __build_model(self, history, egxog):
        order, sesonality, trend = self.config
        series = array(history).flatten()
        model = SARIMAX(series, order=order, seasonal_order=sesonality,
                        trend=trend, enforce_invertibility=False, enforce_stationarity=False)
        self.model_fit = model.fit(disp=False)

    def __forecast(self, history):
        return self.model_fit.predict(len(history), len(history)+10080)

    def __evaluate_forecasts(self, actual, predicted):
        s = 0
        for i in range(len(actual)):
            s += (actual[i] - predicted[i])**2
        score = sqrt(s / len(actual))
        return score

    def evaluate_model(self, series, egxog, group_size):
        train, test = self.split_dataset(series, group_size)
        train_egxog, test_egxog = None, None
        if(egxog is not None):
            train_egxog, test_egxog = self.split_dataset(egxog, group_size)
        history = [week for week in train]
        self.__build_model(history, train_egxog)
        print("model bulild")
        predicted = list()
        for i in range(len(test)):
            predicted.append(self.__forecast(history))
            history.append(test[i, :])
        return self.__evaluate_forecasts(array(test).flatten(), array(predicted).flatten())
