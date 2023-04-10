-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT *
FROM campaign;

SELECT cf_id, backers_count, outcome
FROM campaign
WHERE outcome LIKE '%live%'
ORDER BY cf_id DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT *
FROM backers;

SELECT DISTINCT ON (cf_id) cf_id, COUNT(backer_id)
FROM backers
GROUP BY cf_id
ORDER BY cf_id DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT *
FROM contacts;
SELECT *
FROM campaign;

SELECT 
c.first_name, 
c.last_name, 
c.email, 
(cn.goal - cn.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as c
INNER JOIN campaign as cn
ON (c.contact_id = cn.contact_id)
WHERE cn.outcome LIKE '%live%'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT *
FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT *
FROM backers;
SELECT *
FROM campaign;

SELECT 
b.email,
b.first_name, 
b.last_name, 
b.cf_id,
c.company_name,
c.description,
c.end_date,
(c.goal - c.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as c
ON (b.cf_id = c.cf_id)
WHERE c.outcome LIKE '%live%'
ORDER BY b.email DESC;

-- Check the table
SELECT *
FROM email_backers_remaining_goal_amount;

