USE mavenfuzzyfactory;

/* COMPARING BOUNCE RATES

	Bounce Rate - percentage of viewers who click off the website after only one page
    
	Task: 
    test new landing page 'lander-1' against the homepage for only gsearch nonbrand traffic and evalute their bounce rates.
    'lander-1' is successful if bounce rate is lower than the default home page

*/ 

-- Intial query to filter in on gsearch and nonbrand ad campaigns
SELECT *
FROM website_pageviews wp 
	JOIN website_sessions ws ON wp.website_session_id = ws.website_session_id
WHERE utm_source = 'gsearch' AND utm_campaign = 'nonbrand';

-- STEP 1: Date lookup for when lander1 went live
SELECT 
	MIN(DATE(created_at)) AS lander_1_launch_date
FROM website_pageviews
WHERE pageview_url = '/lander-1';

-- STEP 2: Find session ID for all the pages that a viewer landed on
DROP TABLE IF EXISTS landing_page_id;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page_id
SELECT 
	MIN(website_pageview_id) AS first_pageview_id,
    wp.website_session_id
FROM website_pageviews wp 
	JOIN website_sessions ws ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at BETWEEN '2012-06-19' AND '2012-07-28'
	AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY wp.website_session_id;

SELECT * FROM landing_page_id;

-- STEP 3: Filter the landing pages to only the homepage and lander-1
DROP TABLE IF EXISTS landing_page_home_lander1;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page_home_lander1
SELECT 
	lp.first_pageview_id,
    lp.website_session_id,
    pageview_url AS landing_page
FROM landing_page_id lp
	JOIN website_pageviews wp ON lp.first_pageview_id = wp.website_pageview_id
WHERE pageview_url IN ('/home', '/lander-1');

SELECT * FROM landing_page_home_lander1;

-- STEP 4: Find all the bounce sessions where landing page is either the homepage or lander-1
DROP TABLE IF EXISTS bounce_session_id;

CREATE TEMPORARY TABLE IF NOT EXISTS bounce_session_id
SELECT
	lp.website_session_id,
    lp.landing_page,
    COUNT(lp.first_pageview_id) AS bounce_session
FROM landing_page_home_lander1 lp
	JOIN website_pageviews wp ON lp.website_session_id = wp.website_session_id
GROUP BY 1,2
HAVING bounce_session = 1;

SELECT * FROM bounce_session_id;

/* 
STEP 5: Calculate total sessions where homepage or lander-1 was the landing page,
		all the bounce sessions for the two landing pages,
        and the bounce ratio
*/
SELECT
	lp.landing_page,
	COUNT(lp.first_pageview_id) AS sessions,
    COUNT(bounce_session) AS bounce_session,
    COUNT(bounce_session)/COUNT(lp.first_pageview_id) AS bouce_ratio
FROM landing_page_home_lander1 lp
	LEFT JOIN bounce_session_id bs ON lp.website_session_id = bs.website_session_id
GROUP BY landing_page;
    
    
    

