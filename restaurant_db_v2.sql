CREATE TABLE restaurant (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  address varchar,
  category varchar
);
CREATE TABLE reviewer (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  email varchar,
  karma integer DEFAULT 0 CHECK (karma between 0 and 7)
);
CREATE TABLE review (
  id serial PRIMARY KEY,
  reviewer_id integer NOT NULL REFERENCES reviewer (id),
  stars integer NOT NULL CHECK (stars between 0 and 5),
  title varchar,
  review varchar,
  restaurant_id integer NOT NULL REFERENCES restaurant (id)
);

-- insert restaurant data into restaurant table
insert into restaurant values
(default, 'Vortex', '438 Moreland Ave NE, Atlanta, GA 30307', 'American');

insert into restaurant values
(default, 'Pho 24', '4646 Buford Hwy NE, Atlanta, GA 30341', 'Vietnamese');

insert into restaurant values
(default, 'Oriental Pearl', 'Atlanta Chinatown Mall, 5399 New Peachtree Rd, Chamblee, GA 30341', 'Chinese');

insert into restaurant values
(default, 'Xela Pan', '5268 Buford Hwy NE, Doraville, GA 30340', 'Guatemalan');

insert into restaurant values
(default, 'Chipotle', '3424 Piedmont Rd NE, Atlanta, GA 30305', 'Tex-Mex');


-- list the reviews for a given restaurant (filter by its name or id)
select * from review where restaurant_id = 1;

-- list the reviews for a given reviewer (filter by his/her name or id)
select * from review where reviewer_id = 1;
select * from review, reviewer where review.author_reviewer_id  = reviewer.id;

-- list each review along with the restaurant they were written for. Select just the restaurant name and the review text

select review, restaurant.name where restaurant_id = restaurant.id;

select review, restaurant.name from review right outer join restaurant on restaurant_id = restaurant.id order by restaurant.name;

select restaurant.name, review from restaurant left outer join review on restaurant.id = restaurant_id;
-- get the average stars by restaurant. (restaurant name, average star rating)
select avg(stars), restaurant.name from review right outer join restaurant on restaurant_id = restaurant.id group by restaurant.name;

select avg(stars), restaurant.name where restaurant.id = restaurant_id;

-- get the number of reviews written for each restaurant. Select the restaurant name and the review count.
select
	restaurant.name as restaurant,
	count(review) as reviews
from
	restaurant, review
where
	restaurant.id = review.restaurant_id
group by
	restaurant.name;

-- list each review along with the restaurant, and the reviewer's name. Select the restaurant name, the review text, and the reviewer name
select
	restaurant.name as restaurant,
	review.review,
	reviewer.name as reviewer
from
	restaurant, review, reviewer
where
	review.restaurant_id = restaurant.id
and
	review.reviewer_id = reviewer.id;

-- get the average stars by reviewer (reviewer name, average star rating)
select
	reviewer.name as reviewer,
	avg(review.stars) as average
from
	reviewer, review
where
	reviewer.id = review.reviewer_id
group by reviewer.name;

-- get the lowest star rating for each reviewer (reviewer name, lowest star rating)
select
	reviewer.name as name,
	min(review.stars) as stars
from
	review, reviewer
where
	review.reviewer_id = reviewer.id
group by
	reviewer.name;

  -- get the number of restaurants in each category (category name, restaurant count)
select
	restaurant.category as "Category",
	count(restaurant.category) as "Number of Restaurants"
from
	restaurant
group by
	category;

-- get number of 5 star reviews by restaurant (restaurant name, 5-star count)
-- get number of 5 star reviews by restaurant (restaurant name, 5-star count)
select
	restaurant.name as "Restaurant",
	count(review.*) as "5 Star Reviews"
from
	restaurant, review
where
	restaurant.id = review.restaurant_id
	and
	review.stars = 5
group by
restaurant.name;
