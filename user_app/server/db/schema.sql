drop database if exists qupid;
create database qupid;
use qupid;

create table user (
  user_id int not null auto_increment,
  email varchar(100) not null,
  password varchar(100) not null,
  logged_in boolean not null default false,
  device_id varchar(50) not null,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  dob date not null,
  gender varchar(10) not null,
  total_savings float(2) not null default 0,

  primary key (user_id)
);

create table business (
  business_id int not null auto_increment,
  email varchar(100) not null,
  password varchar(100) not null,
  company_name varchar(50) not null,
  address varchar(50) not null,
  city varchar(50) not null,
  state varchar(20) not null,
  zipcode int not null,

  primary key (business_id)
);

create table coupon (
  coupon_id int not null auto_increment,
  business_id int,
  qrcode varchar(100) not null,
  title varchar(300) not null,
  image varchar(300) not null,
  item_name varchar(100) not null,
  description varchar(300) not null,
  original_price float(2) not null,
  coupon_price float(2) not null,
  coupon_savings float(2) not null,
  start_at datetime not null,
  end_at datetime not null,
  created_at datetime not null default current_timestamp(),

  primary key (coupon_id),

  index business_id (business_id),
  foreign key (business_id)
    references business (business_id)
    on delete cascade
    on update cascade
);

create table user_coupon (
  user_coupon_id int not null auto_increment,
  user_id int,
  coupon_id int,
  user_qrcode varchar(100) not null,
  used boolean not null,
  expired boolean not null,
  activated boolean not null,

  primary key (user_coupon_id),

  index user_id (user_id),
  foreign key (user_id)
    references user (user_id)
    on delete set null
    on update cascade,

  index coupon_id (coupon_id),
  foreign key (coupon_id)
    references coupon (coupon_id)
    on delete set null
    on update cascade
);

create table beacon (
  beacon_uuid varchar(100) not null,
  business_id int,
  section varchar(20) not null,

  primary key (beacon_uuid),

  index business_id (business_id),
  foreign key (business_id)
    references business (business_id)
    on delete cascade
    on update cascade
);

create table coupon_beacon (
  coupon_beacon_id int not null auto_increment,
  coupon_id int,
  beacon_uuid varchar(100),

  primary key (coupon_beacon_id),

  index beacon_uuid (beacon_uuid),
  foreign key (beacon_uuid)
    references beacon (beacon_uuid)
    on delete cascade
    on update cascade,

  index coupon_id (coupon_id),
  foreign key (coupon_id)
    references coupon (coupon_id)
    on delete cascade
    on update cascade
);
