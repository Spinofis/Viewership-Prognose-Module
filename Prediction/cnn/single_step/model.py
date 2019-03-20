
import numpy as np
import sklearn.metrics
import math

from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Flatten
from keras.layers.convolutional import Conv1D
from keras.layers.convolutional import MaxPooling1D


class Model:

    __dc = None

    def __init__(self, dc):
        self.__dc = dc

    def build_model(self, train, n_input, y_index):
        train_x, train_y = self.__dc.to_supervised(
            train, n_input, y_index)
        verbose, epochs = 2, 30
        n_timesteps, n_features = train_x.shape[1], train_x.shape[2]
        model = Sequential()
        model.add(Conv1D(filters=100, kernel_size=12, activation='relu',
                         input_shape=(n_timesteps, n_features)))
        model.add(Conv1D(filters=100, kernel_size=6, activation='relu'))
        model.add(MaxPooling1D(pool_size=3))
        model.add(Conv1D(filters=100, kernel_size=3, activation='relu'))
        model.add(MaxPooling1D(pool_size=2))
        # model.add(Conv1D(filters=50, kernel_size=3, activation='relu'))
        # model.add(MaxPooling1D(pool_size=2))
        model.add(Flatten())
        model.add(Dense(50, activation='relu'))
        model.add(Dense(1))
        model.compile(loss='mse', optimizer='adam')
        model.fit(train_x, train_y, epochs=epochs, verbose=verbose)
        return model

    def forecast(self, model, history, n_input):
        data = np.array(history)
        data = data.reshape((data.shape[0], data.shape[1]))
        input_x = data[-n_input:, :]
        input_x = input_x.reshape((1, input_x.shape[0], input_x.shape[1]))
        yhat = model.predict(input_x, verbose=0)
        yhat = yhat[0]
        return yhat

    def evaluate_forecasts(self, actual, predicted):
        s = 0
        for i in range(len(actual)):
            s += (actual[i] - predicted[i])**2
        score = math.sqrt(s / len(actual))
        return score

    def evaluate_model(self, train, test, n_input, y_index):
        model = self.build_model(train, n_input, y_index)
        history = [x for x in train]
        predictions = list()
        for i in range(len(test)):
            yhat = self.forecast(model, history, n_input)
            predictions.append(yhat)
            history.append(test[i, :])
        predictions = np.array(predictions)
        score = self.evaluate_forecasts(test[:, y_index], predictions)
        return score, predictions
