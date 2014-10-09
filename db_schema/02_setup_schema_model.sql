--
-- Drops just in case you are reloading
---
DROP TABLE IF EXISTS games CASCADE;
DROP TABLE IF EXISTS game_players CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS user_roles CASCADE;

--
-- Add users and role tables, along with a many-to-many join table
--
CREATE TABLE users (
    id            SERIAL PRIMARY KEY,
    username      TEXT NOT NULL,
    password      TEXT NOT NULL,
    email_address TEXT NOT NULL,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    mobile	  TEXT NOT NULL,
    image_url     TEXT NULL,
    created 	  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    updated       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    active        INTEGER
);

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

CREATE TABLE role (
    id   INTEGER PRIMARY KEY,
    role TEXT
);

CREATE TABLE user_role (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- 'game_players' is a many-to-many join table between games & players
CREATE TABLE game_players (
    game_id     INTEGER REFERENCES games(id) ON DELETE CASCADE ON UPDATE CASCADE,
    player_id   INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    player_status TEXT NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (game_id, player_id)
);

