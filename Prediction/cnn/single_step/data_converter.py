
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

    def to_supervised_with_shift_back(self, train, window_size, steps_back_size, n_input, y_index):
        X, y = list(),  list()
        for i in range(len(train)):
            X_step = list()
            for j in range(len(train[i:i+window_size:steps_back_size])):
                in_start = i-(j*steps_back_size)
                in_end = (in_start+n_input)
                if(in_end+1 < len(train) and in_start >= 0):
                    X_step.append(train[in_start:in_end, :])
            if(in_end+1 < len(train) and in_start >= 0):
                inputs = np.array(X_step)
                inputs = inputs.reshape(
                    inputs.shape[0]*inputs.shape[1], inputs.shape[2])
                X.append(inputs)
                y.append(in_end+1)
        return X, np.array(y)

    def __merge_list_of_arrays(self, lists):
        merged = lists[0]
        for i in range(len(lists)):
            if(i+1 < len(lists)):
                merged += lists[i+1]
        return merged
