import math


class Model:

    def evaluate_model(self, data, step_back):
        prediction = list()
        for i in range(len(data)):
            previous = data[0:i+1:step_back]
            if(len(previous) > 0):
                prediction.append(sum(previous)/len(previous))
        return self.__evaluate_forecast(prediction, data)

    def __evaluate_forecast(self, prediction, actual):
        s = 0
        for i in range(len(actual)):
            s += (actual[i]-prediction[i])**2
        score = math.sqrt(s/len(actual))
        return score
