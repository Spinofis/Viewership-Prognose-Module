
import pyodbc
import pandas as pd


class Database:
    def __get_database_connection(self):
        return pyodbc.connect('Driver={SQL Server};'
                              'Server=DESKTOP-12G6OSC\BARTEK;'
                              'Database=ViewershipForecastDB;'
                              'Trusted_Connection=yes;')

    def get_grp_aggregated_hourly(self):
        sql = "SELECT * FROM [dbo].f_data_to_learn_hours_get (N'1,2,3,4,5,6') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def get_grp_none_aggregated(self):
        sql = "SELECT * FROM [dbo].f_data_to_learn_minute_get (N'1,2,3,4,5,6') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def save_result(self, id_method_type, id_granulation, id_chan, rmse):
        sql = "insert into result.Result(id_method_type,id_granulation,id_chan,rmse) values(@id_type,@id_granulation,@id_chan,@rmse)"
        sql = sql.replace("@id_type", str(id_method_type))
        sql = sql.replace("@id_granulation", str(id_granulation))
        sql = sql.replace("@id_chan", str(id_chan))
        sql = sql.replace("@rmse", str(rmse))
        db = self.__get_database_connection()
        cursor = db.cursor()
        cursor.execute(sql)
        db.commit()

    def get_channel(self):
        sql="exec p_channel_get"
        db=self.__get_database_connection()
        df=pd.read_sql(sql,db)
        return df
