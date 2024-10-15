# Website Performance Analysis

## Project Background

Maven Fuzzy Factory is a recently launched e-commerce startup that has been operational for 8 months and has introduced its first product. The company utilizes a robust database to track orders and website sessions, aiming to monitor customer behavior and assess the effectiveness of online marketing campaigns. This data-driven approach supports the business in analyzing marketing channels, traffic sources, and conversion performance.

## Data Structure Overview
Maven's database consists of six tables: products, order refunds, order items, website sessions, website pageviews, and orders; focusing on the last three. Between these tables, there are roughly 1.5 million records where most track website metrics.

![image](https://github.com/user-attachments/assets/8928cef5-7579-4f22-8583-261bc8b530c6)

## Executive Summary

Maven Fuzzy Factory focuses on data analysis to optimize its marketing strategies and website performance. 
Key areas of focus include:
* Traffic Source Analysis: Identifying which channels drive the highest quality traffic and where opportunities exist to reduce unnecessary spending or scale high-converting sources.

* Landing Page Performance: Analyzing and testing landing pages to identify areas for improvement. Recommendations are made based on pages with high traffic but low conversion rates or high bounce rates.

* Conversion Funnel Optimization: Understanding and optimizing user journeys through the sales funnel by identifying key abandonment points and working to improve the flow of users from one step to the next, aiming to increase conversions and sales.

## Insights Deep Dive

### Bounce Rate

* Preliminary analysis of identifying top website pages highlighted that the bulk of the traffic was directed from the home page. It was the landing page for almost all the viewers.
  
  * Customer behavior showed that the bounce rate for paid marketing campaigns from the home page was quite high at 60%.
    
  *  Only 40% of people who came through paid sources browsed the website and made it past the home page.

![image](https://github.com/user-attachments/assets/1b432597-08cf-4776-b976-66c95ee867f8)

* A new custom landing page was introduced to test against the default homepage. Both pages were evaluated a month after the latest landing page went live.

* Both the pages were viewed a similar amount of times and the number of bounce sessions for the new page are slightly lower.

* There was a drop in the bounce ratio between the homepage and lander-1 from ~60% to 53%
  
  * Significance testing using the z-test gives us a p-value of 0.00051 which is much lower than 0.05 giving us confidence that the drop is statistically significant.

![image](https://github.com/user-attachments/assets/0e551f96-c139-4200-8b40-89198fe32a95)

* Trend analysis of landing pages shows that as the homepage is being phased out with the new lander-1 page, the overall bounce rate drops gradually over 5 months.

* Additionally over the same period, there is an overall increase in traffic to the website.

### Conversion Rate

* As the homepage phased out and lander-1 is now the default for all paid marketing campaigns, it is essential to understand any further bottlenecks along the process of purchasing a product.

![image](https://github.com/user-attachments/assets/c50d98ec-4f18-4179-8958-7e0ecf4123ed)

* Customers naturally funnel out as not all viewers will complete each step to buy a product. The two bottlenecks identified are the items and billing pages. For both pages, only 43% of viewers follow the natural path to make a purchase.

  * A huge segment is lost at the last step, where a customer inputs their billing information.

![image](https://github.com/user-attachments/assets/707c228a-0e03-415b-b651-ee58353ab45a)

* The testing phase of 2 months between a new and old billing page shows a 17% increase in the conversion rate. More viewers are getting past the final stage and placing orders rather than abandoning the step.
         
* Trend analysis over the next 3 months shows that the new billing page consistently brought in more revenue. On average the difference between the two billing pages was ~$800.
    *   A paired t-test shows that the difference between the two is statistically significant as the p-value is 0.00009, much smaller than 0.05


## Recommendations

* It's uncertain if an increase in web traffic is due to the introduction of the new lander-1 page.
    * It's important to evaluate if bids for paid traffic were consistent.
    * It is also worth comparing the ratio of return customers before vs. after lander-1.

* Determine if certain paid traffic is more effective at increasing viewers as well as decreasing the conversion rate in them placing an order. 

*  Evaluate the changes between the two billing pages and apply necessary steps to the items page, further up the natural pathway of customers.
    *  Conduct testing on the items page by changing the layout, descriptions, and icon sizes to reduce drop-offs.

 * Analyze the quality of traffic periodically, especially organic vs paid traffic to evaluate customer trends. 














