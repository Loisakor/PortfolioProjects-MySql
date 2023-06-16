Drop database if exists Adams_ext;


#2 Based on the ERD designed, create the MySQL database Adams_ext.
create database if not exists  Adams_ext;  # creating database Adams_ext based on ERD 

use Adams_ext;

create table Employer(
Employer_ID INT AUTO_INCREMENT NOT NULL, #  this data width was choosen to accomodate different data values from different employers
Employee_ID  INT NOT NULL, # this data width was choosen to accomodate different data values from different employers
Employer_Name VARCHAR (150) NOT NULL, # To accommodate a lengthy business name
Employer_Adress VARCHAR( 150) NOT NULL, # To accommodate lengthy address.
Employer_Phone VARCHAR(15), # fixed number of charaters for phone number 
CONSTRAINT PRIMARY KEY (Employer_ID)
);
# Alterimg table to include index for employee_id
ALTER TABLE employer
ADD INDEX employee_id (Employee_ID);


CREATE TABLE Adams_Member(
Member_ID INT AUTO_INCREMENT, # Int was used  as the database is expected to grow as memeber size increase. 
First_Name VARCHAR(50) NOT NULL, # the assumption is First name will be under the 50 characters. 
Last_Name VARCHAR(50) NOT NULL, # the assumption is Last name will be under the 50 characters. 
Address VARCHAR(150) NOT NULL, # To accommodate lengthy address.
Email varchar (50) NOT NULL, # to accommodate lengthy email. 
Phone VARCHAR(15) NOT NULL, # fixed number of charaters for phone number 
Registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # Set to default current time stamp for registration date to automaticlly record.
Salary DOUBLE,  # this is to accomadate varying salaries and rounding depending on payment struture
Membership_status varchar (9) NOT NUll, # to refelect active or not active of memebership
Payment_Start_date Date NOT NULL,
Payment_End_date Date, # Payment_Start_date + years(2),  #TIMESTAMP ( Year, 1, Payment_Start_date)
Employee_ID  INT NOT NULL, # ths data width was choosen to accomodate different data values from different employers
PRIMARY KEY (Member_ID),
FOREIGN KEY (Employee_ID) REFERENCES Employer(Employee_ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);



CREATE TABLE Employment_contract (
  Contract_ID INT AUTO_INCREMENT, # choosen as the database is expected to grow as memeber size increase 
  Employer_ID INT, # ths data width was choosen to accomodate different data values from different employers
  Member_ID INT, # choosen as the database is expected to grow as memeber size increase 
  Employee_ID INT,
  Employer_Name VARCHAR(150),  # to accomodate a lengthy employer name
  Contract_status ENUM('Open', 'Closed'),  # to refelect active-OPEN or not active-CLOSED of Emploment contract
  Salary DOUBLE, # Also in Member this is to accomadate varying salaries and rounding depending on payment struture 
  Employment_start_date DATE NOT NULL, # Required to confirm employment 
  Employment_end_date DATE,   # As a member will only have an enddate if there contract is no longer valid
  CONSTRAINT PRIMARY KEY (Contract_ID), 
  INDEX idx_employer_id (Employer_ID), # creating Index to faciite data retrieval from the database
  INDEX idx_member_id (Member_ID), # creating Index to faciite data retrieval from the database
  INDEX idx_employee_id (Employee_ID), # creating Index to faciite data retrieval from the database
  FOREIGN KEY (Employer_ID) REFERENCES employer (Employer_ID), 
  FOREIGN KEY (Member_ID) REFERENCES Adams_Member (Member_ID),
  FOREIGN KEY (Employee_ID) REFERENCES employer (Employee_ID)
		  ON UPDATE CASCADE
		  ON DELETE CASCADE
);


create table cases_filed(
Case_Number SMALLINT AUTO_INCREMENT, # this is expected to grow at a slower rate  
Member_ID INT NOT NULL,
Case_Description TEXT, 
Filed_date DATE , # to automatically populate the data
Case_Type Text,  # i am thinking should this be long text 
Case_Status VARCHAR(9),  # This has a fixed number of status output  closed, Pending or Inprocess 
constraint primary key (case_Number),
FOREIGN KEY (Member_ID) REFERENCES Adams_Member (Member_ID)
);



# Alter table to add unique case_number as each case_number should be unique with no duplicates 
ALTER TABLE cases_filed
ADD UNIQUE (Case_Number);


Create table Payments(
Payment_ID INT AUTO_INCREMENT, 
Member_ID INT NOT NULL, 
Payment_Amount DOUBLE NOT NULL,
Payment_Date DATE NOT NULL,
Validity_Until Date, # calculation to to payment date plus one year
Constraint primary key (Payment_ID),
FOREIGN KEY (Member_ID) REFERENCES Adams_Member (Member_ID)
);


# Alter table to add unique Payment_ID as each should be unique with no duplicates 
ALTER TABLE Payments
ADD CONSTRAINT U_Payment_ID UNIQUE (Payment_ID);


# Insert test data into all the tables in Adams_ext . 

# Insert values into Employer Table 

insert into Employer (Employer_ID, Employee_ID, Employer_Name, Employer_Adress, Employer_Phone) 
values 
		(1, 1, 'Armstrong-Hermiston', '1 Morning Pass', '185-564-7260'),
		(2, 2, 'Bechtelar-Greenfelder', '8036 Sloan Alley', '290-966-8338'),
		(3, 3, 'Kerluke Group', '49 Sage Crossing', '229-132-4915'),
		(4, 4, 'Bednar, Swift and Raynor', '16315 Magdeline Plaza', '541-306-6929'),
		(5, 5, 'Medhurst Inc', '2499 Hazelcrest Avenue', '837-600-9531'),
		(6, 6, 'West LLC', '4 Petterle Circle', '805-863-4912'),
		(7, 7, 'Grant Inc', '2 Havey Trail', '658-937-3461'),
		(8, 8, 'Berge Inc', '9 Butternut Way', '146-953-4879'),
		(9, 9, 'Emard-Weissnat', '6113 Haas Hill', '781-822-1721'),
		(10, 10, 'Shields and Sons', '8322 Melby Circle', '603-740-0298'),
		(11, 11, 'Sipes-Langworth', '43 Pepper Wood Park', '970-970-4241'),
		(12, 12, 'Renner-Lehner', '16854 Northridge Center', '211-556-4285'),
		(13, 13, 'Stoltenberg-O''Keefe', '41699 Ridgeway Avenue', '951-188-0437'),
		(14, 14, 'Ernser-Corwin', '53 Mallory Avenue', '933-703-4188'),
		(15, 15, 'Denesik-Carter', '138 Fairview Way', '743-710-9154'),
		(16, 16, 'Rippin, Franecki and Williamson', '16419 Larry Circle', '308-834-1058'),
		(17, 17, 'Bartell Inc', '6 Erie Court', '771-927-5691'),
		(18, 18, 'Howell Group', '45 Eagan Avenue', '742-303-4332'),
		(19, 19, 'Grimes, Stoltenberg and Bahringer', '336 Butterfield Pass', '866-186-3606'),
		(20, 20, 'Kemmer Group', '5171 Golf Course Lane', '571-388-7672'),
		(21, 21, 'Mante-Bosco', '1682 Hagan Park', '495-762-7216'),
		(22, 22, 'Volkman Inc', '152 Division Park', '120-753-1148'),
		(23, 23, 'Dicki LLC', '2368 Mcbride Junction', '968-757-2430'),
		(24, 24, 'Ward Group', '554 Granby Street', '870-714-0102'),
		(25, 25, 'Kuphal, Bailey and Paucek', '4 Melrose Circle', '540-685-3014'),
		(26, 26, 'Kertzmann, Baumbach and Bode', '46723 Almo Pass', '102-675-4876'),
		(27, 27, 'Auer-Swaniawski', '1439 Packers Avenue', '407-838-6535'),
		(28, 28, 'Klein, Kuphal and Ullrich', '750 Sugar Road', '149-652-1668'),
		(29, 29, 'Marvin-Feeney', '34127 Burning Wood Point', '111-862-6681'),
		(30, 30, 'Bechtelar, Vandervort and Rosenbaum', '88559 Forest Parkway', '622-439-1030'),
		(31, 31, 'Block, McKenzie and Buckridge', '9 Fair Oaks Road', '468-601-2571'),
		(32, 32, 'Beier Inc', '6 Northwestern Pass', '151-436-4071'),
		(33, 33, 'Keebler and Sons', '126 Algoma Way', '857-567-9471'),
		(34, 34, 'Vandervort, Beatty and Macejkovic', '67 Eagan Terrace', '430-719-1051'),
		(35, 35, 'Bayer and Sons', '9 Little Fleur Circle', '541-331-3748'),
		(36, 36, 'Flatley, Kovacek and Corkery', '94621 Anthes Court', '712-583-4581'),
		(37, 37, 'Daugherty, Wolf and Barrows', '1 Westport Crossing', '611-958-8234'),
		(38, 38, 'Skiles, Hammes and Kiehn', '12 Ridgeway Alley', '507-270-7013'),
		(39, 39, 'Paucek-White', '3264 Judy Way', '434-173-4881'),
		(40, 40, 'Farrell Inc', '7825 Golf Course Trail', '710-627-5942');


# insert values into adams_Member
insert into adams_Member (Member_ID, first_name, last_name, address, email, Phone, Registration_Date, Salary, Membership_status, Payment_Start_date, Payment_End_date, Employee_ID) 
values 
	(1, 'Teodoor', 'Naper', '020 Gateway Lane', 'tnaper0@cbslocal.com', '562-445-8237', '2022-09-12', 189275.97, '', '2023-02-20', '2023-02-09', 1),
	(2, 'Joete', 'Lounds', '54381 Hallows Parkway', 'jlounds1@imdb.com', '444-262-9027', '2022-06-24', 278122.23, '', '2022-12-02', '2022-10-11', 2) ,
	(3, 'Doralyn', 'Rapper', '511 Dapin Pass', 'drapper2@bloomberg.com', '566-491-8707', '2023-02-25', 184451.45, '', '2022-11-04', '2023-04-16', 3) ,
	(4, 'Devina', 'Nussen', '211 Marcy Trail', 'dnussen3@nasa.gov', '641-301-3236', '2023-05-12', 246541.56, '', '2023-02-03', '2023-02-03', 4) ,
	(5, 'Aldis', 'Penson', '31 Colorado Lane', 'apenson4@geocities.com', '646-467-7454', '2022-06-05', 449324.68, '', '2023-05-15', '2022-06-05', 5) ,
	(6, 'Gwenny', 'Copas', '7 Westport Street', 'gcopas5@marketwatch.com', '793-389-0236', '2023-03-27', 82847.61, '', '2022-06-13', '2023-02-28', 6) ,
	(7, 'Fremont', 'Silliman', '6833 Dottie Pass', 'fsilliman6@twitpic.com', '602-205-0876', '2023-01-11', 80030.06, '', '2023-01-28', '2022-06-23', 7) ,
	(8, 'Archaimbaud', 'Boles', '283 Debs Alley', 'aboles7@zdnet.com', '833-173-3512', '2022-08-09', 252295.42, '', '2022-06-05', '2023-04-06', 8) ,
	(9, 'Malissia', 'Lilburne', '77 Cordelia Parkway', 'mlilburne8@fotki.com', '536-774-3040', '2022-09-18', 105468.07, '', '2022-09-27', '2022-10-30', 9) ,
	(10, 'Barclay', 'O''Brollachain', '5765 Kipling Lane', 'bobrollachain9@telegraph.co.uk', '931-804-7525', '2022-05-31', 272234.5, '', '2022-12-28', '2023-01-14', 10) ,
	(11, 'Constantino', 'Tother', '375 Graedel Center', 'ctothera@nifty.com', '788-231-3417', '2022-06-30', 142401.23, '', '2022-10-28', '2022-07-04', 11) ,
	(12, 'Glen', 'Chappelle', '18735 Dixon Terrace', 'gchappelleb@bloomberg.com', '891-573-6446', '2022-07-24', 55230.46, '', '2022-08-30', '2022-11-06', 12) ,
	(13, 'Eleni', 'Tincknell', '96850 Green Avenue', 'etincknellc@istockphoto.com', '913-924-1023', '2023-01-28', 26234.2, '', '2023-05-11', '2022-09-11', 13) ,
	(14, 'Breena', 'Joselevitz', '8 Trailsway Plaza', 'bjoselevitzd@sfgate.com', '310-661-6834', '2023-03-26', 258176.51, '', '2022-11-02', '2022-09-16', 14) ,
	(15, 'Rosy', 'Schoales', '59 Golf Road', 'rschoalese@cisco.com', '111-640-5394', '2022-08-11', 447067.39, '', '2023-05-06', '2022-07-24', 15) ,
	(16, 'Northrop', 'Lanston', '217 David Pass', 'nlanstonf@imdb.com', '678-884-1936', '2022-07-24', 171599.36, '', '2023-01-08', '2022-10-16', 16) ,
	(17, 'Alfons', 'Primrose', '62884 Moose Street', 'aprimroseg@opera.com', '679-242-2609', '2022-07-28', 283629.82, '', '2023-02-01', '2022-11-29', 17) ,
	(18, 'Piper', 'Entwhistle', '75 Westridge Junction', 'pentwhistleh@techcrunch.com', '308-271-9453', '2022-09-03', 183437.71, '', '2022-08-29', '2023-05-04', 18) ,
	(19, 'Marena', 'Hedon', '8081 Ruskin Center', 'mhedoni@goodreads.com', '119-610-6913', '2023-01-04', 140172.56, '', '2023-03-19', '2022-11-26', 19) ,
	(20, 'Kalinda', 'Kensington', '1441 Redwing Plaza', 'kkensingtonj@hatena.ne.jp', '427-443-7198', '2023-03-08', 265970.39, '', '2022-12-07', '2022-11-12', 20) ,
	(21, 'Harold', 'Purple', '9491 Russell Avenue', 'hpurplek@walmart.com', '412-592-6574', '2023-02-22', 293499.58, '', '2022-06-24', '2023-03-23', 21) ,
	(22, 'Jodie', 'Gummie', '6015 Kipling Plaza', 'jgummiel@tripod.com', '681-597-3347', '2023-05-16', 34300.74, '', '2022-12-22', '2022-10-09', 22) ,
	(23, 'Julie', 'Vickar', '27943 Mayer Court', 'jvickarm@sciencedaily.com', '142-662-3056', '2023-03-07', 358896.29, '', '2023-04-01', '2023-03-19', 23) ,
	(24, 'Ike', 'Voss', '371 Lunder Trail', 'ivossn@opensource.org', '786-248-3272', '2023-04-17', 169223.25, '', '2023-04-17', '2022-07-10', 24) ,
	(25, 'Isidora', 'Gjerde', '332 Starling Alley', 'igjerdeo@gravatar.com', '135-714-8348', '2023-03-01', 107362.75, '', '2022-09-01', '2022-10-21', 25) ,
	(26, 'Karin', 'Linfield', '37 Hallows Circle', 'klinfieldp@berkeley.edu', '793-552-1630', '2022-12-12', 411186.7, '', '2022-07-20', '2022-08-07', 26) ,
	(27, 'Malinda', 'Brann', '6909 Hallows Avenue', 'mbrannq@cnbc.com', '359-353-0080', '2022-11-21', 361131.66, '', '2023-01-28', '2022-06-12', 27) ,
	(28, 'Katinka', 'Mil', '8 Reindahl Park', 'kmilr@sina.com.cn', '488-367-1474', '2022-10-01', 288781.44, '', '2022-06-15', '2022-10-26', 28) ,
	(29, 'Geneva', 'Balston', '0455 Randy Street', 'gbalstons@reuters.com', '521-536-6028', '2022-11-08', 146840.03, '', '2023-01-03', '2023-04-23', 29) ,
	(30, 'Barri', 'Ambroz', '33 Old Shore Terrace', 'bambrozt@ibm.com', '626-276-9512', '2022-08-08', 126560.55, '', '2022-07-19', '2022-11-04', 30) ,
	(31, 'Dolph', 'Wiskar', '62450 Myrtle Circle', 'dwiskaru@alibaba.com', '218-606-2962', '2022-06-27', 212431.61, '', '2023-03-28', '2023-03-03', 31) ,
	(32, 'Philippa', 'Lergan', '6286 Transport Crossing', 'plerganv@princeton.edu', '410-724-2183', '2022-09-19', 74810.9, '', '2022-08-04', '2022-08-30', 32) ,
	(33, 'Nick', 'Coop', '7737 Messerschmidt Parkway', 'ncoopw@theguardian.com', '672-719-2289', '2022-12-25', 123381.69, '', '2022-09-13', '2023-04-19', 33) ,
	(34, 'Frank', 'Allabush', '61 Stephen Park', 'fallabushx@trellian.com', '877-732-4099', '2022-07-13', 241233.86, '', '2023-04-15', '2022-12-06', 34) ,
	(35, 'Wyndham', 'Howle', '78244 Bashford Circle', 'whowley@bbb.org', '158-379-4635', '2022-07-22', 374763.91, '', '2022-07-04', '2022-07-23', 35) ,
	(36, 'Marla', 'Kenzie', '6871 Washington Way', 'mkenziez@devhub.com', '745-692-2823', '2023-02-07', 70440.77, '', '2023-03-05', '2022-06-16', 36) ,
	(37, 'Nadeen', 'Maudett', '48240 Debra Road', 'nmaudett10@php.net', '701-266-3663', '2023-05-09', 176276.23, '', '2022-07-01', '2023-01-30', 37) ,
	(38, 'Cornie', 'Hackin', '74 Westerfield Terrace', 'chackin11@latimes.com', '406-866-6986', '2022-09-09', 115375.13, '', '2023-03-12', '2022-06-22', 38) ,
	(39, 'Klemens', 'Bladen', '56 Arizona Point', 'kbladen12@plala.or.jp', '242-505-7309', '2022-10-21', 357258.19, '', '2022-06-30', '2023-03-30', 39) ,
	(40, 'Alwyn', 'Bisset', '89 Spaight Park', 'abisset13@4shared.com', '415-217-9192', '2023-01-29', 399981.24, '', '2022-12-20', '2022-12-20', 40);



#Insert Values into  Employment_contract 
/* assumption:
Contracts with null values for employment_end_date means emlpoyment is open therefore active 
 */
insert into Employment_contract (Contract_ID, Employer_ID, Member_ID, Employee_ID, Employer_Name, Contract_status, Salary, Employment_start_date, Employment_end_date) 
values
	(1, 1, 1, 1, 'Mayer Group', 'open', 455220.66, '2019-08-14', null),
   (2, 2, 2, 2, 'White, Hammes and Torp', 'open', 41019.86, '2021-11-14', null),
   (3, 3, 3, 3, 'Hilll, Hartmann and Dooley', 'open', 123292.97, '2022-04-01', null),
   (4, 4, 4, 4, 'Nicolas, Bergstrom and Farrell', 'closed', 290923.55, '2019-12-18', '2022-7-3'),
   (5, 5, 5, 5, 'Dach-Bergnaum', 'open', 136978.0, '2022-03-07', null),
   (6, 6, 6, 6, 'Hoeger-Cummings', 'closed', 108625.87, '2022-03-06', '2022-7-15'),
   (7, 7, 7, 7, 'Hane-Prosacco', 'open', 458420.64, '2022-01-01', null),
   (8, 8, 8, 8, 'Cole-Herzog', 'closed', 38196.23, '2020-05-22', '2022-8-21'),
   (9, 9, 9, 9, 'Shields LLC', 'open', 399835.1, '2021-06-15', null),
   (10, 10, 10, 10, 'Weber Group', 'closed', 187113.4, '2021-01-03', '2022-6-8'),
   (11, 11, 11, 11, 'Kerluke-Kuhic', 'open', 324123.91, '2019-07-04', null),
   (12, 12, 12, 12, 'Johnson, Armstrong and DuBuque', 'open', 297330.64, '2020-08-20', null),
   (13, 13, 13, 13, 'Crist-McGlynn', 'closed', 48304.49, '2019-11-12', '2023-1-12'),
   (14, 14, 14, 14, 'Johns, Funk and Johns', 'open', 320755.12, '2019-06-22', null),
   (15, 15, 15, 15, 'Glover-Koelpin', 'closed', 180267.68, '2021-08-15', '2022-8-29'),
   (16, 16, 16, 16, 'D''Amore-Prohaska', 'open', 331614.07, '2022-03-04', null),
   (17, 17, 17, 17, 'Luettgen-Windler', 'closed', 194976.39, '2021-12-26', '2022-8-25'),
   (18, 18, 18, 18, 'Price-Schamberger', 'closed', 89516.7, '2021-07-26', '2022-7-19'),
   (19, 19, 19, 19, 'Reichel, Dickens and O''Conner', 'open', 160753.54, '2020-11-18', null),
   (20, 20, 20, 20, 'Rempel, Sanford and Reichel', 'closed', 285377.96, '2020-12-31', '2022-11-27'),
   (21, 21, 21, 21, 'Jenkins, Schowalter and Steuber', 'open', 262349.62, '2019-12-07', null),
   (22, 22, 22, 22, 'Champlin, Will and Cartwright', 'closed', 354397.49, '2020-06-21', '2023-4-20'),
   (23, 23, 23, 23, 'Goodwin-Stoltenberg', 'closed', 343502.37, '2021-11-10', '2022-10-31'),
   (24, 24, 24, 24, 'Kris, Corwin and Hermiston', 'open', 108212.58, '2021-01-10', null),
   (25, 25, 25, 25, 'Runte, Spencer and Vandervort', 'closed', 115642.65, '2020-01-16', '2023-1-29'),
   (26, 26, 26, 26, 'Upton, Jerde and Jerde', 'open', 343498.55, '2021-08-15', null),
   (27, 27, 27, 27, 'Hagenes and Sons', 'closed', 330370.46, '2019-08-21', '2022-12-3'),
   (28, 28, 28, 28, 'Wilderman-Lockman', 'open', 340064.32, '2021-07-09', null),
   (29, 29, 29, 29, 'Kassulke, Treutel and Dicki', 'open', 189248.53, '2019-09-01', null),
   (30, 30, 30, 30, 'Kemmer-Barrows', 'closed', 50199.52, '2021-11-11', '2022-9-13'),
   (31, 31, 31, 31, 'Conn-Bahringer', 'open', 94765.65, '2022-05-07',null),
   (32, 32, 32, 32, 'Jacobs, Trantow and Jacobson', 'closed', 203634.94, '2019-12-28', '2022-12-28'),
   (33, 33, 33, 33, 'Emard and Sons', 'closed', 156870.03, '2020-06-30', '2022-6-7'),
   (34, 34, 34, 34, 'Metz Inc', 'closed', 275479.31, '2020-01-25', '2023-2-6'),
   (35, 35, 35, 35, 'Botsford-Farrell', 'open', 175090.87, '2020-12-12', null),
   (36, 36, 36, 36, 'Treutel-Marks', 'closed', 36952.15, '2020-03-01', '2022-11-28'),
   (37, 37, 37, 37, 'Crona-Rowe', 'open', 215849.47, '2019-01-31', null),
   (38, 38, 38, 38, 'Blick LLC', 'open', 316131.61, '2020-12-09', null),
   (39, 39, 39, 39, 'Larson and Sons', 'open', 180074.33, '2020-04-24', null),
   (40, 40, 40, 40, 'Strosin-Thompson', 'open', 68088.85, '2022-03-10', null);
   


#Insert values into cases_filed
/* Closed cases are resolved
	Inprocess Cases has been picked up and being processed 
    Pending Cases has been created but no actions taken
    */
insert into cases_filed (Case_Number, Member_ID, Case_Description, Filed_date, Case_Type, Case_Status) 
values 
	(1, 1, 'dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', '2022-12-15', 'erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', 'Closed'),
	(2, 2, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', '2022-11-29', 'id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit', 'Closed'),
	(3, 3, 'molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis', '2023-02-26', 'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at', 'Inprocess'),
	(4, 4, 'curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec', '2023-05-10', 'pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit', 'Pending'),
	(5, 5, 'suspendisse potenti in eleifend quam a odio in hac habitasse', '2022-07-29', 'proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', 'Closed'),
	(6, 6, 'a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue', '2022-09-07', 'vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque', 'Closed'),
	(7, 7, 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut', '2022-06-14', 'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta', 'Pending'),
	(8, 8, 'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien', '2022-06-03', 'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt', 'Closed'),
	(9, 9, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur', '2022-08-09', 'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer', 'Inprocess'),
	(10, 10, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient', '2022-12-01', 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in', 'Inprocess'),
	(11, 11, 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus', '2022-09-08', 'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa', 'Inprocess'),
	(12, 12, 'at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero', '2023-01-03', 'commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula', 'Pending'),
	(13, 13, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non', '2022-07-21', 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate', 'Pending'),
	(14, 14, 'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget', '2022-10-30', 'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', 'Closed'),
	(15, 15, 'sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis', '2022-10-26', 'iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut', 'Inprocess'),
	(16, 16, 'id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras', '2022-07-24', 'sapien cursus vestibulum proin eu mi nulla ac enim in tempor', 'Closed'),
	(17, 17, 'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque', '2022-05-19', 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', 'Closed'),
	(18, 18, 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea', '2022-10-19', 'at ipsum ac tellus semper interdum mauris ullamcorper purus sit', 'Inprocess'),
	(19, 19, 'non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra', '2022-07-16', 'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat', 'Closed'),
	(20, 20, 'sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse', '2023-02-01', 'amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam', 'Pending');


#Insert Value into Payments
/*  Assumption;
Annual payment amount for members vary due to various pricing.
*/
insert into Payments (Payment_ID, Member_ID, Payment_Amount, Payment_Date, Validity_Until) 
values 
	(1, 1, 236, '2022-10-20', '2022-09-01'),
	(2, 2, 248, '2023-01-27', '2023-02-18'),
	(3, 3, 240, '2022-09-13', '2022-05-19'),
	(4, 4, 189, '2022-09-01', '2022-10-03'),
	(5, 5, 160, '2022-08-23', '2023-02-11'),
	(6, 6, 159, '2023-03-14', '2022-07-11'),
	(7, 7, 158, '2022-07-10', '2022-10-08'),
	(8, 8, 161, '2023-02-21', '2023-04-25'),
	(9, 9, 164, '2023-04-17', '2023-05-01'),
	(10, 10, 120, '2022-11-13', '2023-01-29'),
	(11, 11, 186, '2023-02-09', '2023-04-23'),
	(12, 12, 199, '2023-01-10', '2022-10-26'),
	(13, 13, 104, '2023-03-31', '2023-03-14'),
	(14, 14, 153, '2022-12-29', '2023-02-04'),
	(15, 15, 212, '2022-10-16', '2023-01-17'),
	(16, 16, 226, '2022-10-01', '2022-09-25'),
	(17, 17, 206, '2022-08-31', '2022-09-06'),
	(18, 18, 207, '2022-11-22', '2023-04-02'),
	(19, 19, 181, '2023-03-26', '2023-04-06'),
	(20, 20, 219, '2023-03-17', '2022-07-30'),
	(21, 21, 216, '2023-04-23', '2023-03-13'),
	(22, 22, 126, '2022-11-25', '2023-02-13'),
	(23, 23, 188, '2023-01-10', '2023-03-14'),
	(24, 24, 215, '2022-09-19', '2022-05-22'),
	(25, 25, 174, '2022-10-07', '2023-03-30'),
	(26, 26, 129, '2022-08-26', '2022-10-24'),
	(27, 27, 227, '2022-07-08', '2022-05-22'),
	(28, 28, 197, '2022-10-24', '2023-01-04'),
	(29, 29, 129, '2022-08-12', '2022-12-25'),
	(30, 30, 167, '2022-07-15', '2022-10-27'),
	(31, 31, 183, '2022-06-16', '2023-01-10'),
	(32, 32, 159, '2023-03-04', '2023-04-20'),
	(33, 33, 229, '2023-04-27', '2022-10-08'),
	(34, 34, 176, '2022-09-03', '2022-10-02'),
	(35, 35, 158, '2022-12-19', '2023-01-26'),
	(36, 36, 190, '2022-10-26', '2022-07-21'),
	(37, 37, 207, '2022-07-20', '2022-10-27'),
	(38, 38, 108, '2022-05-27', '2022-06-20'),
	(39, 39, 185, '2023-05-14', '2023-03-24'),
	(40, 40, 117, '2022-06-01', '2023-02-17');



# After inserting data, i noticed that i needed to make some alterations. 
# Performed modifications to the database without dropping any table:

# updating column to refelect payment validity as fees are annual 
UPDATE Payments
SET Validity_Until = DATE_ADD(Payment_Date, INTERVAL 1 YEAR) ;

#  Deleting an existing NOT NULL.
ALTER TABLE employer MODIFY COLUMN Employer_Adress VARCHAR(150) NULL;

# Modifying the name of a column
ALTER TABLE Employment_contract
RENAME COLUMN Contract_ID  TO Contract_number;


# Added a column 
ALTER TABLE payments 
ADD Membership_status VARCHAR(10) AFTER Payment_Amount;

# Update the column with Data 	
	# To check for membership status 
UPDATE payments
SET Membership_status = 'Active'
WHERE Validity_Until >= CURDATE();

UPDATE payments
SET Membership_status = 'Inactive'
WHERE Validity_Until < CURDATE();

# ALTER table to add unique constraints to avoid duplicate IDS 
ALTER TABLE adams_member
ADD CONSTRAINT Uq_Employee_ID UNIQUE (Employee_ID),
ADD CONSTRAINT Uq_Member_ID UNIQUE (Member_ID);

# updating Table column values based on values from other table to aid readability 
UPDATE adams_member 
INNER JOIN payments USING (Member_ID)
SET adams_member.Payment_Start_date = payments.Payment_Date; # updating to better refelect payment cycle 

UPDATE adams_member
INNER JOIN payments USING (Member_ID)
SET adams_member.Payment_Start_date = payments.Validity_Until; # updating to better refelect payment cycle 

UPDATE adams_member
INNER JOIN payments USING (Member_ID)
SET adams_member.Membership_status = payments.Membership_status; # updating to have member status accessable at a glance. 


# Creating accessible user views. 

# To view all memebers information
CREATE VIEW Adams_members AS 
	SELECT * FROM adams_member;


# To view members membership status 
CREATE VIEW Adams_members_status AS 
	SELECT AM.Member_ID, AM.First_Name, AM.Last_Name, AM.Membership_status, P.Validity_Until
	FROM adams_member AM
    join payments p
		ON AM.Member_ID = P.Member_ID;
        
# To view Members employer
CREATE VIEW Adams_members_employer AS 
	SELECT AM.Member_ID, AM.First_Name, AM.Last_Name, E.Employer_ID, E.Employer_Name, E.Employer_Phone
	FROM adams_member AM
    join employer E
		ON AM.Employee_ID = E.Employee_ID;
        
        



