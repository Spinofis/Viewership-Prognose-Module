import math


class Model:

    def evaluate_model_avg_weekdays_ago(self, data, shift_back):
        prediction = list()
        for i in range(len(data)):
            previous = data[0:i+1:shift_back]
            if(len(previous) > 0):
                prediction.append(sum(previous)/len(previous))
        return self.__evaluate_forecast(prediction, data, 0)

    def evaluate_model_a_was_week_ago(self, data, shift_back):
        prediction = list()
        for i in range(len(data)):
            week_ago = i-shift_back
            if(week_ago >= 0):
                prediction.append(data[week_ago])
        return self.__evaluate_forecast(prediction, data, shift_back)

    def __evaluate_forecast(self, prediction, actual, shift_back):
        s = 0
        for i in range(len(prediction)):
            actual_index = i+shift_back
            if(actual_index <= len(actual)):
                s += (actual[actual_index]-prediction[i])**2
        score = math.sqrt(s/len(actual))
        return score
