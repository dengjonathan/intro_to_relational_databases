-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
create database tournament;
\c tournament;

create table players
  (player_name text,
   player_id serial,
   primary key (player_id)
  );

create table matches
  (match_id serial,
   winning_player_id serial,
   losing_player_id serial,
   primary key (match_id),
   foreign key (winning_player_id) references players(player_id),
   foreign key (losing_player_id) references players(player_id)
  );
