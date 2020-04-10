#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 18 19:16:23 2019

@author: Greg
"""

import psycopg2
from config import config
from urlparse import urljoin
import pandas as pd
import requests
import os
import StringIO

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

def savetofile(df, url, sep=',', auth=None):
    """ Save the data to a .csv """
    try:
        csv = StringIO.StringIO()
        df.to_csv(csv, sep, index=False)
        print(csv.getvalue())
        csv.seek(0)
        print("Putting %s" % url)
        r = requests.put(url, data=csv, auth=auth)
        print("Saved successfully!")
    except Exception as error:
        print("Saving not successful")
        print(error)
        print(r.status_code)

#-- Defining the queries
queries = {
    'weekly_release_subset' : """SELECT
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        "id" AS "UID",
        "name" AS "Name",
        NULL AS "_",
        NULL AS "_",
        "arrestTime" AS "Date and Time of Arrest",
        "location" AS "Place of Arrest",
        "offence" AS "Named offence at time of arrest",
        "charges" AS "Charge",
        "termsOfRelease" AS "Terms of Release",
        "courtDate" AS "Plea Date",
        NULL AS "_",
        "courtLocation" AS "Court",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        "canShareWithXRPress" AS "XR Media",
        NULL AS "_",
        NULL AS "_",
        "canShareWithLocalXRGroup" AS "Local Group",
        NULL AS "_",
        "nearestCity" AS "Region",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        NULL AS "_",
        "phone" AS "Tel Number",
        "email" AS "E-mail",
        NULL AS "_",
        NULL AS "_",
        "localXRGroup" AS "Local XR Group",
        NULL AS "_",
        "bailConditions" AS "Bail Conditions",
        NULL AS "_",
        "comment" AS "COMMENTS"
        FROM "release"
        WHERE to_timestamp("release"."updatedAt"/1000) > (NOW() - interval '7 days')
        """,
}

if __name__ == '__main__':
    params = config(section='nextcloud')
    url = params["url"]
    auth = (params["username"], params["password"])
    for name, query in queries.items():
        data = connect(query)
        savetofile(df=data, url=urljoin(url, name+'.csv'), auth=auth)

