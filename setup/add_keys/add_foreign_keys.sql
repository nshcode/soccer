
ALTER TABLE competition
    ADD CONSTRAINT competition_area_fk
      FOREIGN KEY (areaid) REFERENCES areas(areaid)
;
-- ====
ALTER TABLE team 
    ADD CONSTRAINT team_area_fk
      FOREIGN KEY (areaid) REFERENCES areas(areaid)
;
-- ====
ALTER TABLE coach
    ADD CONSTRAINT coach_birtharea_fk
      FOREIGN KEY (birthareaid) REFERENCES areas(areaid)
;
ALTER TABLE coach
    ADD CONSTRAINT coach_passportarea_fk
      FOREIGN KEY (passportareaid) REFERENCES areas(areaid)
;
-- ==== 
ALTER TABLE player 
    ADD CONSTRAINT player_role_fk
      FOREIGN KEY (roleid) REFERENCES playerrole(roleid)
;
ALTER TABLE player
    ADD CONSTRAINT player_birtharea_fk
      FOREIGN KEY (birthareaid) REFERENCES areas(areaid)
;
ALTER TABLE player
    ADD CONSTRAINT player_passportarea_fk
      FOREIGN KEY (passportareaid) REFERENCES areas(areaid)
;
-- ====
ALTER TABLE referee
    ADD CONSTRAINT referee_birtharea_fk
      FOREIGN KEY  (birthareaid) REFERENCES areas(areaid)
;
ALTER TABLE referee
    ADD CONSTRAINT referee_passportarea_fk
      FOREIGN KEY  (passportareaid) REFERENCES areas(areaid)
;
-- ====
ALTER TABLE match
    ADD CONSTRAINT match_competition_fk
      FOREIGN KEY  (competitionid) REFERENCES competition(competitionid)
;
-- ====
ALTER TABLE matchteam 
    ADD CONSTRAINT matchteam_match_fk
      FOREIGN KEY  (matchid) REFERENCES match(matchid)
;
ALTER TABLE matchteam 
    ADD CONSTRAINT matchteam_team_fk
      FOREIGN KEY  (teamid) REFERENCES team(teamid)
;
ALTER TABLE matchteam 
    ADD CONSTRAINT matchteam_coach_fk
      FOREIGN KEY  (coachid) REFERENCES coach(coachid)
;
-- ====
ALTER TABLE matchplayer
    ADD CONSTRAINT matchplayer_matchteam_fk
      FOREIGN KEY  (matchid, teamid) REFERENCES matchteam(matchid, teamid)
;
ALTER TABLE matchplayer
    ADD CONSTRAINT matchplayer_player_fk
      FOREIGN KEY  (playerid) REFERENCES player(playerid)
;
-- ====
ALTER TABLE matchreferee
    ADD CONSTRAINT matchreferee_match_fk
      FOREIGN KEY  (matchid) REFERENCES match(matchid)
;
ALTER TABLE matchreferee
    ADD CONSTRAINT matchreferee_referee_fk
    FOREIGN KEY  (refereeid) REFERENCES referee(refereeId)
;
-- ====
ALTER TABLE matchsubstitution
    ADD CONSTRAINT matchsubstitution_match_team_fk
      FOREIGN KEY  (matchid, teamid) REFERENCES matchteam(matchid, teamid)
;
ALTER TABLE matchsubstitution
    ADD CONSTRAINT matchsubstitution_playeroutid_fk
      FOREIGN KEY  (playeroutid) REFERENCES player (playerid)
;
ALTER TABLE matchsubstitution
    ADD CONSTRAINT matchsubstitution_playerinid_fk
      FOREIGN KEY  (playerinid) REFERENCES player (playerid)
;
-- ====
ALTER TABLE eventtype
    ADD CONSTRAINT eventtype_supertype_fk
      FOREIGN KEY  (supertypeid) REFERENCES eventtype(typeid)
;
-- ====
ALTER TABLE event
    ADD CONSTRAINT event_posaid_fk
      FOREIGN KEY (posaid) REFERENCES position(id)
;
ALTER TABLE event
    ADD CONSTRAINT event_posbid_fk
      FOREIGN KEY (posbid) REFERENCES position(id)
;
ALTER TABLE event 
    ADD CONSTRAINT event_eventtype_fk
      FOREIGN KEY (eventtypeid) REFERENCES eventtype (typeid)
;
