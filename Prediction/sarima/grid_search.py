from joblib import Parallel
from multiprocessing import cpu_count
from joblib.parallel import delayed


class GridSearch:

    __model = None

    def __init__(self, model):
        self.__model = model

    def sarima_configurations(self, seasonal):
        configurations = list()
        p_params = [0, 1, 2]
        d_params = [0, 1]
        q_params = [0, 1, 2]
        t_params = ['n', 'c', 't', 'ct']
        P_params = [0, 1, 2]
        D_params = [0, 1]
        Q_params = [0, 1, 2]
        m_params = seasonal
        for p in p_params:
            for d in d_params:
                for q in q_params:
                    for t in t_params:
                        for P in P_params:
                            for D in D_params:
                                for Q in Q_params:
                                    for m in m_params:
                                        cfg = [(p, d, q), (P, D, Q, m), t]
                                        configurations.append(cfg)
        return configurations

    def grid_search(self, data, cfg_list, parallel=True):
        scores = None
        if parallel:
            executor = Parallel(n_jobs=cpu_count(), backend='multiprocessing')
            tasks = (delayed(self.__model.score_model)(data, cfg)
                     for cfg in cfg_list)
            scores = executor(tasks)
        else:
            scores = [self.__model.score_model(
                data, cfg) for cfg in cfg_list]
        scores = [r for r in scores if r[1] != None]
        scores.sort(key=lambda tup: tup[1])
        return scores
