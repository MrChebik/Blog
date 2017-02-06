#!/usr/bin/env bash
echo "Create database 'Blog'"
echo -n "Username: "
read username
echo -n "Password: "
read -s password
echo
mysql -u $username -p$password -e "
CREATE DATABASE Blog DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_unicode_ci';
USE Blog;
CREATE TABLE categories
(
    categoryId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    level BIGINT(20) NOT NULL,
    name VARCHAR(255) NOT NULL,
    parentId BIGINT(20) NOT NULL,
    userId BIGINT(20)
);
CREATE INDEX FK41l5cytmhq8vodj4tnwkj8ffi ON categories (userId);
CREATE TABLE category_post
(
    categoryId BIGINT(20) NOT NULL,
    postId BIGINT(20) NOT NULL
);
CREATE INDEX FK4l4lnj564b87wv8e8rjp6x95e ON category_post (postId);
CREATE TABLE comments
(
    commentId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    date DATETIME,
    text VARCHAR(255) NOT NULL,
    postId BIGINT(20),
    userId BIGINT(20)
);
CREATE INDEX FK3otd8f5ei3ewk9366frwusulq ON comments (userId);
CREATE INDEX FKp92k92owme73unywc3u0re0qm ON comments (postId);
CREATE TABLE persistent_logins
(
    series VARCHAR(60) PRIMARY KEY NOT NULL,
    last_used DATETIME NOT NULL,
    token VARCHAR(60) NOT NULL,
    username VARCHAR(60) NOT NULL
);
CREATE TABLE posts
(
    postId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    date DATETIME,
    text LONGTEXT NOT NULL,
    title VARCHAR(25),
    userId BIGINT(20)
);
CREATE INDEX FKasl1cogme0civ4rsbw5pek92e ON posts (userId);
CREATE TABLE posts_comments
(
    Post_postId BIGINT(20) NOT NULL,
    comments_commentId BIGINT(20) NOT NULL
);
CREATE UNIQUE INDEX UK_d4yhs18ap3loeqnj3y7my3bmg ON posts_comments (comments_commentId);
CREATE TABLE readers
(
    id BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    readerId BIGINT(20) NOT NULL,
    userId BIGINT(20)
);
CREATE INDEX FK52fi3ejqtlmhhod892ebpq0r9 ON readers (userId);
CREATE TABLE role
(
    roleId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(16)
);
CREATE UNIQUE INDEX UK_8sewwnpamngi6b1dwaa88askk ON role (name);
CREATE TABLE user_role
(
    userId BIGINT(20) NOT NULL,
    roleId BIGINT(20) NOT NULL
);
CREATE INDEX FKfjlagks6xvf2uas035crflu75 ON user_role (roleId);
CREATE TABLE users
(
    userId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(60),
    password VARCHAR(60),
    username VARCHAR(60)
);
CREATE UNIQUE INDEX UK_6dotkott2kjsp8vw4d0m25fb7 ON users (email);
CREATE UNIQUE INDEX UK_r43af9ap4edm43mmtq01oddj6 ON users (username);
CREATE TABLE users_comments
(
    User_userId BIGINT(20) NOT NULL,
    comments_commentId BIGINT(20) NOT NULL
);
CREATE UNIQUE INDEX UK_k37a2tgpryb7o52hqfa7o2e62 ON users_comments (comments_commentId);
CREATE TABLE users_posts
(
    User_userId BIGINT(20) NOT NULL,
    posts_postId BIGINT(20) NOT NULL
);
CREATE UNIQUE INDEX UK_bmy26i344sx4ebdo0efa3aywk ON users_posts (posts_postId);
CREATE TABLE users_readers
(
    User_userId BIGINT(20) NOT NULL,
    readers_id BIGINT(20) NOT NULL
);
CREATE UNIQUE INDEX UK_cs20r8k8hxgfdn1r766pweojx ON users_readers (readers_id);

