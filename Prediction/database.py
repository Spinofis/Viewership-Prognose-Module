
import pyodbc
import pandas as pd


class Database:
    def __get_database_connection(self):
        return pyodbc.connect('Driver={SQL Server};'
                              'Server=DESKTOP-12G6OSC\BARTEK;'
                              'Database=ViewershipForecastDB;'
                              'Trusted_Connection=yes;')

    def get_grp_aggregated_hourly(self):
        sql = "SELECT * FROM [dbo].f_data_to_learn_hours_get (N'1,2,3,4,5') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

    def get_grp_none_aggregated(self):
        sql = "SELECT * FROM [dbo].f_data_to_learn_minute_get (N'1,2,3,4,5') order by date_time"
        df = pd.read_sql(sql, self.__get_database_connection())
        df.drop(['date_time'], axis=1, inplace=True, errors='ignore')
        return df

