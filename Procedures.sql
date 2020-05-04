use nflproject;

DROP PROCEDURE IF EXISTS fetch_teams;
DELIMITER $$
CREATE PROCEDURE fetch_teams ()

BEGIN

SELECT * from fantasy_team;

END $$
DELIMITER ;

-- CALL fetch_teams();


DROP PROCEDURE IF EXISTS players_by_position;
DELIMITER $$
CREATE PROCEDURE players_by_position (position_code VARCHAR(10))

BEGIN

SELECT * from player WHERE player_position = position_code;

END $$
DELIMITER ;
CALL players_by_position("WR");



DROP PROCEDURE IF EXISTS add_player_to_fantasy_team;
DELIMITER $$
CREATE PROCEDURE add_player_to_fantasy_team (player_id INT, team_id INT)

BEGIN

INSERT INTO `player_fantasy_team` VALUES 
(player_id, team_id);

END $$
DELIMITER ;
-- CALL add_player_to_fantasy_team(222, 1);


DROP PROCEDURE IF EXISTS view_players_on_fantasy_team;
DELIMITER $$
CREATE PROCEDURE view_players_on_fantasy_team (team_id INT)

BEGIN

SELECT * FROM player WHERE player_ID IN
(SELECT player_id FROM player_fantasy_team WHERE fantasy_team_id = team_id);

END $$
DELIMITER ;

CALL view_players_on_fantasy_team(1);