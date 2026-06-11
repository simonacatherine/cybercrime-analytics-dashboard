create database cybercrime_analysis;
use cybercrime_analysis;

CREATE TABLE cybercrime_9A1 (
    state_ut VARCHAR(100),
    cases_2022 INT,
    cases_2023 INT,
    cases_2024 INT,
    population_lakhs DECIMAL(10,1),
    crime_rate_2024 DECIMAL(10,1),
    chargesheet_rate_2024 DECIMAL(10,1),
    growth_22_23 DECIMAL(10,2),
    growth_23_24 DECIMAL(10,2)
);

select count(*) from cybercrime_9a1;

select state_ut, cases_2024
from cybercrime_9a1
order by cases_2024 desc
limit 10;

select state_ut, growth_23_24
from cybercrime_9a1
order by growth_23_24 desc
limit 10;

select state_ut, cases_2024, rank() over(order by cases_2024 desc) as crime_rank
from cybercrime_9a1;

select state_ut, population_lakhs, cases_2024, round(cases_2024 / population_lakhs, 2) as crime_density
from cybercrime_9a1
order by crime_density desc;

SELECT
    state_ut,
    cases_2024,
    CASE
        WHEN cases_2024 > 10000
        THEN 'High Risk'
        WHEN cases_2024 > 3000
        THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level
FROM cybercrime_9A1;

SELECT
    state_ut,
    cases_2022,
    cases_2024,
    (cases_2024 - cases_2022)
    AS increase_in_cases
FROM cybercrime_9A1
ORDER BY increase_in_cases DESC;

SELECT *
FROM cybercrime_9A2
ORDER BY fraud_total DESC
LIMIT 10;

ALTER TABLE cybercrime_9a2
RENAME COLUMN `ï»¿State_UT` TO `State_UT`;

SELECT state_ut, fraud_total
FROM cybercrime_9A2
ORDER BY fraud_total DESC
LIMIT 10;

alter table cybercrime_9a2
add column fraud_percentage decimal(10,2)
generated always as (
	case
		when total_cases = 0 then 0
        else (fraud_total / total_cases) * 100
	end
) stored;

SELECT state_ut, fraud_percentage
FROM cybercrime_9A2
ORDER BY fraud_percentage DESC
LIMIT 10;

SELECT
    state_ut,
    identity_theft,
    RANK() OVER(
        ORDER BY identity_theft DESC
    ) AS rank_num
FROM cybercrime_9A2;

SELECT
    state_ut,
    GREATEST(
        fraud_total,
        identity_theft,
        cyber_stalking,
        fake_profile,
        defamation_morphing,
        online_gambling
    ) AS dominant_value
FROM cybercrime_9A2;