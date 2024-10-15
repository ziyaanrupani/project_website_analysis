# project_website_analysis

## Project Background

Maven Fuzzy Factory is a recently launched e-commerce startup that has been operational for 8 months and has introduced its first product. The company utilizes a robust database to track orders and website sessions, aiming to monitor customer behavior and assess the effectiveness of online marketing campaigns. This data-driven approach supports the business in analyzing marketing channels, traffic sources, and conversion performance.

Maven Fuzzy Factory is a newly launched e-commerce startup that has been live for 8 months and has launched its first product.

The company has a rich database that tracks orders through it's 

tracks orders, website sessions (utm - to track effectiveness of online market campaigns, tracks traffic sources, helps to view customer behaviour patterns)

to analyze and optimize marketing channels, measure and test website conversion performance

traffic source analysis:
understand where customers are coming from and which channels drive highest quality traffic
identify opportunities to eliminate wasted spend or scale high-converting traffic

landing page performance and testing:
understanding the performance of key landing pages and testing to improve results
identify top opportunities for landing pages. high volume pages with higher than expected bounce rate or low conversion rate
make recommendations on which version of landing pages you should use going forward

analyzing and testing conversion funnels:
underatanding and optimizing each step of user experience on their journey towards purchasing products
identifying most common paths customers take before purchasing products
identify how many users continue to each next step and how many abandon
optimizing critical points where users are abandoning so that you can convert more users and sell more products

## Data Structure Overview

![image](https://github.com/user-attachments/assets/8928cef5-7579-4f22-8583-261bc8b530c6)

## Executive Summary

Maven Fuzzy Factory focuses on data analysis to optimize its marketing strategies and website performance. 
Key areas of focus include:
* Traffic Source Analysis: Identifying which channels drive the highest quality traffic and where opportunities exist to reduce unnecessary spend or scale high-converting sources.

* Landing Page Performance: Analyzing and testing landing pages to identify areas for improvement. Recommendations are made based on pages with high traffic but low conversion rates or high bounce rates.

* Conversion Funnel Optimization: Understanding and optimizing user journeys through the sales funnel by identifying key abandonment points and working to improve the flow of users from one step to the next, aiming to increase conversions and sales.

## Insights Deep Dive

### Bounce Rate

* Preliminary analysis of identifying top website pages highlighted that the bulk of the traffic was directed from the home page. It was the landing page for almost all the viewers.
  
  * Customer behavior showed that the bounce rate for paid marketing campaigns from the home page was quite high at 60%.
    
  *  Only 40% of people who came through paid sources browsed the website and made it past the home page.
    
* A new custom landing page was introduced to test against the default homepage. Both pages were evaluated a month after the latest landing page went live.

![image](https://github.com/user-attachments/assets/bef14435-c3c1-4bbb-bd09-39e696180f49)

* Both the pages were viewed a similar amount of times and the number of bounce sessions for the new page are slightly lower.

![image](https://github.com/user-attachments/assets/9aaea572-f3ae-40e3-b2aa-496fee1f214e)

* There was a drop in the bounce ratio between the homepage and lander-1 from ~60% to 53%
  
  * Significance testing using the z-test gives us a p-value of 0.00051 which is much lower than 0.05 giving us confidence that the drop is statistically significant.

![image](https://github.com/user-attachments/assets/8bd1901e-a6bb-4d19-907e-c5543ee6b17c)


![image](https://github.com/user-attachments/assets/becda468-955c-4292-8928-7559ffbd473f)

* Trend analysis of landing pages shows that as the homepage is being phased out with the new lander-1 page, the overall bounce rate drops gradually over 5 months.

* Additionally over the same period, there is an overall increase in traffic to the website.

### Conversion Rate

* As the homepage phased out and lander-1 is now the default for all paid marketing campaigns, it is essential to understand any further bottlenecks along the process of purchasing a product.

![image](https://github.com/user-attachments/assets/c50d98ec-4f18-4179-8958-7e0ecf4123ed)

* Customers naturally funnel out as not all viewers will complete each step to buy a product. The two bottlenecks identified are the items and billing pages. For both pages, only 43% of viewers follow the natural path to make a purchase.

  * A huge segment is lost at the last step, where a customer inputs their billing information.

![image](https://github.com/user-attachments/assets/8402488b-2559-4d43-9dc9-6e8ffee12973)

* The testing phase of 2 months between a new and old billing page shows a 17% increase in the conversion rate. More viewers are getting past the final stage and placing orders rather than abandoning the step.
         
![image](https://github.com/user-attachments/assets/d83c13da-2625-4e7e-8465-e663c97ddb54)

* Trend analysis over the next 3 months shows that the new billing page consistently brought in more revenue. On average the difference between the two billing pages was ~$800.
    *   A paired t-test shows that the difference between the two is statistically significant as the p-value is 0.00009, much smaller than 0.05


## Recommendations

* It's uncertain if an increase in web traffic is due to the introduction of the new lander-1 page. It's important to evaluate if bids for paid traffic were consistent. It is also worth comparing the ratio of return customers before vs. after lander-1.

* Evaluate the changes between the two billing pages and apply necessary steps to the items page, further up the natural pathway of customers.














