USE mavenfuzzyfactory;

/*
Analyzing conversion funnel.

test the updated billing page to see if the click rate is higher than the original
this test is for all traffic and not just search visitors
*/

-- STEP 1: Find when billing-2 went live
SELECT
	MIN(DATE(created_at)) AS billing2_release_date
FROM website_pageviews
WHERE pageview_url = '/billing-2';

-- STEP 2: Filter results where customer saw the original billing page, 
-- 		and the appropriate date and required for analysis
DROP TABLE IF EXISTS billing1;

CREATE TEMPORARY TABLE IF NOT EXISTS billing1
SELECT
	website_session_id,
    MAX(CASE WHEN pageview_url = '/billing' THEN 1 END) AS billing,
    MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 END) AS orders
FROM website_pageviews
WHERE website_session_id IN
(
	SELECT
		DISTINCT website_session_id
	FROM website_pageviews
	WHERE created_at BETWEEN '2012-09-10' AND '2012-11-10'
		AND pageview_url = '/billing'
)
GROUP BY 1;



-- STEP 3: Repeat previous step for billing2 homepage
DROP TABLE IF EXISTS billing2;

CREATE TEMPORARY TABLE IF NOT EXISTS billing2
SELECT
	website_session_id,
    MAX(CASE WHEN pageview_url = '/billing-2' THEN 1 END) AS billing,
    MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 END) AS orders
FROM website_pageviews
WHERE website_session_id IN
(
	SELECT
		DISTINCT website_session_id
	FROM website_pageviews
	WHERE created_at BETWEEN '2012-09-10' AND '2012-11-10'
		AND pageview_url = '/billing-2'
)
GROUP BY 1;

-- STEP 4: Combine the results for both billing and billing2 to determine if clickrate has improved
SELECT 
	'/billing' AS billing_version_seen,
    COUNT(billing) AS sessions,
    COUNT(orders) AS orders,
    COUNT(orders)/COUNT(billing) AS billing_to_order_rt
FROM billing1

UNION

SELECT 
	'/billing-2' AS billing_version_seen,
    COUNT(billing) AS sessions,
    COUNT(orders) AS orders,
    COUNT(orders)/COUNT(billing) AS billing_to_order_rt
FROM billing2;


