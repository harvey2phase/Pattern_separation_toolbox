import numpy as np
import matplotlib.pyplot as plt

def plot_results(filename):

    colours = ["blue"]
    n_samples = 5

    data = np.loadtxt(filename, delimiter=',')

    i_list, mean_list = [], []
    for i, sample in enumerate(data):
        plt.errorbar(i, np.mean(sample), yerr=np.std(sample))
        i_list.append(i)
        mean_list.append(np.mean(sample))
    plt.plot(i_list, mean_list)
    plt.show()

plot_results("mi_results.csv")
