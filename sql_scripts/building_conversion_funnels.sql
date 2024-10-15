USE mavenfuzzyfactory;

/*

Building Conversion Funnels

evaluate the click rate from the new lander-1 page to placing an order
limit it to paid the gsearch visitors

*/

-- STEP 1: Find the landing page, in the correct time frame, and gsearch visitors
DROP TABLE IF EXISTS landing_page;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page
SELECT
	MIN(wp.website_pageview_id) AS website_pageview_id,
    wp.website_session_id
FROM website_pageviews wp
JOIN website_sessions ws 
	ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at BETWEEN '2012-08-05' AND '2012-09-05'
	AND utm_source = 'gsearch'
GROUP BY wp.website_session_id;

SELECT * FROM landing_page;

-- STEP 2: Narrow to landing page
DROP TABLE IF EXISTS landing_page_lander1;

CREATE TEMPORARY TABLE IF NOT EXISTS landing_page_lander1 
SELECT *
FROM website_pageviews
WHERE website_session_id IN
(
	SELECT 
		lp.website_session_id
	FROM landing_page lp 
	JOIN website_pageviews wp 
		ON lp.website_pageview_id = wp.website_pageview_id
	WHERE pageview_url = '/lander-1'
)
ORDER BY website_pageview_id;

SELECT * FROM landing_page_lander1;

SELECT 
	DISTINCT pageview_URL
FROM landing_page_lander1;

-- STEP 3: Flag the pages that the customer visited after lander-1
DROP TABLE IF EXISTS funnel_conversion_flag;

CREATE TEMPORARY TABLE IF NOT EXISTS funnel_conversion_flag
SELECT
	website_session_id,
    MAX(products_page) AS products_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(cart_page) AS cart_made_it,
    MAX(shipping_page) AS shipping_made_it,
    MAX(billing_page) AS billing_made_it,
    MAX(thankyou_page) AS thankyou_made_it
FROM(
	SELECT
		website_session_id,
		CASE WHEN pageview_url = '/lander-1' THEN 1 ELSE 0 END AS lander1_page,
		CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
		CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
		CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
		CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
		CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
		CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
	FROM landing_page_lander1
) AS page_level_view
GROUP BY website_session_id;

SELECT * FROM funnel_conversion_flag;

-- STEP 4: Tally up the flags to view the funnel conversion from lander-1 to thank you page (signaling that they have purchased an item)
DROP TABLE IF EXISTS funnel_conversion;

CREATE TEMPORARY TABLE IF NOT EXISTS funnel_conversion
SELECT
	COUNT(DISTINCT website_session_id) AS sessions,
    SUM(products_made_it) AS to_products,
    SUM(mrfuzzy_made_it) AS to_mrfuzzy,
    SUM(cart_made_it) AS to_cart,
    SUM(shipping_made_it) AS to_shipping,
    SUM(billing_made_it) AS to_billing,
    SUM(thankyou_made_it) AS to_thankyou
FROM funnel_conversion_flag;

SELECT * FROM funnel_conversion;

-- STEP 4.1: Funnel conversion ratio
SELECT
	to_products/sessions AS lander1_click_rt,
    to_mrfuzzy/to_products AS products_click_rt,
    to_cart/to_mrfuzzy AS mrfuzzy_click_rt,
    to_shipping/to_cart AS cart_click_rt,
    to_billing/to_shipping AS shipping_click_rt,
    to_thankyou/to_billing AS billing_click_rt
FROM funnel_conversion











