#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 18 19:16:23 2019

@author: Greg
"""

import psycopg2
from config import config
import pandas as pd
import requests
import os

def connect(query):
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
      
        # create a cursor
        cur = conn.cursor()
        
        sql_command = "{};".format(str(query))
        print ("Query: ", sql_command)
    
        # Load the data
        data = pd.read_sql(sql_command, conn)
    
        print("Dataframe shape: ",data.shape)
        return (data)
       
        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
        
def savetofile(df, filename, savepath=os.getcwd(), sep=','):
    """ Save the data to a .csv """
    # Question for Chris: non-UTF8 characters on input?
    url = 'https://cloud.extinctionrebellion.org.uk/remote.php/dav/files/gregxr/Back%20Office%20October%20Rebellion/test/testfolder/'+filename
    username = 'gregxr'
    password = 'rebellion2'
    try:
        df.to_csv(savepath+'/'+filename, sep, index=False)
        r = requests.put(url, data=open(savepath+'/'+filename, 'rb'), auth=(username, password))
        print("Saved successfully!")
    except Exception as error:
        print("Saving not successful")
        print(error)
        print(r.status_code)

#-- Defining the queries
queries = {
    'fullrelease' : 'select * from public."release";',
    'lastmonthrelease' : 'SELECT * FROM "release" where to_timestamp("release"."updatedAt"/1000) > (NOW() - interval \'1 month\')'
        }

if __name__ == '__main__':
#    for name, query in queries.items():
#        data = connect(query)
#        savetofile(df=data,savepath='/Users/Greg/repositories/arrestwatchpython/',filename=name'.csv')
    data = connect('select "arrestTime" from "release" limit(10);')
    savetofile(df=data,filename='arrestTime.csv')
    
    
    
    