# 1.TOTAL MATCH WON BY TEAMS

SELECT outcome_winner AS team_name, COUNT(*) AS matches_won
FROM t20_matches
WHERE outcome_winner IS NOT NULL
GROUP BY outcome_winner
ORDER BY matches_won DESC;


# 2.total match won by the team accross the season in all matches(T20,test,odi,ipl)

SELECT season, outcome_winner AS team,"T20" as match_type, COUNT(*) AS matches_won
FROM t20_matches
GROUP BY season, outcome_winner
UNION
SELECT season, outcome_winner AS team,"Test" as match_type, COUNT(*) AS matches_won
FROM test_matches
GROUP BY season, outcome_winner
UNION
SELECT season, outcome_winner AS team,"IPL" as match_type, COUNT(*) AS matches_won
FROM IPL_matches
GROUP BY season, outcome_winner
UNION
SELECT season, outcome_winner AS team,"ODI" as match_type, COUNT(*) AS matches_won
FROM odi_matches
GROUP BY season, outcome_winner;

# 3. toss impact on winning over match_type

SELECT "t20" as match_type,toss_decision,COUNT(*) AS total_matches,SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) AS matches_won,
ROUND(SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_percentage FROM t20_matches
WHERE toss_decision IS NOT NULL AND outcome_winner IS NOT NULL GROUP BY toss_decision
union
SELECT "test" as match_type,toss_decision,COUNT(*) AS total_matches,SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) AS matches_won,
ROUND(SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_percentage FROM test_matches
WHERE toss_decision IS NOT NULL AND outcome_winner IS NOT NULL GROUP BY toss_decision
union
SELECT "IPL" as match_type,toss_decision,COUNT(*) AS total_matches,SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) AS matches_won,
ROUND(SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_percentage FROM ipl_matches
WHERE toss_decision IS NOT NULL AND outcome_winner IS NOT NULL GROUP BY toss_decision
union
SELECT "ODI" as match_type,toss_decision,COUNT(*) AS total_matches,SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) AS matches_won,
ROUND(SUM(CASE WHEN toss_winner = outcome_winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_percentage FROM odi_matches
WHERE toss_decision IS NOT NULL AND outcome_winner IS NOT NULL GROUP BY toss_decision;

# 4. top 5 wins per each match type
SELECT outcome_winner AS team,COUNT(*) AS matches_won FROM  t20_matches WHERE outcome_winner IS NOT NULL GROUP BY outcome_winner ORDER BY 
matches_won DESC limit 5;

# 5. Venues Favorable to Each Team (t20)

SELECT outcome_winner AS team,venue,COUNT(*) AS matches_won FROM t20_matches WHERE 
outcome_winner IS NOT NULL AND venue IS NOT NULL
GROUP BY outcome_winner, venue
ORDER BY  matches_won desc;

# 6. Total Runs Scored by Each Team Across All Matches

SELECT i.team,SUM(i.runs_totals) AS total_runs FROM t20_matches m
JOIN t20_match_innings i ON m.id = i.t20_id GROUP BY i.team ORDER BY total_runs DESC;

# 7. Average Runs per Match by Team T20

SELECT 
    i.team,
    COUNT(DISTINCT i.t20_id) AS matches_played,
    SUM(i.runs_totals) AS total_runs,
    ROUND(SUM(i.runs_totals) * 1.0 / COUNT(DISTINCT i.t20_id), 2) AS avg_runs_per_match
FROM 
    t20_matches m
JOIN 
    t20_match_innings i ON m.id = i.t20_id
GROUP BY 
    i.team
ORDER BY 
    avg_runs_per_match DESC;

# 8. Bowler Economy Rate
SELECT 
    i.bowler,
    COUNT(*) AS balls_bowled,
    ROUND(COUNT(*) / 6.0, 2) AS overs_bowled,
    SUM(i.runs_totals) AS runs_conceded,
    ROUND(SUM(i.runs_totals) / (COUNT(*) / 6.0), 2) AS economy_rate
FROM 
    t20_match_innings i
GROUP BY 
    i.bowler
HAVING 
    balls_bowled >= 12  -- Filter to bowlers with at least 2 overs bowled
ORDER BY 
    economy_rate ASC
LIMIT 10; 

#9.Top 10 batter based on Run Scorers of t20 

SELECT 
    batter,
    SUM(runs_batter) AS total_runs,
    COUNT(*) AS balls_faced,
    ROUND(SUM(runs_batter) * 1.0 / COUNT(*), 2) AS strike_rate
FROM 
    t20_match_innings
GROUP BY 
    batter
HAVING 
    balls_faced >= 20 
ORDER BY 
    total_runs DESC
LIMIT 10;

# 10. Top 10 batter based on Run Scorers of ipl
SELECT 
    batter,
    SUM(runs_batter) AS total_runs,
    COUNT(*) AS balls_faced,
    ROUND(SUM(runs_batter) * 1.0 / COUNT(*), 2) AS strike_rate
FROM 
    ipl_match_innings
GROUP BY 
    batter
HAVING 
    balls_faced >= 20 
ORDER BY 
    total_runs DESC
LIMIT 10;


# 11. Top 10 batter based on Run Scorers of odi
SELECT 
    batter,
    SUM(runs_batter) AS total_runs,
    COUNT(*) AS balls_faced,
    ROUND(SUM(runs_batter) * 1.0 / COUNT(*), 2) AS strike_rate
FROM 
    odi_match_innings
GROUP BY 
    batter
HAVING 
    balls_faced >= 20 
ORDER BY 
    total_runs DESC
LIMIT 10;

#12. Average Runs per Match by Team ipl

SELECT 
    i.team,
    COUNT(DISTINCT i.t20_id) AS matches_played,
    SUM(i.runs_totals) AS total_runs,
    ROUND(SUM(i.runs_totals) * 1.0 / COUNT(DISTINCT i.t20_id), 2) AS avg_runs_per_match
FROM 
    ipl_matches m
JOIN 
    ipl_match_innings i ON m.id = i.t20_id
GROUP BY 
    i.team
ORDER BY 
    avg_runs_per_match DESC;

# 13. Top 10 Highest Individual Scores
SELECT 
    batter,
    t20_id,
    SUM(runs_batter) AS individual_score
FROM 
    t20_innings
GROUP BY 
    t20_id, batter
ORDER BY 
    individual_score DESC
LIMIT 10;

# 14. Venues Favorable to Each Team (odi)
SELECT outcome_winner AS team,venue,COUNT(*) AS matches_won FROM odi_matches WHERE 
outcome_winner IS NOT NULL AND venue IS NOT NULL
GROUP BY outcome_winner, venue
ORDER BY  matches_won desc;

# 15.Top Batter Per Team  in t20

WITH batter_matches AS (
    SELECT 
        team,
        batter,
        COUNT(DISTINCT t20_id) AS matches_played
    FROM 
        t20_match_innings
    GROUP BY 
        team, batter
)

SELECT 
    team,
    batter,
    matches_played
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY matches_played DESC) AS rn
    FROM 
        batter_matches
) ranked
WHERE rn = 1
ORDER BY team;


