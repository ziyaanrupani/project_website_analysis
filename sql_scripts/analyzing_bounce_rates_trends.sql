USE mavenfuzzyfactory;

/*Analyzing Landing Page Trend Analysis

	weekly trended data for all paid nonbrand traffic
    showing the volume between homepage and lander-1,
    and bounce rate 

	To evaluate if web traffic has been diverted to lander-1 
    and track the bounce rate
*/ 

/* STEPS
1. find landing page id
2. fitler landing page id to just home or lander-1
3. filter to bounce session for home or lander-1
4. count landing page and lander-1 from #2 and then ratio
*/

-- Intial query to filter in on nonbrand ad campaigns
SELECT *
FROM website_pageviews wp 
JOIN website_sessions ws 
	ON wp.website_session_id = ws.website_session_id
WHERE utm_campaign = 'nonbrand';


-- STEP 1: Find the landing page for nonbrand traffic between June 1st and Aug 31st
DROP TABLE IF EXISTS landing_page_id;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page_id
SELECT 
	MIN(website_pageview_id) AS first_pageview_id,
    wp.website_session_id
FROM website_pageviews wp 
JOIN website_sessions ws 
	ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at BETWEEN '2012-05-01' AND '2012-09-30'
	AND utm_campaign = 'nonbrand'
GROUP BY wp.website_session_id;

SELECT * FROM landing_page_id;

-- STEP 2: Filter the landing pages to homepage and lander-1
DROP TABLE IF EXISTS landing_page_home_lander1;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page_home_lander1
SELECT 
	lp.first_pageview_id,
    lp.website_session_id AS landing_page_website_session_id,
    pageview_url AS landing_page
FROM landing_page_id lp
JOIN website_pageviews wp 
	ON lp.first_pageview_id = wp.website_pageview_id
WHERE pageview_url IN ('/home', '/lander-1');

SELECT * FROM landing_page_home_lander1;

-- STEP 3: Find all the bounce sessions where landing page is homepage or lander-1
DROP TABLE IF EXISTS bounce_session_id;

CREATE TEMPORARY TABLE IF NOT EXISTS bounce_session
SELECT
	lp.landing_page_website_session_id AS bounce_website_session_id,
    COUNT(lp.first_pageview_id) AS bounce_session
FROM landing_page_home_lander1 lp
JOIN website_pageviews wp 
	ON lp.landing_page_website_session_id = wp.website_session_id
GROUP BY 1
HAVING bounce_session = 1;

SELECT * FROM bounce_session;

/* 

STEP 4: Show weekly trend of all nonbrand campaigns:
		the bounce rate for homepage and lander-1,
        total sessions where the homepage was the landing page,
        and total sessions where lander-1 was the landing page
	
*/
SELECT
	MIN(DATE(ws.created_at)) AS week_start_date,
    COUNT(bounce_website_session_id) / COUNT(landing_page_website_session_id) AS bounce_rate,
    COUNT(CASE WHEN landing_page = '/home' THEN landing_page_website_session_id END) AS home_sessions,
    COUNT(CASE WHEN landing_page = '/lander-1' THEN landing_page_website_session_id END) AS lander_sessions
FROM landing_page_home_lander1 lph
LEFT JOIN bounce_session bs 
	ON lph.landing_page_website_session_id = bs.bounce_website_session_id
JOIN website_sessions ws 
	ON lph.landing_page_website_session_id = ws.website_session_id
GROUP BY WEEK(created_at);







