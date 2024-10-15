USE mavenfuzzyfactory;

-- Finding top traffic sources
SELECT
	utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY 1,2,3
ORDER BY sessions DESC;

-- Traffic Source Trending
SELECT
    MIN(DATE(created_at)) AS week_start_date, 
    COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at <= '2012-05-12'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);

-- Trending with granular segments (device type and paid traffic)
SELECT 
	MIN(DATE(created_at)) AS week_start_date,
    COUNT(CASE WHEN device_type = 'desktop' THEN website_session_id END) AS desktop_session,
    COUNT(CASE WHEN device_type = 'mobile' THEN website_session_id END) AS mobile_session,
    COUNT(website_session_id) AS total
FROM website_sessions ws
WHERE ws.created_at BETWEEN '2012-04-15' AND '2012-06-19'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);
