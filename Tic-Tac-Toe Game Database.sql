-- ✅ 1. Drop & Create Database
DROP DATABASE IF EXISTS TIC_TAC_TOE_GAME;
CREATE DATABASE TIC_TAC_TOE_GAME;
USE TIC_TAC_TOE_GAME;

-- ✅ 2. Create Tables

-- Player table
CREATE TABLE Player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    join_date DATE DEFAULT CURRENT_DATE
);

-- Game table
CREATE TABLE Game (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    player1_id INT,
    player2_id INT,
    winner_id INT,  -- NULL if draw
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (player1_id) REFERENCES Player(player_id),
    FOREIGN KEY (player2_id) REFERENCES Player(player_id),
    FOREIGN KEY (winner_id) REFERENCES Player(player_id)
);

-- Move history table
CREATE TABLE Move_History (
    move_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT,
    player_id INT,
    move_number INT,
    row_pos INT,
    col_pos INT,
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

-- ✅ 3. Insert Sample Players
INSERT INTO Player (username) VALUES 
('Alice'),
('Bob'),
('Charlie');

-- ✅ 4. Insert Sample Games
INSERT INTO Game (player1_id, player2_id, winner_id, start_time, end_time) VALUES
(1, 2, 1, '2025-07-14 15:00:00', '2025-07-14 15:05:00'),
(2, 3, NULL, '2025-07-14 16:00:00', '2025-07-14 16:06:00'); -- draw

-- ✅ 5. Insert Move History for Game 1 (Alice vs Bob)
INSERT INTO Move_History (game_id, player_id, move_number, row_pos, col_pos) VALUES
(1, 1, 1, 0, 0),
(1, 2, 2, 0, 1),
(1, 1, 3, 1, 1),
(1, 2, 4, 0, 2),
(1, 1, 5, 2, 2); -- Alice wins diagonally

-- ✅ 6. Insert Move History for Game 2 (Bob vs Charlie) - draw
INSERT INTO Move_History (game_id, player_id, move_number, row_pos, col_pos) VALUES
(2, 2, 1, 0, 0),
(2, 3, 2, 0, 1),
(2, 2, 3, 0, 2),
(2, 3, 4, 1, 1),
(2, 2, 5, 2, 0),
(2, 3, 6, 1, 0),
(2, 2, 7, 1, 2),
(2, 3, 8, 2, 1),
(2, 2, 9, 2, 2); -- draw

-- ✅ 7. SELECT (Data Retrieval)

-- Get all players
SELECT * FROM Player;

-- Get all games with winner name (if any)
SELECT 
  g.game_id,
  p1.username AS player1,
  p2.username AS player2,
  pw.username AS winner,
  g.start_time,
  g.end_time
FROM Game g
JOIN Player p1 ON g.player1_id = p1.player_id
JOIN Player p2 ON g.player2_id = p2.player_id
LEFT JOIN Player pw ON g.winner_id = pw.player_id;

-- Get move history of a game
SELECT 
  mh.move_number, 
  p.username, 
  mh.row_pos, 
  mh.col_pos
FROM Move_History mh
JOIN Player p ON mh.player_id = p.player_id
WHERE mh.game_id = 1
ORDER BY mh.move_number;

-- ✅ 8. UPDATE

-- Update username of a player
UPDATE Player
SET username = 'Alicia'
WHERE player_id = 1;

-- ✅ 9. DELETE

-- Delete a player by ID (only if not linked to games due to foreign key)
DELETE FROM Player
WHERE player_id = 3;

-- (To delete safely, you may need to delete moves and games first)
-- Example for full cascade-like manual delete:
DELETE FROM Move_History WHERE player_id = 3;
DELETE FROM Game WHERE player1_id = 3 OR player2_id = 3 OR winner_id = 3;
DELETE FROM Player WHERE player_id = 3;
