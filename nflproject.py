#!/usr/bin/env python3

import mysql.connector


def create_fantasy_team():
  cursor = cnx.cursor()
  #print("stuff to do")
  fantasy_team_name = input("Enter team name:")
  fantasy_team_owner = input("Enter owner name:")
  add_fantasy_team = ("INSERT INTO fantasy_team "
    "(fantasy_team_name, fantasy_team_owner) "
    "VALUES (%(fantasy_team_name)s, %(fantasy_team_owner)s)")
  data_fantasy_team = {
    'fantasy_team_name': fantasy_team_name,
    'fantasy_team_owner': fantasy_team_owner,
  }
  cursor.execute(add_fantasy_team, data_fantasy_team)
  cnx.commit()
  cursor.close()


def print_fantasy_teams():
  cursor = cnx.cursor()
  query = ("SELECT * FROM fantasy_team")
  
  cursor.execute(query)

  for (fantasy_team_id, fantasy_team_name, fantasy_team_owner) in cursor:
    print("Fantasy team id: " + str(fantasy_team_id) + ", Fantasy team name: " + str(fantasy_team_name) + ", Fantasy team owner: " + str(fantasy_team_owner))
  
  cursor.close()


def view_players():
  cursor = cnx.cursor()
  #print("Testing function call")
  player_position = input("Enter a position to view players by position")
  args = [player_position]
  result = cursor.callproc('players_by_position', args)
  #TODO: This needs some formatting to make it pretty
  for result in cursor.stored_results():
    players = result.fetchall()
    for row in players:
      print(row)
      '''
      dict = {}
      for key in row:
        dict[key.encode('utf8')] = row[key.encode('utf8')]
      buffer = ' ' 
      for key in dict:
        buffer += str(key) + ': ' + str(dict[key]) + ', '
      print(buffer[:(len(buffer) - 2)] + '\n')'''
  cursor.close()


def get_fantasy_team_ids():
  cursor = cnx.cursor()
  fantasy_team_ids = []
  cursor.execute('SELECT fantasy_team_id FROM fantasy_team')
  for row in cursor.fetchall():
    fantasy_team_ids.append(row[0])
  cursor.close()
  return(fantasy_team_ids)

  
def add_player_to_fantasy_team():
  cursor = cnx.cursor()
  #print("Testing add player to fantasy team function call")
  fantasy_team_id = 0
  player_nfl_id = 0
  fantasy_team_ids = get_fantasy_team_ids()
  print("List of current teams:")
  print_fantasy_teams()

  while 1: 
    fantasy_team_id = int(input("Enter the team ID:"))
    if fantasy_team_id in fantasy_team_ids:
      break
    else:
      print("Not a valid team ID.")  

  player_nfl_id = int(input("Enter the player's NFL ID:"))

  args = [player_nfl_id, fantasy_team_id]
  result = cursor.callproc('add_player_to_fantasy_team', args)
  cnx.commit()
  cursor.close()


def view_players_on_fantasy_team():
  cursor = cnx.cursor()
  fantasy_team_id = 0
 
  fantasy_team_ids = get_fantasy_team_ids()
  print("List of current teams:")
  print_fantasy_teams()

  while 1: 
    fantasy_team_id = int(input("Enter the team ID:"))
    if fantasy_team_id in fantasy_team_ids:
      break
    else:
      print("Not a valid team ID.")

  args = [fantasy_team_id]
  result = cursor.callproc('view_players_on_fantasy_team', args)
  for result in cursor.stored_results():
    players = result.fetchall()
    for row in players:
      print(row)
  cursor.close()


# Main Function 
if __name__ == '__main__':

  #Connect to the database
  print("Connecting to database")
  cnx = mysql.connector.connect(user='root', password='root',
    host='127.0.0.1',
    database='nflproject')

  #cursor = cnx.cursor()

  while 1:

    program_options = ['exit', 'create fantasy team', 'view fantasy teams', 'view players', 
      'view players on fantasy team', 'add player to fantasy team']
    print("What would you like to do? Possible options:\n" + str(program_options))
    user_input = input('Enter option:')


    if (user_input == "create fantasy team"):
      create_fantasy_team()

    elif (user_input == "view fantasy teams"):
      print_fantasy_teams()

    elif (user_input == "view players"):
      view_players()

    elif (user_input == "add player to fantasy team"):
      add_player_to_fantasy_team()

    elif (user_input == "view players on fantasy team"):
      view_players_on_fantasy_team()

    elif (user_input == "exit"):
      #cursor.close()
      #Disconnect from the database
      print("Disconnected")
      cnx.close
      break
    
    else:
      print("Invalid option entered.")
      continue