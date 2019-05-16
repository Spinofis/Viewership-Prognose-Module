from enum import IntEnum


class Method_type(IntEnum):
    Naive_as_was_week_ago = 1,
    Naive_avg_weekdays_ago = 2,
    Sarima_1440 = 3,
    Sarima_10080 = 4,
    Arima_0_0_0 = 5,
    Conv_lstm = 6,
    Cnn=7
