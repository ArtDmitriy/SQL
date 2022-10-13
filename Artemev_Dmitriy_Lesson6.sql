--6.1 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.--

SELECT
from_user_id, to_user_id,
count(*) as cnt
FROM message
where
to_user_id = '17'
group by from_user_id

SELECT
from_user_id, to_user_id,
count(*) as cnt
FROM message
where
from_user_id in (
SELECT
if (from_user_id = 17, to_user_id,from_user_id) as friend_id
FROM friend_request
where
 (from_user_id = 17 or to_user_id = 17) and `status` = 1)
group by from_user_id

-- 6.2 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.--

SELECT
user_id,
TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age,
(select count(`like`.id) as cnt from `like` where `profile`.user_id = `like`.user_id) as cnt_like
FROM `profile`
order by age limit 10

-- 6.3 Определить кто больше поставил лайков (всего) - мужчины или женщины?--

SELECT
(select gender from `profile` where `like`.user_id = `profile`.user_id) as gender,
count(id) as cnt_like_user
FROM `like`
group by gender


-- 6.4 Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.--
SELECT
user_id,
firstname,
lastname,
((select count(*) from post where post.user_id = `profile`.user_id)+
(select count(*) from `like` where `like`.user_id = `profile`.user_id)+
(select count(*) from message where message.from_user_id = `profile`.user_id)) as index_user
FROM `profile`
