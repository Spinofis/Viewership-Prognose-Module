import matplotlib.pyplot as plt


class Plotting:

    def draw_predicted_vs_actual_plot(self, actual):
        plt.plot(actual)
        # plt.plot(predicted)
        plt.show()
