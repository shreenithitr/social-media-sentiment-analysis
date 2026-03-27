-- Select database
USE sentiment_db;

-- View full dataset
SELECT * FROM sentimentdataset_clean;

-- 1. Sentiment Distribution (Basic Insight)
SELECT Sentiment, COUNT(*) AS total_posts
FROM sentimentdataset_clean
GROUP BY Sentiment
ORDER BY total_posts DESC;

-- 2. Country-wise Sentiment Analysis
SELECT Country, Sentiment, COUNT(*) AS total
FROM sentimentdataset_clean
GROUP BY Country, Sentiment
ORDER BY Country;

-- 3. Top Countries by Activity
SELECT Country, COUNT(*) AS total_posts
FROM sentimentdataset_clean
GROUP BY Country
ORDER BY total_posts DESC;

-- 4. Platform-wise Usage
SELECT Platform, COUNT(*) AS total_posts
FROM sentimentdataset_clean
GROUP BY Platform
ORDER BY total_posts DESC;

-- 5. Top Users by Engagement
SELECT User, SUM(Likes + Retweets) AS engagement
FROM sentimentdataset_clean
GROUP BY User
ORDER BY engagement DESC;

-- 6. Average Likes per Sentiment
SELECT Sentiment, AVG(Likes) AS avg_likes
FROM sentimentdataset_clean
GROUP BY Sentiment;

-- 7. Most Used Hashtags
SELECT Hashtags, COUNT(*) AS usage_count
FROM sentimentdataset_clean
GROUP BY Hashtags
ORDER BY usage_count DESC
LIMIT 10;

-- 8. Positive vs Negative Ratio
SELECT 
    SUM(CASE WHEN Sentiment = 'Positive' THEN 1 ELSE 0 END) AS Positive_Count,
    SUM(CASE WHEN Sentiment = 'Negative' THEN 1 ELSE 0 END) AS Negative_Count
FROM sentimentdataset_clean;

-- 9. Rank Users by Likes (Advanced)
SELECT User, SUM(Likes) AS total_likes,
RANK() OVER (ORDER BY SUM(Likes) DESC) AS rank_position
FROM sentimentdataset_clean
GROUP BY User;

-- Platform vs Sentiment Analysis
SELECT Platform, Sentiment, COUNT(*) AS total_posts
FROM sentimentdataset_clean
GROUP BY Platform, Sentiment
ORDER BY Platform;

-- Peak hours for each sentiment
SELECT Hour, Sentiment, COUNT(*) AS total_posts
FROM sentimentdataset_clean
GROUP BY Hour, Sentiment
ORDER BY total_posts DESC;

-- Total engagement by platform
SELECT Platform, SUM(Likes + Retweets) AS total_engagement
FROM sentimentdataset_clean
GROUP BY Platform
ORDER BY total_engagement DESC;

-- Top countries with positive sentiment
SELECT Country, COUNT(*) AS positive_posts
FROM sentimentdataset_clean
WHERE Sentiment = 'Positive'
GROUP BY Country
ORDER BY positive_posts DESC
LIMIT 5;

-- Categorize engagement level
SELECT User,
       SUM(Likes + Retweets) AS total_engagement,
       CASE 
           WHEN SUM(Likes + Retweets) > 500 THEN 'High'
           WHEN SUM(Likes + Retweets) BETWEEN 200 AND 500 THEN 'Medium'
           ELSE 'Low'
       END AS engagement_level
FROM sentimentdataset_clean
GROUP BY User
ORDER BY total_engagement DESC;