CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	user_email VARCHAR(30) NOT NULL UNIQUE,
	user_name VARCHAR(30) NOT NULL
);

CREATE TABLE tags (
	tag_id SERIAL PRIMARY KEY,
	tag_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE collections (
	collection_id SERIAL PRIMARY KEY,
	collection_name VARCHAR(30) NOT NULL UNIQUE,
	owner_id INT references users(user_id) NOT NULL
);

CREATE TABLE bookmarks (
	bookmark_id SERIAL PRIMARY KEY,
	collection_id INT references collections(collection_id),
	bookmark_title VARCHAR(30) NOT NULL,
	bookmark_url VARCHAR(100) NOT NULL UNIQUE,
	bookmark_owner_id INT references users(user_id),
	bookmark_date DATE NOT NULL
);


CREATE TABLE bookmark_tags (
	bookmark_tag_id SERIAL PRIMARY KEY,
	bookmark_id INT references bookmarks(bookmark_id) NOT NULL,
	tag_id INT references tags(tag_id) NOT NULL
);

CREATE TABLE shares (
	share_id SERIAL PRIMARY KEY,
	collection_id INT references collections(collection_id) NOT NULL,
	shared_with_user_id INT references users(user_id) NOT NULL,
	share_date date NOT NULL
);

--question 1
select * from bookmarks bk 
join collections cl on cl.collection_id = bk.collection_id 
join bookmark_tags bt ON bt.bookmark_id = bk.bookmark_id 
join tags t  on t.tag_id = bt.tag_id
where cl.collection_name = "Development Resources" 


--question 2
select t.tag_name COUNT(t.tag_name) from tags t 
join bookmarks bk on bk.tag_id = t.tag_id
ORDER BY COUNT(DESC)
limit 10

--question 3
SELECT
	c.collection_name,
	u.user_email,
	COUNT(DISTINCT b.bookmark_id)
FROM collections c
INNER JOIN users u
	ON c.owner_id = u.user_id
INNER JOIN bookmarks b
	ON b.collection_id = c.collection_id
INNER JOIN shares s
	ON s.collection_id = c.collection_id
GROUP BY c.collection_name, u.user_email;



