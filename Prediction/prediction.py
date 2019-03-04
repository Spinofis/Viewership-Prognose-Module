from data_converter import DataConverter
from database import Database

from numpy import hstack, array
from datetime import datetime

from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Flatten
from keras.layers.convolutional import Conv1D
from keras.layers.convolutional import MaxPooling1D

startTime = datetime.now()

dc = DataConverter()
db = Database()

df = db.get_data_from_db()
dataset = dc.dataframe_to_hastack(df)

n_steps = 3

X, y = dc.split_sequences(dataset, n_steps)

n_features = X.shape[2]

model = Sequential()
model.add(Conv1D(filters=64, kernel_size=2, activation='relu', input_shape=(n_steps,
                                                                            n_features)))
model.add(MaxPooling1D(pool_size=2))
model.add(Flatten())
model.add(Dense(50, activation='relu'))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mse')
# fit model
model.fit(X, y, epochs=1000, verbose=0)
# demonstrate prediction
x_input = array([[0.141246], [0.110394966666667], [0.0968658666666666]])
x_input = x_input.reshape((1, n_steps, n_features))
yhat = model.predict(x_input, verbose=0)
print(yhat)

print(datetime.now() - startTime)
