DROP DATABASE IF EXISTS nflproject;
CREATE DATABASE nflproject;

USE nflproject;

CREATE TABLE nfl_team(
	nfl_team_abbreviation VARCHAR(10) PRIMARY KEY,
    nfl_team_name VARCHAR(50) NOT NULL,
    nfl_team_head_coach VARCHAR(50) NOT NULL,
    nfl_team_home_city VARCHAR(50) NOT NULL,
    nfl_team_stadium VARCHAR(50) NOT NULL
);

CREATE TABLE player(
player_id INT PRIMARY KEY,
player_firstname VARCHAR(50) NOT NULL,
player_lastname VARCHAR(50) NOT NULL,
player_birthday DATE NOT NULL,
player_college VARCHAR(50) NOT NULL,
player_height DECIMAL NOT NULL,
player_weight INT NOT NULL,
player_years_pro INT NOT NULL,
player_position VARCHAR(10) NOT NULL,
player_number_of_teams INT,
player_nfl_team VARCHAR(10),

CONSTRAINT player_nfl_team_fk_nfl_team
	FOREIGN KEY (player_nfl_team)
    REFERENCES nfl_team (nfl_team_abbreviation)
);

CREATE TABLE fantasy_team(
fantasy_team_id INT PRIMARY KEY AUTO_INCREMENT,
fantasy_team_name VARCHAR(50) UNIQUE NOT NULL,
fantasy_team_owner VARCHAR(50) NOT NULL
);

CREATE TABLE player_fantasy_team(
player_id INT,
fantasy_team_id INT,
PRIMARY KEY (player_id, fantasy_team_id),

CONSTRAINT player_fantasy_team_fk_player
	FOREIGN KEY (player_id)
	REFERENCES player (player_id),
CONSTRAINT player_fantasy_team_fk_fantasy_team
	FOREIGN KEY (fantasy_team_id)
    REFERENCES fantasy_team (fantasy_team_id)
);

INSERT INTO `nfl_team` VALUES 
('NE', 'New England Patriots', 'Bill Belichick', 'Foxborough, MA', 'Gillette Stadium'),
('BUF', 'Buffalo Bills', 'Sean McDermott', 'Orchard Park, NY', 'New Era Field'),
('MIA', 'Miami Dolphins', 'Brian Flores', 'Miami Gardens, FL', 'Hard Rock Stadium'),
('NYJ', 'New York Jets', 'Adam Gase', 'East Rutherford, NJ', 'MetLife Stadium'),
('BAL', 'Baltimore Ravens', 'John Harbaugh', 'Baltimore, MD', 'M&T Bank Stadium'),
('CIN', 'Cincinnati Bengals', 'Zac Taylor', 'Cincinnati, OH', 'Paul Brown Stadium'),
('CLE', 'Cleveland Browns', 'Freddie Kitchens', 'Cleveland, OH', 'FirstEnergy Stadium'),
('PIT', 'Pittsburgh Steelers', 'Mike Tomlin', 'Pittsburgh, PA', 'Heinz Field'),
('HOU', 'Houston Texans', 'Bill O\'Brien', 'Houston, TX', 'NRG Stadium'),
('IND', 'Indianapolis Colts', 'Frank Reich', 'Indianapolis, IN', 'Lucas Oil Stadium'),
('JAX', 'Jacksonville Jaguars', 'Doug Marrone', 'Jacksonville, FL', 'TIAA Bank Field'),
('TEN', 'Tennessee Titans', 'Mike Vrabel', 'Nashville, TN', 'Nissan Stadium'),
('DEN', 'Denver Broncos', 'Vic Fangio', 'Denver, CO', 'Broncos Stadium at Mile High'),
('KC', 'Kansas City Chiefs', 'Andy Reid', 'Kansas City, MO', 'Arrowhead Stadium'),
('SD', 'San Diego Chargers', 'Anthony Lynn', 'San Diego, CA', 'SDCCU Stadium'),
('OAK', 'Oakland Raiders', 'Jon Gruden', 'Oakland, CA', 'Oakland–Alameda County Coliseum'),
('DAL', 'Dallas Cowboys', 'Jason Garrett', 'Arlington, TX', 'AT&T Stadium'),
('NYG', 'New York Giants', 'Pat Shurmur', 'East Rutherford, NJ', 'MetLife Stadium'),
('PHI', 'Philadelphia Eagles', 'Doug Pederson', 'Philadelphia, PA', 'Lincoln Financial Field'),
('WAS', 'Washington Redskins', 'Jay Gruden', 'Landover, MD', 'FedExField'),
('CHI', 'Chicago Bears', 'Matt Nagy', 'Chicago, IL', 'Soldier Field'),
('DET', 'Detroit Lions', 'Matt Patricia', 'Detroit, MI', 'Ford Field'),
('GB', 'Green Bay Packers', 'Matt LaFleur', 'Green Bay WI', 'Lambeau Field'),
('MIN', 'Minnesota Vikings', 'Mike Zimmer', 'Minneapolis, MN', 'U.S. Bank Stadium'),
('ATL', 'Atlanta Falcons', 'Dan Quinn', 'Atlanta, GA', 'Mercedes-Benz Stadium'),
('CAR', 'Carolina Panthers', 'Ron Rivera', 'Charlotte, NC', 'Bank of America Stadium'),
('NO', 'New Orleans Saints', 'Sean Payton', 'New Orleans, LA', 'Mercedes-Benz Superdome'),
('TB', 'Tampa Bay Buccaneers', 'Bruce Arians', 'Tampa Bay, FL', 'Raymond James Stadium'),
('ARI', 'Arizona Cardinals', 'Kliff Kingsbury', 'Glendale, AZ', 'State Farm Stadium'),
('LA', 'Los Angeles Rams', 'Sean McVay', 'Los Angeles, CA', 'Los Angeles Memorial Coliseum'),
('SF', 'San Francisco 49ers', 'Kyle Shanahan', 'Santa Clara, CA', 'Levi\'s Stadium'),
('SEA', 'Seattle Seahawks', 'Pete Carroll', 'Seattle, WA', 'CenturyLink Field');