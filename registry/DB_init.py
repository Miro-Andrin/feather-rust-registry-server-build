#!/bin/python3
# This is run form inside the feather-registry folder
import psycopg2, os
from urllib.parse import urlparse


try:
    connection = psycopg2.connect(os.environ["DATABASE_URL"])


    cursor = connection.cursor()

    cursor.execute("CREATE EXTENSION citext;")
    cursor.execute("CREATE EXTENSION semver;")

    for filename in os.listdir("./migrations"):
        if filename.endswith(".sql"):
            with open( "./migrations/" + filename,"r") as fp:
                print(f"Executing {filename}")
                cursor.execute(fp.read())

    
    connection.commit()



except (Exception, psycopg2.Error) as error :
    print (f"Error while connecting to PostgreSQL  CWD: {os.getcwd()}", error)
finally:
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")