ALTER TABLE categories
    ADD CONSTRAINT FK41l5cytmhq8vodj4tnwkj8ffi FOREIGN KEY (userId) REFERENCES users (userId) ON DELETE CASCADE;
ALTER TABLE category_post
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (categoryId, postId),
    ADD CONSTRAINT FK4l4lnj564b87wv8e8rjp6x95e FOREIGN KEY (postId) REFERENCES categories (categoryId) ON DELETE CASCADE,
    ADD CONSTRAINT FKgmq9ws6i95e47w2vnaphigfrd FOREIGN KEY (categoryId) REFERENCES posts (postId);
ALTER TABLE comments
    ADD CONSTRAINT FK3otd8f5ei3ewk9366frwusulq FOREIGN KEY (userId) REFERENCES users (userId),
    ADD CONSTRAINT FKp92k92owme73unywc3u0re0qm FOREIGN KEY (postId) REFERENCES posts (postId);
ALTER TABLE posts
    ADD CONSTRAINT FKasl1cogme0civ4rsbw5pek92e FOREIGN KEY (userId) REFERENCES users (userId) ON DELETE CASCADE;
ALTER TABLE posts_comments
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (Post_postId, comments_commentId),
    ADD CONSTRAINT FKhi8mdm2mlnyspgt298iwsbyys FOREIGN KEY (Post_postId) REFERENCES posts (postId),
    ADD CONSTRAINT FKt5v7cxtan5pvaf5f1cncs2plw FOREIGN KEY (comments_commentId) REFERENCES comments (commentId);
ALTER TABLE readers
    ADD CONSTRAINT FK52fi3ejqtlmhhod892ebpq0r9 FOREIGN KEY (userId) REFERENCES users (userId) ON DELETE CASCADE;
ALTER TABLE user_role
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (userId, roleId),
    ADD CONSTRAINT FK4ch3b3m0g8nsix3bl1334x7uj FOREIGN KEY (userId) REFERENCES users (userId),
    ADD CONSTRAINT FKfjlagks6xvf2uas035crflu75 FOREIGN KEY (roleId) REFERENCES role (roleId);
ALTER TABLE users_comments
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (User_userId, comments_commentId),
    ADD CONSTRAINT FKodt50e5yao2yirqxbaf9udfb3 FOREIGN KEY (User_userId) REFERENCES users (userId),
    ADD CONSTRAINT FKofw2n5pwh2s7cysu579u21q8c FOREIGN KEY (comments_commentId) REFERENCES comments (commentId);
ALTER TABLE users_posts
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (User_userId, posts_postId),
    ADD CONSTRAINT FK7tjblyh45kyejxw2lmod67vxo FOREIGN KEY (User_userId) REFERENCES users (userId),
    ADD CONSTRAINT FKfgg7m8gl1g2qnwqdyn6vvkdwi FOREIGN KEY (posts_postId) REFERENCES posts (postId);
ALTER TABLE users_readers
    ADD CONSTRAINT `PRIMARY` PRIMARY KEY (User_userId, readers_id),
    ADD CONSTRAINT FKhlfx59ej0o5pmj03q3h2tsrle FOREIGN KEY (User_userId) REFERENCES users (userId),
    ADD CONSTRAINT FK2fu1ksbd3jk1u1v6ihaj86uk5 FOREIGN KEY (readers_id) REFERENCES readers (id);

INSERT INTO role (roleId, name)
VALUES
    ('1', 'ROLE_USER'),
    ('2', 'ROLE_ADMIN');
INSERT INTO Blog.users (email, password, username)
VALUES
    ('example@com', '\$2a\$11\$r09HI3B.IlfLC1pFuAsZ7exhDF4er162Ii1G78oj/hxiQ4fvn5aSK', 'admin');
INSERT INTO user_role (userId, roleId)
VALUES
    ('1', '1'),
    ('1', '2');"
echo "Done!"
