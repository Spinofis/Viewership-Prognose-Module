
from statsmodels.tsa.statespace.sarimax import SARIMAX
from problem_metadata import ProblemMetadata


class SarimaModel:

    model = None
    test = None
    train = None

    def split_dataset(self, data):
        data_count = len(data)
        end_train = round(data_count*0.7)
        train, test = data[0:end_train], data[end_train:]
        return train, test

    def build_model(self, history, config):
        order = config[0]
        seasonal_order = config[1]
        trend = config[2]
        model = SARIMAX(history, order=order, seasonal_order=seasonal_order,
                        trend=trend, enforce_stationarity=False, enforce_invertibility=False)
        self.model = model

    def forecast(self, history):
        return self.model.predict(len(history), len(
            history)+ProblemMetadata.prediction_steps)

    def evaluate_model(self, series, config):
        self.train, self.test = self.split_dataset(series)
        self.build_model(self.train, config)
