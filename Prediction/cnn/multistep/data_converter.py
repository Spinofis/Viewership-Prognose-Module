import numpy as np


class DataConverter:

    train = None
    test = None

    def split_dataset(self, data, group_size):
        data_count = len(data)
        group_count = None
        group_count = data_count/group_size
        end_train = (int)(round(group_count*0.7, 0)*group_size)
        start_test = (int)(end_train-data_count)
        train, test = data[0:end_train, :], data[start_test:]
        self.train = train
        self.test = test
        train = np.array(np.split(train, len(train)/group_size))
        test = np.array(np.split(test, len(test)/group_size))
        return train, test

    def to_supervised(self, train, n_input, n_out, y_index):
        data = train.reshape((train.shape[0]*train.shape[1], train.shape[2]))
        X, y = list(), list()
        in_start = 0
        for _ in range(len(data)):
            in_end = in_start + n_input
            out_end = in_end + n_out
            if out_end < len(data):
                X.append(data[in_start:in_end, :])
                y.append(data[in_end:out_end, y_index])
            in_start += 1
        return np.array(X), np.array(y)
