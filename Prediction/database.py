
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

    def get_data_to_learn(self, start, length):
        sql = "select * from f_data_to_learn_minute_get(" + \
            str(start)+","+str(start+length)+")"
        df = pd.read_sql(sql, self.__get_database_connection())
        # df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def save_result(self, id_method_type, id_granulation, id_chan, rmse):
        sql = "insert into result.Result(id_method_type,id_granulation,id_chan,rmse) values(@id_type,@id_granulation,@id_chan,@rmse)"
        sql = sql.replace("@id_type", str(id_method_type))
        sql = sql.replace("@id_granulation", str(id_granulation))
        sql = sql.replace("@id_chan", str(id_chan))
        sql = sql.replace("@rmse", str(rmse))
        self.__execute_insert(sql)

    def save_sarima_result(self, config):
        sql = (
            'insert into result.Sarima_config(id_granulation,rmse,p_trend,d_trend,q_trend,trend,P_season,D_season,Q_season,season) '
            'values(@id_granulation,@rmse,@p_trend,@d_trend,@q_trend,@trend,@P_season,@D_season,@Q_season,@season)').format()
        sql = sql.replace("@id_granulation", str(config.id_granulation))
        sql = sql.replace("@rmse", str(config.rmse))
        sql = sql.replace("@p_trend", str(config.p))
        sql = sql.replace("@d_trend", str(config.d))
        sql = sql.replace("@q_trend", str(config.q))
        sql = sql.replace("@trend", """'"""+str(config.trend)+"""'""")
        sql = sql.replace("@P_season", str(config.P))
        sql = sql.replace("@D_season", str(config.D))
        sql = sql.replace("@Q_season", str(config.Q))
        sql = sql.replace("@season", str(config.season))
        self.__execute_insert(sql)

    def get_channel(self):
        sql = "exec p_channel_get"
        db = self.__get_database_connection()
        df = pd.read_sql(sql, db)
        return df

    def __execute_insert(self, sql):
        db = self.__get_database_connection()
        cursor = db.cursor()
        cursor.execute(sql)
        db.commit()
