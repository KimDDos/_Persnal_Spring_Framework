-- 2024 - 01 - 17 --
-- DB 생성
create database myspringdb

 -- User 생성
 create user 'myspringUser'@'localhost' identified by 'mysql' 
 
 -- 권한부여 
 grant all privileges on myspringdb.* to 'myspringUser'@'localhost' with grant option;
 
 -- 권한설정 완료 선언
 flush privileges
 
 -- 2024 - 01 - 17 -- 
 create table board(
 bno bigint not null auto_increment,
 title varchar(200) not null,
 writer varchar(100) not null,
 content text not null,
 reg_at datetime default now(),
 mod_at datetime default now(),
 board_commend int default 0,
 board_notcomend int default 0,
 read_count int default 0,
 file_qty int default 0,
 comment_cnt int default 0, 
 primary key(bno));
 
 