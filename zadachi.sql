-- 1 брой на потребители 
select count(*) from users;
-- 2 най- старият потребител
select username, birthDate from users order by birthDate limit 1;
-- 3 най младият потребител
select username, birthDate from users order by birthDate desc limit 1;
-- 4 Колко юзъра са регистрирани с мейли от abv и колко от gmail и колко с различни от двата
select count(*) from users where email like '%@gmail.com' ;
select count(*) from users where email like '%@abv.bg' ;
select count(*) from users where email  not like '%@gmail.com' or '%@abv.bg' ;
-- 5 Кои юзъри са banned.
select username from users where isBanned = 1; 
-- 6 Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и дата на раждане(отнай-младия към най-възрастния).
select username, birthDate from users order by username, birthDate ;
-- 7 Изкарайте всички потребители от базата, на които потребителскотоиме започва с a.
select username from users where username like 'a%';
-- 8 Изкарайте всички потребители от базата, които съдържат  username името си.
select username from users where username like '%username%';
-- 9 Изкарайте всички потребители от базата,чието име се състои от 2 имена.
select username from users where username like '% %';
-- 10 Регистрирайте 1 юзър през UI-а  и го забранете след това от базата.
update users set isBanned=1 where username= 'bla bla'; 
-- 11 Брой на всички постове.
select count(*) from posts; 
-- 12 Брой на всички постове групирани постатуса на post-a
select count(*) from posts group by postStatus = 'private', 'public'; 
-- 13  Намерете поста/овете с най-къс caption
select distinct caption as lenght from posts WHERE LENGTH(caption)=(SELECT min(LENGTH(caption)) FROM posts) ;
-- 14 Покажете поста с най-дълъг caption.
select distinct caption as caption from posts WHERE LENGTH(caption)=(SELECT max(LENGTH(caption)) FROM posts) limit 1 ;
-- 15 Кой потребител има най-много постове. Използвайте join заявка.
SELECT USERNAME FROM users INNER JOIN posts  ON users.ID = posts.id
GROUP BY users.id HAVING COUNT(users.id) =  (SELECT MAX(COUNT(users.id)) AS CNT FROM posts GROUP BY users.id) ;
-- 16 Кои потребители имат най-малко постове. Използвайте join заявка.
SELECT USERNAME FROM users INNER JOIN posts  ON users.ID = posts.id
GROUP BY users.id HAVING COUNT(users.id) =  (SELECT min(COUNT(users.id)) AS CNT FROM posts GROUP BY users.id) ;
-- 17 Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки.
select users.username, count(posts.id) as numberofpost
from (posts inner join users on users.id= posts.id ) group by username having count(posts.id) < 2 ;
-- 18 Колко потребителя с по малко от 5 поста имаме.
select users.username, count(posts.id) as numberofpost
from (posts inner join users on users.id= posts.id ) group by username having count(posts.id) < 5 ;
-- 19 Кои са постовете с най-много коментари. 
select * from posts where commentsCount >= 9 order by commentsCount desc; 
-- 20 Покажете най-стария пост.
select * from posts order by createdAt limit 1;
-- 21 Покажете най-новия пост.
select * from posts order by createdAt desc limit 1;
-- 22 Покажете всички постове с празен caption.
select * from posts where caption = null; 
-- 23 Създайте потребител през UI-а, добавете му public пост през базата и проверете дали се е създал през UI-а
insert into posts (userId, caption, coverURL, postStatus, createdAt) values (660, 'test proba', 'https://i.imgur.com/gMPUKj7.jpg', 'public', '2021-02-22 02:48:34'); 
-- 24 Покажете всички постове икоментарите им ако имат такива.
select * from posts right join comments on posts.id= comments.postId; 
-- 25 Покажете само постове с коментари и самите коментари.
select * from posts right join comments on posts.id= comments.postId where content > 0; 
-- 26 Покажете името на потребителя с най-много коментари.
SELECT username from users inner join commennts on users.id= comments.userId order by comments count disc limit 1; 
-- 27 Покажете всички коментари, към кой пост принадлежат и кой ги е направил. 
select content, userid from comments inner join posts
on comments.postid= posts.id;
-- 28 Кои потребители са like-нали най-много постове.
select userid from user_liked_post count(*) order desc; 
-- 29 . Кои потребители не са like-вали постове.
select userid from user_liked_post where postId like null; 
-- 30 Кои постове имат like-ове. Покажете id на поста и caption.
select Id, caption from posts inner join user_liked_posts on user_like_post.userid= post.id; 
-- 31 Кои постове имат най-много like-ове. Покажете id на поста и caption
select id, caption from posts inner join user_liked_posts on posts.id=user_liked_posts.posts id order desc;
-- 32. Покажете всички потребители, които не follow-ват никого.
select userId1 from users_followers_users where usersId2= null;
-- 33 Покажете всички потребители, които не са follow-нати от никого.
select userId2 from users_followers_users where usersId1= null;
-- 34 Регистрирайте потребител през UI. Follow-нете някой съществуващ потребител и проверете дали записа го има в базата.
update users_followers_users set userId1= kuki, usersId2=  where userId1=kuki;