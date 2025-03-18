use guvi_projects;

CREATE TABLE `t20_matches` (
   `id` int NOT NULL AUTO_INCREMENT primary key,
   `match_date` date DEFAULT NULL,
   `ball_per_over` int DEFAULT NULL,
   `city` varchar(100) DEFAULT NULL,
   `gender` varchar(20) DEFAULT NULL,
   `match_type` varchar(20) DEFAULT NULL,
   `match_type_no` int DEFAULT NULL,
   `outcome_winner` varchar(150) DEFAULT NULL,
   `outcome_by_runs` int,
   `overs` int DEFAULT NULL,
   `season` varchar(20) ,
   `team_type` varchar(100),
   `teams` varchar(150),
   `toss_winner` varchar(100),
   `toss_decision` varchar(20),
   `match_no` int ,
   `event_name` varchar(150),
   `venue` varchar(200)
 );
 
 CREATE TABLE `test_matches` (
   `id` int NOT NULL AUTO_INCREMENT primary key,
   `match_date` date DEFAULT NULL,
   `ball_per_over` int DEFAULT NULL,
   `city` varchar(100) DEFAULT NULL,
   `gender` varchar(20) DEFAULT NULL,
   `match_type` varchar(20) DEFAULT NULL,
   `match_type_no` int DEFAULT NULL,
   `outcome_winner` varchar(150) DEFAULT NULL,
   `outcome_by_runs` int,
   `overs` int DEFAULT NULL,
   `season` varchar(20) ,
   `team_type` varchar(100),
   `teams` varchar(150),
   `toss_winner` varchar(100),
   `toss_decision` varchar(20),
   `match_no` int ,
   `event_name` varchar(150),
   `venue` varchar(200)
 );
 
 CREATE TABLE `ipl_matches` (
   `id` int NOT NULL AUTO_INCREMENT primary key,
   `match_date` date DEFAULT NULL,
   `ball_per_over` int DEFAULT NULL,
   `city` varchar(100) DEFAULT NULL,
   `gender` varchar(20) DEFAULT NULL,
   `match_type` varchar(20) DEFAULT NULL,
   `match_type_no` int DEFAULT NULL,
   `outcome_winner` varchar(150) DEFAULT NULL,
   `outcome_by_runs` int,
   `overs` int DEFAULT NULL,
   `season` varchar(20) ,
   `team_type` varchar(100),
   `teams` varchar(150),
   `toss_winner` varchar(100),
   `toss_decision` varchar(20),
   `match_no` int ,
   `event_name` varchar(150),
   `venue` varchar(200)
 );
 
 CREATE TABLE `odi_matches` (
   `id` int NOT NULL AUTO_INCREMENT primary key,
   `match_date` date DEFAULT NULL,
   `ball_per_over` int DEFAULT NULL,
   `city` varchar(100) DEFAULT NULL,
   `gender` varchar(20) DEFAULT NULL,
   `match_type` varchar(20) DEFAULT NULL,
   `match_type_no` int DEFAULT NULL,
   `outcome_winner` varchar(150) DEFAULT NULL,
   `outcome_by_runs` int,
   `overs` int DEFAULT NULL,
   `season` varchar(20) ,
   `team_type` varchar(100),
   `teams` varchar(150),
   `toss_winner` varchar(100),
   `toss_decision` varchar(20),
   `match_no` int ,
   `event_name` varchar(150),
   `venue` varchar(200)
 );
 
 create table t20_match_innings(
  id int NOT NULL AUTO_INCREMENT primary key,
  t20_id int ,
  team varchar(100),
  overs int,
  batter varchar(100),
  bowler varchar(100),
  non_striker varchar(100),
  runs_batter int,
  runs_extras int,
  runs_totals int,
  FOREIGN KEY (`t20_id`) REFERENCES `t20_matches` (`id`)
  );
  
  create table test_match_innings(
  id int NOT NULL AUTO_INCREMENT primary key,
  t20_id int ,
  team varchar(100),
  overs int,
  batter varchar(100),
  bowler varchar(100),
  non_striker varchar(100),
  runs_batter int,
  runs_extras int,
  runs_totals int,
  FOREIGN KEY (`t20_id`) REFERENCES `t20_matches` (`id`)
  );
  
  create table ipl_match_innings(
  id int NOT NULL AUTO_INCREMENT primary key,
  t20_id int ,
  team varchar(100),
  overs int,
  batter varchar(100),
  bowler varchar(100),
  non_striker varchar(100),
  runs_batter int,
  runs_extras int,
  runs_totals int,
  FOREIGN KEY (`t20_id`) REFERENCES `t20_matches` (`id`)
  );
  
  create table odi_match_innings(
  id int NOT NULL AUTO_INCREMENT primary key,
  t20_id int ,
  team varchar(100),
  overs int,
  batter varchar(100),
  bowler varchar(100),
  non_striker varchar(100),
  runs_batter int,
  runs_extras int,
  runs_totals int,
  FOREIGN KEY (`t20_id`) REFERENCES `t20_matches` (`id`)
  );
  
  
