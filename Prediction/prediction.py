import pyodbc
import pandas as pd


def get_database_connection():
    return pyodbc.connect('Driver={SQL Server};'
                          'Server=DESKTOP-12G6OSC\BARTEK;'
                          'Database=ViewershipForecastDB;'
                          'Trusted_Connection=yes;')


def get_data_from_db():
    sql = "select * from [dbo].[f_p_grp_hours_pivot_get] () where month(date) in (1)"
    df = pd.read_sql(sql, get_database_connection())
    return df
