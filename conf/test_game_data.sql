--
-- Drops just in case you are reloading
---
DROP TABLE IF EXISTS games CASCADE;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS game_players CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS user_roles CASCADE;

--
-- Create a very simple database to hold game and player information
--
-- statuses can be 'IN PROGRESS', 'CONFIRMED', 'CANCELLED'
CREATE TABLE games (
    id          SERIAL PRIMARY KEY,
    name        TEXT,
    scheduled   TIMESTAMP WITH TIME ZONE,
    status      TEXT NOT NULL DEFAULT 'IN PROGRESS',
    created     TIMESTAMP NOT NULL DEFAULT now(),
    updated     TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE players (
    id              SERIAL PRIMARY KEY,
    first_name      TEXT NOT NULL,
    last_name       TEXT NOT NULL,
    username        TEXT NOT NULL,
    password        VARCHAR NOT NULL,
    email_address   TEXT NOT NULL,
    image_url       TEXT NULL,
    mobile          TEXT NOT NULL
);

-- 'game_players' is a many-to-many join table between games & players
CREATE TABLE game_players (
    game_id     INTEGER REFERENCES games(id) ON DELETE CASCADE ON UPDATE CASCADE,
    player_id   INTEGER REFERENCES players(id) ON DELETE CASCADE ON UPDATE CASCADE,
    player_status TEXT NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (game_id, player_id)
);

---
--- Load some sample data
---
INSERT INTO games (name, scheduled) VALUES ('GameWeek1', 'now()');
INSERT INTO games (name, scheduled) VALUES ('GameWeek2', 'now()');
INSERT INTO games (name, scheduled) VALUES ('GameWeek3', 'now()');
INSERT INTO games (name, scheduled) VALUES ('GameWeek4', 'now()');
INSERT INTO games (name, scheduled) VALUES ('GameWeek5', 'now()');

INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Minesh', 'Patel', 'mpatel', '123', 'minesh.patel@blah.co.uk', 'blah.co.uk','0245545456' );
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('James', 'Rodriguez', 'jrodriguez', '123', 'james.rodriguez@blah.co.uk', 'blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Steven', 'Gerrard','sgerrard', '123', 'steven.gerrard@blah.co.uk', 'blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Phillip', 'Coutinho', 'pcoutinho', '123', 'phillip.coutinho@blah.co.uk','blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Lionel', 'Messi', 'lmessi', '123', 'lionel.messi@blah.co.uk', 'blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Cristiano', 'Ronaldo', 'cronaldo', '123', 'cristiano.ronaldo@blah.co.uk','blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Luis', 'Suarez', 'lsuarez', '123', 'luis.suarez@blah.co.uk','blah.co.uk','0245545456');
INSERT INTO players (first_name, last_name, username, password, email_address, image_url, mobile) VALUES ('Gareth', 'Bale', 'gbale', '123', 'gareth.bale@blah.co.uk','blah.co.uk','0245545456');
INSERT INTO game_players (game_id, player_id) VALUES (1, 1);
INSERT INTO game_players (game_id, player_id) VALUES (1, 2);
INSERT INTO game_players (game_id, player_id) VALUES (1, 3);
INSERT INTO game_players (game_id, player_id) VALUES (2, 4);
INSERT INTO game_players (game_id, player_id) VALUES (3, 5);
INSERT INTO game_players (game_id, player_id) VALUES (4, 6);
INSERT INTO game_players (game_id, player_id) VALUES (4, 7);
INSERT INTO game_players (game_id, player_id) VALUES (5, 8);
