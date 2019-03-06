import numpy as np


class DataConverter:

    def split_dataset(self, data):
        total_data = len(data)
        total_days = total_data/24
        end_train = (int)(round(total_days*0.7, 0)*24)
        start_test = (int)(end_train-total_data)
        train, test = data[0:end_train, :], data[start_test:]
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

    # def dataframe_to_hastack(self, df):
    #     ch2 = df.iloc[:, 3].values
    #     ch2 = ch2.reshape(len(ch2), 1)
    #     ch3 = df.iloc[:, 4].values
    #     ch3 = ch3.reshape(len(ch3), 1)
    #     ch4 = df.iloc[:, 5].values
    #     ch4 = ch4.reshape(len(ch4), 1)
    #     ch5 = df.iloc[:, 6].values
    #     ch5 = ch4.reshape(len(ch5), 1)
    #     ch6 = df.iloc[:, 7].values
    #     ch6 = ch6.reshape(len(ch6), 1)
    #     ch7 = df.iloc[:, 8].values
    #     ch7 = ch7.reshape(len(ch7), 1)
    #     ch8 = df.iloc[:, 9].values
    #     ch8 = ch8.reshape(len(ch8), 1)
    #     ch9 = df.iloc[:, 10].values
    #     ch9 = ch9.reshape(len(ch9), 1)
    #     ch10 = df.iloc[:, 11].values
    #     ch10 = ch10.reshape(len(ch10), 1)
    #     ch13 = df.iloc[:, 12].values
    #     ch13 = ch13.reshape(len(ch13), 1)
    #     ch14 = df.iloc[:, 13].values
    #     ch14 = ch14.reshape(len(ch14), 1)
    #     ch15 = df.iloc[:, 14].values
    #     ch15 = ch15.reshape(len(ch15), 1)
    #     ch16 = df.iloc[:, 15].values
    #     ch16 = ch16.reshape(len(ch16), 1)
    #     ch17 = df.iloc[:, 16].values
    #     ch17 = ch17.reshape(len(ch17), 1)
    #     ch18 = df.iloc[:, 17].values
    #     ch18 = ch18.reshape(len(ch18), 1)
    #     ch20 = df.iloc[:, 18].values
    #     ch20 = ch20.reshape(len(ch20), 1)
    #     return hstack((ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch13, ch14, ch15, ch16, ch17, ch18, ch20))
