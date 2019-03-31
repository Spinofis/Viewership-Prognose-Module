
from data_model.sarim_config_result import SarimaConfigResult


class DataConverter:
    def split_dataset(self, data):
        data_count = len(data)
        end_train = round(data_count*0.9)
        train, test = data[0:end_train], data[end_train:]
        return train, test

    def sarima_cfg_tuples_to_object(self, cfg):
        result = SarimaConfigResult()
        result.p = cfg[0][0]
        result.d = cfg[0][1]
        result.q = cfg[0][2]
        result.trend = cfg[2]
        result.P = cfg[1][0]
        result.D = cfg[1][1]
        result.Q = cfg[1][2]
        result.season = cfg[1][3]
        return result
