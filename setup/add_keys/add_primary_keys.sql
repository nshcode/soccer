ALTER TABLE areas
    ADD CONSTRAINT areas_pk
      PRIMARY KEY (areaid)
;

ALTER TABLE competition
    ADD CONSTRAINT competition_pk
      PRIMARY KEY (competitionid)
;

ALTER TABLE team
    ADD CONSTRAINT team_pk
      PRIMARY KEY (teamid)
;

ALTER TABLE coach
    ADD CONSTRAINT coach_pk
      PRIMARY KEY (coachid)
;

ALTER TABLE player
    ADD CONSTRAINT player_pk
      PRIMARY KEY (playerid)
;

ALTER TABLE playerrole
    ADD CONSTRAINT playerrole_pk
      PRIMARY KEY (roleid)
;

ALTER TABLE referee
    ADD CONSTRAINT referee_pk
      PRIMARY KEY (refereeid)
;

ALTER TABLE match
    ADD CONSTRAINT match_pk
    PRIMARY KEY (matchid)
;

ALTER TABLE matchteam
    add constraint matchteam_pk
    PRIMARY KEY (matchid, teamid)
;

ALTER TABLE matchplayer
    ADD CONSTRAINT matchplayer_pk
      PRIMARY KEY (matchid, teamid, playerid)
;

ALTER TABLE matchreferee
    ADD CONSTRAINT matchreferee_pk
      PRIMARY KEY (matchid, refereeid)
;

ALTER TABLE matchsubstitution
    ADD CONSTRAINT matchsubstitution_pk
      PRIMARY KEY (matchid, teamid, playeroutid)
;

ALTER TABLE position 
    ADD CONSTRAINT position_pk
      PRIMARY KEY (id)
;

ALTER TABLE eventtype
    ADD CONSTRAINT eventtype_pk
      PRIMARY KEY (typeid)
;

ALTER TABLE event
    ADD CONSTRAINT event_pk
      PRIMARY KEY (eventid)
;
