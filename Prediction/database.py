
import pyodbc
import pandas as pd


class Database:
    def __get_database_connection(self):
        return pyodbc.connect('Driver={SQL Server};'
                              'Server=DESKTOP-12G6OSC\BARTEK;'
                              'Database=ViewershipForecastDB;'
                              'Trusted_Connection=yes;')

    def get_grp_aggregated_hourly(self, months_number_string):
        sql = "SELECT * FROM [dbo].f_data_to_learn_hours_get (N'" + \
            months_number_string+"') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def get_grp_none_aggregated(self, months_number_string):
        sql = "SELECT * FROM [dbo].f_data_to_learn_minute_get (N'" + \
            months_number_string+"') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def save_result(self, id_method_type, id_granulation, id_chan, rmse):
        sql = "insert into result.Result(id_method_type,id_granulation,id_chan,rmse) values(@id_type,@id_granulation,@id_chan,@rmse)"
        sql = sql.replace("@id_type", str(id_method_type))
        sql = sql.replace("@id_granulation", str(id_granulation))
        sql = sql.replace("@id_chan", str(id_chan))
        sql = sql.replace("@rmse", str(rmse))
        self.__execute_insert(sql)


    # def save_test_stationarity(self, test_stat, p_value, cv1, cv5, cv10, id_chan):
    #     sql = (('insert into result.Test_stationarity (test_statistic,p_value,cv1,cv5,cv10,id_chan)'
    #             'values(@test_statistic,@p_value,@cv1,@cv5,@cv10,@id_chan)').format())
    #     sql = sql.replace("@test_statistic", test_stat)
    #     sql = sql.replace("@p_value", p_value)
    #     sql = sql.replace("@cv1", cv1)
    #     sql = sql.replace("@cv5", cv5)
    #     sql = sql.replace("@cv10", cv10)
    #     sql = sql.replace("@id_chan", id_chan)
    #     self.__execute_insert(sql)

    def get_channels(self):
        sql = "exec p_channel_get"
        db = self.__get_database_connection()
        df = pd.read_sql(sql, db)
        return df

    def __execute_insert(self, sql):
        db = self.__get_database_connection()
        cursor = db.cursor()
        cursor.execute(sql)
        db.commit()
