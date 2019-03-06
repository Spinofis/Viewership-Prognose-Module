
import numpy as np
import sklearn.metrics
import math

from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Flatten
from keras.layers.convolutional import Conv1D
from keras.layers.convolutional import MaxPooling1D

from data_converter import DataConverter


class Model:

    __dc = DataConverter()

    def build_model(self, train, n_input):
        train_x, train_y = self.__dc.to_supervised(train, n_input)
        verbose, epochs, batch_size = 0, 50, 16
        n_timesteps, n_features, n_outputs = train_x.shape[1], train_x.shape[2], train_y.shape[1]
        model = Sequential()
        model.add(Conv1D(filters=32, kernel_size=3, activation='relu',
                         input_shape=(n_timesteps, n_features)))
        model.add(Conv1D(filters=32, kernel_size=3, activation='relu'))
        model.add(MaxPooling1D(pool_size=2))
        model.add(Conv1D(filters=16, kernel_size=3, activation='relu'))
        model.add(MaxPooling1D(pool_size=2))
        model.add(Flatten())
        model.add(Dense(100, activation='relu'))
        model.add(Dense(n_outputs))
        model.compile(loss='mse', optimizer='adam')
        model.fit(train_x, train_y, epochs=epochs,
                  batch_size=batch_size, verbose=verbose)
        return model

    def forecast(self, model, history, n_input):
        data = np.array(history)
        data = data.reshape((data.shape[0]*data.shape[1], data.shape[2]))
        input_x = data[-n_input:, :]
        input_x = input_x.reshape((1, input_x.shape[0], input_x.shape[1]))
        yhat = model.predict(input_x, verbose=0)
        yhat = yhat[0]
        return yhat

    def evaluate_forecasts(self, actual, predicted):
        scores = list()
        for i in range(actual.shape[1]):
            mse = sklearn.metrics.mean_squared_error(
                actual[:, i], predicted[:, i])
            rmse = math.sqrt(mse)
            scores.append(rmse)
        s = 0
        for row in range(actual.shape[0]):
            for col in range(actual.shape[1]):
                s += (actual[row, col] - predicted[row, col])**2
        score = math.sqrt(s / (actual.shape[0] * actual.shape[1]))
        return score, scores

    def evaluate_model(self, train, test, n_input):
        model = self.build_model(train, n_input)
        history = [x for x in train]
        predictions = list()
        for i in range(len(test)):
            yhat_sequence = self.forecast(model, history, n_input)
            predictions.append(yhat_sequence)
            history.append(test[i, :])
        predictions = np.array(predictions)
        score, scores = self.evaluate_forecasts(test[:, :, 0], predictions)
        return score, scores, predictions

    def summarize_scores(self, name, score, scores):
        s_scores = ', '.join(['%.5f' % s for s in scores])
        print('%s: [%.5f] %s' % (name, score, s_scores))
