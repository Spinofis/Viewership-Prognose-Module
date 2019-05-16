
import numpy as np
import math
import pandas as pd

from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Flatten
from keras.layers.convolutional import Conv1D
from keras.layers.convolutional import MaxPooling1D
from azureml.core.run import Run
import argparse


#Data converter #########################################################################

class DataConverter:

    train = None
    test = None

    def split_dataset(self, data, group_size):
        data_count = len(data)
        data_count = data_count - data_count % group_size
        data = data[0:data_count-1]
        group_count = None # w wykonywanym przypadku group_size to tydzien a group_count liczba tygodni
        group_count = data_count/group_size
        # podział zbioru na na test i train po połowie
        end_train = (int)(round(group_count*0.5, 0)*group_size)
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

    def add_columns_with_past_grp(self, df, id_chan, columns_count):
        for i in range(columns_count):
            df[id_chan+"_"+str(i+1) +"_week_ago"] = df[id_chan].shift(1440*(i+1))
        return df

    def add_columns_with_past_program(self, df, id_chan, columns_count):
        for i in range(columns_count):
            df[id_chan+"_prg_id_" +str(i+1)+"_week_ago"] = df[id_chan+"_prg_id"].shift(1440*(i+1))
        return df

    def add_columns_with_past_program_type(self, df, id_chan, columns_count):
        for i in range(columns_count):
            df[id_chan+"_prg_type_id_"+str(i+1)+"_week_ago"] = df[id_chan+"_prg_type_id"].shift(1440*(i+1))
        return df

    def add_columns_with_past_program_base_type(self, df, id_chan, columns_count):
        for i in range(columns_count):
            df[id_chan+"_prg_base_type_id_"+str(i+1)+"_week_ago"] = df[id_chan+"_prg_base_type_id"].shift(1440*(i+1))
        return df

    def add_columns_with_past_temperature(self, df, id_chan, columns_count):
        for i in range(columns_count):
            df["max_temp_cels_"+str(i+1)+"_week_ago"] = df["max_temp_cels"].shift(1440*(i+1))

        for i in range(columns_count):
            df["min_temp_cels_"+str(i+1)+"_week_ago"] = df["min_temp_cels"].shift(1440*(i+1))

        for i in range(columns_count):
            df["avg_daily_temp_cels_"+str(i+1)+"_week_ago"] = df["avg_daily_temp_cels"].shift(1440*(i+1))
        return df

#Model ################################################################################


class Model:

    __dc = None

    def __init__(self, dc):
        self.__dc = dc

    def build_model(self, train, n_input, n_out, y_index):
        train_x, train_y = self.__dc.to_supervised(
            train, n_input, n_out, y_index)
        verbose, epochs = 2, 25
        n_timesteps, n_features, n_outputs = train_x.shape[1], train_x.shape[2], train_y.shape[1]
        model = Sequential()
        model.add(Conv1D(filters=100, kernel_size=3, activation='relu',
                         input_shape=(n_timesteps, n_features)))
        model.add(Conv1D(filters=100, kernel_size=3, activation='relu'))
        model.add(Conv1D(filters=100, kernel_size=2, activation='relu'))
        model.add(Conv1D(filters=100, kernel_size=2, activation='relu'))
        model.add(Conv1D(filters=100, kernel_size=2, activation='relu'))
        model.add(MaxPooling1D(pool_size=2))
        model.add(Flatten())
        model.add(Dense(100, activation='relu'))
        model.add(Dense(n_outputs))
        model.compile(loss='mse', optimizer='adam')
        model.fit(train_x, train_y, epochs=epochs, verbose=verbose)
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
        s = 0
        for row in range(actual.shape[0]):
            for col in range(actual.shape[1]):
                s += (actual[row, col] - predicted[row, col])**2
        score = math.sqrt(s / (actual.shape[0] * actual.shape[1]))
        return score

    def evaluate_model(self, train, test, n_input, n_out, y_index):
        model = self.build_model(train, n_input, n_out, y_index)
        history = [x for x in train]
        predictions = list()
        for i in range(len(test)):
            yhat_sequence = self.forecast(model, history, n_input)
            predictions.append(yhat_sequence)
            history.append(test[i, :])
        predictions = np.array(predictions)
        score = self.evaluate_forecasts(
            test[:, :, y_index], predictions)
        return score


#Main ##################################################################################################

# Na spotkaniu z panem pokazywałem n_input = 1440 (min)  czyli 24 h 
# Przepraszam za pomyłkę, finalny eksperyment wykonał się dla n_input=360 (min) czyli 6h
# 1440 (min) jako n_input było przez mnie testowane dla jednego kanału, ale jako że nie dało znaczącej poprawy,
# a czas wykonywania skryptu był znacząco dłuższy zaniechałem używania n_input=1440 
# tak samo w skrypcie podczas mojej (prezentacji) wnyników było o 5 więcej warstw i miały więcej filtrów
n_input = 360
n_out = 10080 
group_size = 10080
y_index = 0 # indeks kolumny, która zawiera grp, kanału tv dla którego wykonywana jest prognoza
id_chan=2 

run = Run.get_context()

dc = DataConverter()
model = Model(dc)

df_jan=pd.read_csv('./tv-data-jan.csv',sep=';')
df_feb=pd.read_csv('./tv-data-feb.csv',sep=';')
df_mar=pd.read_csv('./tv-data-mar.csv',sep=';')
df_apr=pd.read_csv('./tv-data-apr.csv',sep=';')
df_may=pd.read_csv('./tv-data-may.csv',sep=';')
df_jun=pd.read_csv('./tv-data-jun.csv',sep=';')
df_jul=pd.read_csv('./tv-data-jul.csv',sep=';')

df=pd.concat([df_jan,df_feb,df_mar,df_apr,df_may,df_jun,df_jul])

#usunięcie kolumny z datą 
df.drop(df.columns[0], axis=1, inplace=True, errors='ignore')

# dodanie kolumn z grp , ramówką i pogodą z wartościami jakie były 1,2,3 i 4 tygodnie temu 
df = dc.add_columns_with_past_grp(df,str(id_chan),4)
df = dc.add_columns_with_past_program(df,str(id_chan),4)
df = dc.add_columns_with_past_program_type(df,str(id_chan),4)
df = dc.add_columns_with_past_program_base_type(df,str(id_chan),4)
df = dc.add_columns_with_past_temperature(df,str(id_chan),4)

train, test = dc.split_dataset(df.values, n_out)
score = model.evaluate_model(
    train, test, n_input, n_out, y_index)

run.log('id_chan',id_chan)
run.log('rmse',score)