
import numpy as np

class DataConverter:
    def split_dataset(self, data):
        data_count = len(data)
        end_train = (int)(round(data_count*0.7, 0))
        start_test = (int)(end_train-data_count)
        train, test = data[0:end_train, :], data[start_test:]
        return train, test

    def to_supervised(self, train, n_input, y_index):
        X, y = list(), list()
        in_start = 0
        for _ in range(len(train)):
            in_end = in_start+n_input
            if in_end+1 < len(train):
                X.append(train[in_start:in_end, :])
                y.append(train[in_end+1, y_index])
            in_start += 1
        return np.array(X), np.array(y)
