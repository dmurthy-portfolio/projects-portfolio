# 🏠 Airbnb NYC 2019 Data Analysis

This repository provides an in-depth analysis of Airbnb listings in New York City for the year 2019. It includes exploratory data analysis (EDA), geospatial insights, pricing trends, and potential predictive modeling for rental prices.

## 📁 Dataset Overview

**File:** `AB_NYC_2019.csv`  
The dataset includes information about Airbnb listings in NYC such as:

- `id`: Listing ID  
- `name`: Name of the listing  
- `host_id`: Host’s unique ID  
- `host_name`: Host’s name  
- `neighbourhood_group`: NYC borough (e.g. Manhattan, Brooklyn)  
- `neighbourhood`: Neighborhood name  
- `latitude`, `longitude`: Geolocation  
- `room_type`: Type of listing (Entire home/apt, Private room, etc.)  
- `price`: Price per night  
- `minimum_nights`: Minimum stay required  
- `number_of_reviews`: Total number of reviews  
- `last_review`: Date of most recent review  
- `reviews_per_month`: Average monthly reviews  
- `calculated_host_listings_count`: Listings by host  
- `availability_365`: Number of days available per year

## 🔍 Objectives

- Explore and visualize pricing patterns across NYC boroughs  
- Analyze room types and their availability  
- Study review activity and host listing behaviors  
- Identify top neighborhoods for affordable stays  
- Optionally build a price prediction model using regression

## 📊 Key Analytical Questions

- What is the distribution of prices in each borough?
- Which neighborhoods have the highest/lowest availability?
- How does review frequency vary by listing type?
- Are there correlations between price and location?

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/airbnb-nyc-2019-analysis.git
cd airbnb-nyc-2019-analysis
