#!/usr/bin/env python

import json
import mysql.connector
from datetime import datetime

if __name__ == '__main__':


    #Connect to the database
    print("Connecting to database")
    cnx = mysql.connector.connect(user='root', password='root',
                              host='127.0.0.1',
                              database='nflproject')

    cursor = cnx.cursor()



    with open('players.json') as json_file:  
        data = json.loads(json_file.read())
        print("opened")
        for p in data:
            if ('position' in data[p]):
                player_id = data[p]['profile_id']
                player_firstname = data[p]['first_name']
                player_lastname = data[p]['last_name']
                player_birthday = data[p]['birthdate']
                player_birthday = datetime.strptime(player_birthday, '%m/%d/%Y')
                player_birthday.strftime('%Y-%m-%d')
                #print(player_birthday)
                #exit()
                player_college = data[p]['college']
                player_height = data[p]['height']
                player_weight = data[p]['weight']
                player_years_pro = data[p]['years_pro']
                player_position = data[p]['position']
                if ('team' in data[p]):
                    player_nfl_team = data[p]['team']
                else:
                    player_nfl_team = None

                #print(str(player_id) + " " + player_firstname + " " + player_lastname + " " + str(player_birthday) + " " + player_college + " ")
                #print(str(player_height) + " " + str(player_weight) + " " + str(player_years_pro) + " " + player_position + "\n")

                add_player = ("INSERT INTO player "
                    "(player_id, player_firstname, player_lastname, player_birthday, player_college, player_height, player_weight, player_years_pro, player_position, player_nfl_team) "
                    #"VALUES (%s, %s, %s, %s, %s, %s, %s, %s %s)")
                    "VALUES (%(player_id)s, %(player_firstname)s, %(player_lastname)s, %(player_birthday)s, %(player_college)s, %(player_height)s, %(player_weight)s, %(player_years_pro)s, %(player_position)s, %(player_nfl_team)s)")

                # Insert player information
                data_player = {
                    'player_id': player_id,
                    'player_firstname': player_firstname,
                    'player_lastname': player_lastname,
                    'player_birthday': player_birthday,
                    'player_college': player_college,
                    'player_height': player_height,
                    'player_weight': player_weight,
                    'player_years_pro': player_years_pro,
                    'player_position': player_position,
                    'player_nfl_team': player_nfl_team,

                }

                cursor.execute(add_player, data_player)

            else:
                continue



    cnx.commit()
    cursor.close()
    #Disconnect from the database
    print("Disconnected")
    cnx.close()


        #for p in data:
        #    if ('position' in data[p]):
        #        print(data[p]['position'])
        #    else:
        #        continue

            #print(data[p]['first_name'] + " Test")
