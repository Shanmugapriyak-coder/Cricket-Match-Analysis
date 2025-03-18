import json
import os
import pandas as pd
import glob

import mysql.connector
mydb = mysql.connector.connect(
         host = "localhost",
         user = "root",
         password = "root",
         database='guvi_projects',
         autocommit = True)
mycursor = mydb.cursor()

# finding all json file path on filepath given 
def get_files(filepath):
    all_files=[]
    for root,dirs,files in os.walk(filepath):
        files=glob.glob(os.path.join(root,"*.json"))
        for f in files :
            all_files.append(os.path.abspath(f))

    return all_files

# # convert the json file into dataframe
# def get_dataframe(filepaths):
#     df=pd.DataFrame()
#     for file in filepaths:
#         with open(file,'r', encoding='utf-8') as doc:
#         # print(data)
#             data=json.load(doc)
#             df_new = pd.json_normalize(data['info'],errors='ignore',record_path=['dates'],
#                     meta=['balls_per_over','gender','match_type','match_type_number',['outcome','winner'],['outcome','by','runs'],
#                         'overs','season','team_type','teams',['toss','winner'],['toss','decision'],
#                         ['event','match_number'],['event','name'],'venue'])
#             df = pd.concat([df,df_new],ignore_index=True)

#     return df

# convert the json file into dataframe and insert into tables
def insert_data(filepaths,table_name):
    parent_table_name=table_name+"_matches"
    child_table_name=table_name+"_match_innings"
    df1=pd.DataFrame()
    for file in filepaths:
        with open(file,'r', encoding='utf-8') as doc:
            data=json.load(doc)
            ball_data = pd.json_normalize(data["innings"], record_path=["overs", "deliveries"],
             meta=["team",["overs","over"]])

            subset = ball_data[['batter', 'bowler','non_striker','runs.batter','runs.extras','runs.total','team','overs.over']]
            
            df = pd.json_normalize(data['info'],errors='ignore',record_path=['dates'],
            meta=['balls_per_over','city','gender','match_type','match_type_number',['outcome','winner'],['outcome','by','runs'],
                'overs','season','team_type','teams',['toss','winner'],['toss','decision'],
                ['event','match_number'],['event','name'],'venue'])

           

            query = """
                INSERT INTO parent_table_name (match_date,ball_per_over,city, gender,match_type,match_type_no,outcome_winner,outcome_by_runs,overs,season,team_type,teams,toss_winner,toss_decision,venue)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """
            my_list=df['teams'][0]
            text = ','.join(my_list)
            values=(df[0][0],df['balls_per_over'][0], df['city'][0],
                        df['gender'][0], df['match_type'][0], df['match_type_number'][0],
                df['outcome.winner'][0],df['outcome.by.runs'][0], df['overs'][0],df['season'][0],df['team_type'][0],text,df['toss.winner'][0],
                df['toss.decision'][0],df['venue'][0])
            # print(data.keys())
            mycursor.execute(query,values) 
            id=mycursor.lastrowid                                                                                                                            
            inning_query=""" insert into child_table_name 
                (t20_id,batter,bowler,non_striker,runs_batter,runs_extras,runs_totals,team,overs) 
                values(%s,%s,%s,%s,%s,%s,%s,%s,%s) """

            tuple_array = [tuple((id,row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[7])) for row in subset.to_numpy()]
            mycursor.executemany(inning_query,tuple_array)    

            df1 = pd.concat([df1,df],ignore_index=True)

    return df1


#folder path where json file is stored
T20_path=r"C:\Users\MY Laptop\Desktop\guvi_class\web scrape\t20"
test_path=r"C:\Users\MY Laptop\Desktop\guvi_class\web scrape\test"
ipl_path=r"C:\Users\MY Laptop\Desktop\guvi_class\web scrape\ipl"
odis_path=r"C:\Users\MY Laptop\Desktop\guvi_class\web scrape\odi"


#getting json file path 
t20_filepaths=get_files(T20_path)
test_filepaths=get_files(test_path)
ipl_filepaths=get_files(ipl_path)
odis_filepaths=get_files(odis_path)

insert_data(t20_filepaths,"t20")
insert_data(test_filepaths,"test")
insert_data(ipl_filepaths,"ipl")
insert_data(odis_filepaths,"odi")



