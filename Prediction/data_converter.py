import numpy as np


class DataConverter:

    train = None
    test = None

    def split_dataset(self, data):
        total_data = len(data)
        total_days = total_data/24
        end_train = (int)(round(total_days*0.7, 0)*24)
        start_test = (int)(end_train-total_data)
        train, test = data[0:end_train, :], data[start_test:]
        self.train = train
        self.test = test
        train = np.array(np.split(train, len(train)/24))
        test = np.array(np.split(test, len(test)/24))
        return train, test

    def split_sequences(self, sequences, n_steps):
        X, y = list(), list()
        for i in range(len(sequences)):
            end_ix = i + n_steps
            if end_ix > len(sequences):
                break
            seq_x, seq_y = sequences[i:end_ix, :-1], sequences[end_ix-1, -1]
            X.append(seq_x)
            y.append(seq_y)
        return np.array(X), np.array(y)

    def to_supervised(self, train, n_input, n_out=24):
        data = train.reshape((train.shape[0]*train.shape[1], train.shape[2]))
        X, y = list(), list()
        in_start = 0
        for _ in range(len(data)):
            in_end = in_start + n_input
            out_end = in_end + n_out
            if out_end < len(data):
                X.append(data[in_start:in_end, :])
                y.append(data[in_end:out_end, 0])
            in_start += 1
        return np.array(X), np.array(y)
