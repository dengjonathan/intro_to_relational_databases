-- Creates database schema and views for the tournament project.
-- From VM, run with command psql \i tournament.sql

create database tournament;
\c tournament;

create table players
  (player_name text,
   player_id serial primary key
  );

create table matches
  (match_id serial primary key,
   winning_player_id integer references players(player_id),
   losing_player_id integer references players(player_id)
  );

create view wins as
  select players.player_id, count(matches.winning_player_id) as wins
  from players
  left join matches
  on players.player_id = matches.winning_player_id
  group by players.player_id
  order by wins desc;

create view losses as
  select players.player_id, count(matches.losing_player_id) as losses
  from players
  left join matches
  on players.player_id = matches.losing_player_id
  group by players.player_id
  order by losses desc;

--creates view using views (wins, losses) to show entire match history by player
create view match_record as
 select wins.player_id as player_id, wins.wins as wins,
 losses.losses as losses, (wins + losses) as total
 from wins, losses
 where wins.player_id = losses.player_id
 order by total desc;

--adds to match_record view by adding player's name
create view player_records as
  select players.player_id as player_id,
         players.player_name as player_name,
         match_record.wins as wins,
         match_record.losses as losses,
         match_record.total as total_matches
  from players left join match_record
  on players.player_id = match_record.player_id
  order by wins desc;