# 15.Top Batter Per Team  in t20

WITH batter_matches AS (
    SELECT 
        team,
        batter,
        COUNT(DISTINCT t20_id) AS matches_played
    FROM 
        t20_match_innings
    GROUP BY 
        team, batter
)


SELECT 
    team,
    batter,
    matches_played
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY matches_played DESC) AS rn
    FROM 
        batter_matches
) ranked
WHERE rn = 1
ORDER BY team;


# 16.Top Batter Per Team  in odi
WITH batter_matches AS (
    SELECT 
        team,
        batter,
        COUNT(DISTINCT t20_id) AS matches_played
    FROM 
        odi_match_innings
    GROUP BY 
        team, batter
)

SELECT 
    team,
    batter,
    matches_played
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY matches_played DESC) AS rn
    FROM 
        batter_matches
) ranked
WHERE rn = 1
ORDER BY team;

# 17.Top Batter Per Team  in ipl
WITH batter_matches AS (
    SELECT 
        team,
        batter,
        COUNT(DISTINCT t20_id) AS matches_played
    FROM 
        ipl_match_innings
    GROUP BY 
        team, batter
)

SELECT 
    team,
    batter,
    matches_played
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY matches_played DESC) AS rn
    FROM 
        batter_matches
) ranked
WHERE rn = 1
ORDER BY team;

# 18.Top Batter Per Team  in test
WITH batter_matches AS (
    SELECT 
        team,
        batter,
        COUNT(DISTINCT t20_id) AS matches_played
    FROM 
        test_match_innings
    GROUP BY 
        team, batter
)

SELECT 
    team,
    batter,
    matches_played
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY matches_played DESC) AS rn
    FROM 
        batter_matches
) ranked
WHERE rn = 1
ORDER BY team;

# 19. Average Runs per Match by Team odi

SELECT 
    i.team,
    COUNT(DISTINCT i.t20_id) AS matches_played,
    SUM(i.runs_totals) AS total_runs,
    ROUND(SUM(i.runs_totals) * 1.0 / COUNT(DISTINCT i.t20_id), 2) AS avg_runs_per_match
FROM 
    odi_matches m
JOIN 
    odi_match_innings i ON m.id = i.t20_id
GROUP BY 
    i.team
ORDER BY 
    avg_runs_per_match DESC;

# 20. Bowler Economy Rate
SELECT 
    i.bowler,
    COUNT(*) AS balls_bowled,
    ROUND(COUNT(*) / 6.0, 2) AS overs_bowled,
    SUM(i.runs_totals) AS runs_conceded,
    ROUND(SUM(i.runs_totals) / (COUNT(*) / 6.0), 2) AS economy_rate
FROM 
    odi_match_innings i
GROUP BY 
    i.bowler
HAVING 
    balls_bowled >= 12  -- Filter to bowlers with at least 2 overs bowled
ORDER BY 
    economy_rate ASC
LIMIT 10; 

