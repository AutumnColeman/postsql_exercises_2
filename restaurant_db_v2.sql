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

-- reviewers
INSERT INTO "reviewer"("id","name","email","karma")
VALUES
(default, 'Peter Pan ', 'peter@neverland.com', 6),
(default, 'Wendy Darling ', 'wendy@london.com', 7),
(default, 'Capitan Hook', 'hook@pirate.com', 0);

-- reviews
INSERT INTO "review"("id","reviewer_id","stars","title","review","restaurant_id")
VALUES
(default, 1, 5, 'FOOD!', 'I like food!', 3),
(default, 2, 4, 'Delicious', 'Try the dumplings.', 3),
(default, 3, 0, 'Disappointment', 'No actual pearls.', 3),
(default, 3, 5, 'Excellent!', 'The tattooed staff reminded me of my ship\'s crew.', 1),
(default, 1, 1, '21+', 'Not allowed in.', 1),
(default, 2, 3, 'Interesting...', 'Smelled good, but looked scary.', 1),
(default, 1, 5, '24 hours', 'I went at 3 am and got pho!',2),
(default, 2, 4, 'Tasty', 'The bahn mi was tasty and cheap.', 2),
(default, 3, 3, 'Not bad', 'The pho was acceptable.', 2);


-- list the reviews for a given restaurant (filter by its name or id)
select * from review where restaurant_id = 1;

-- list the reviews for a given reviewer (filter by his/her name or id)
select * from review where reviewer_id = 1;
select * from review, reviewer where review.author_reviewer_id  = reviewer.id;

-- list each review along with the restaurant they were written for. Select just the restaurant name and the review text

select
	restaurant.name as "Restaurant",
	review.review as "Review"
from
	restaurant, review
where
	restaurant.id = review.restaurant_id; restaurant_id;

-- get the average stars by restaurant. (restaurant name, average star rating)

select
avg(stars) as "Average Stars",
restaurant.name as "Restaurant Name"
where
restaurant.id = restaurant_id;

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

-- average star rating for a food category (category name, average star rating)
select
	restaurant.category as "Category",
	avg(review.stars) as "Average Star Rating"
from
	restaurant, review
where
	restaurant.id = review.restaurant_id
group by
restaurant.category;
