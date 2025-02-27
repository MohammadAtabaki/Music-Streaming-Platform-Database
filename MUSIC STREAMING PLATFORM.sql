# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL 5                                         #
# Project name:          Northwind                                       #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS Music_Streaming_Platform;

CREATE DATABASE IF NOT EXISTS Music_Streaming_Platform;

USE Music_Streaming_Platform;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #




create table Advertisement (
     AdvID INTEGER NOT NULL AUTO_INCREMENT,
     CompanyName VARCHAR(15) NOT NULL,
     constraint PK_Advertisement primary key (AdvID)
);


create table AdvWatching (
     Datetime DATETIME not null,
     Username varchar(45) ,
     AdvID  INTEGER ,
     constraint PK_AdvWatching primary key (Datetime)
);

     
create table Album_Single (
     AlbumID INTEGER NOT NULL AUTO_INCREMENT,
     Title varchar(45) not null,
     ReleaseDate DATETIME not null,
     ArtistID INTEGER,
     constraint PK_Album_Single primary key (AlbumID)
);


create table Artist (
     ArtistID INTEGER NOT NULL AUTO_INCREMENT,
     Name varchar(45) not null,
     InstagramLink varchar(250),
     constraint PK_Artist primary key (ArtistID)
);

create table Band (
     ArtistID INTEGER NOT NULL ,
     StartDate DATE not null,
     EndDate DATE ,
     constraint PK_Band primary key (ArtistID)
);


create table Composition (
     SingerID INTEGER NOT NULL,
     BandID INTEGER NOT NULL,
     JoinDate DATE not null,
     EndDate DATE,
     constraint PK_Composition primary key (SingerID,BandID)
);


create table Contain (
     PlaylistID INTEGER not null,
     TrackID INTEGER not null,
     constraint PK_Contain primary key (PlaylistID, TrackID)
);


create table Build (
     PlaylistID INTEGER not null,
     Username varchar(70) not null,
     constraint PK_Create primary key (PlaylistID, Username)
);


create table Follow (
     PlaylistID INTEGER not null,
     Username varchar(70) not null,
     constraint PK_Follow primary key (PlaylistID, Username)
);


create table Genre (
     GenreName varchar(45) not null UNIQUE,
     Description MEDIUMTEXT not null,
     constraint PK_Genre primary key (GenreName)
);


create table Has_a (
     GenreName varchar(45) not null,
     TrackID INTEGER not null,
     constraint PK_Has_a primary key (GenreName, TrackID)
);


create table Listen_Download_Interaction (
     Username varchar(70) not null,
     Datetime DATETIME ,
     DownloadAccess varchar(3),
     TrackID INTEGER NOT NULL,
     constraint PK_Listen_Download_Interaction primary key (Username, Datetime)
);


create table Payment (
     PaymentID INTEGER NOT NULL AUTO_INCREMENT,
     Username varchar(50),
     Amount float not null,
     Datetime DATETIME not null,
     PaymentMethod varchar(50) not null,
     constraint PK_Payment primary key (PaymentID)
);


create table Playlist (
     PlaylistID INTEGER NOT NULL AUTO_INCREMENT,
     Title varchar(50) not null,
     Duration TIME not null,
     CreationDate DATE not null,
     constraint PK_Playlist primary key (PlaylistID)
);


create table Singer (
     ArtistID INTEGER NOT NULL,
     FirstName varchar(50) not null,
     LastName varchar(50) not null,
     BirthDate DATE not null,
     Nationality varchar(50) not null,
     constraint PK_Singer primary key (ArtistID)
);


create table SongTrack (
     TrackID INTEGER NOT NULL AUTO_INCREMENT,
     Title varchar(50) not null,
     Duration TIME not null,
     ArtistID INTEGER not null,
     AlbumID INTEGER ,
     constraint PK_SongTrack primary key (TrackID)
);


create table Style (
     ArtistID INTEGER not null,
     GenreName varchar(45) not null,
     constraint PK_Style primary key (GenreName, ArtistID)
);


create table User (
     Username varchar(70) not null UNIQUE ,
     Email varchar(100) not null UNIQUE ,
     Password varchar(50) not null,
     BirthDate DATE  not null,
     Nationality varchar(50) not null,
     Location varchar(100) ,
     FirstName char(50) not null,
     LastName char(50) not null,
     StartDatePremium date,
     EndDatePremium date,
     Type varchar(10) not null,
     constraint PK_User primary key (Username)
);


# ---------------------------------------------------------------------- #
# Foreign key constraints                                                #
# ---------------------------------------------------------------------- #


alter table AdvWatching add constraint FK_AdvWatching_User
     foreign key (Username) references User (Username);

alter table AdvWatching add constraint FK_AdvWatching_Advertisement
     foreign key (AdvID) references Advertisement(AdvID);


alter table Album_Single add constraint FK_Album_Artis
     foreign key (ArtistID) references Artist(ArtistID);

alter table Band add constraint FK_Band_Artis
     foreign key (ArtistID)  references Artist(ArtistID);

alter table Composition add constraint FK_Composition_Singer
     foreign key (SingerID)  references Singer(ArtistID);

alter table Composition add constraint FK_Composition_Band
     foreign key (BandID) references Band(ArtistID);

alter table Contain add constraint FK_Contain_SongTrack
     foreign key (TrackID)  references SongTrack(TrackID);

alter table Contain add constraint FK_Contain_Playlist
     foreign key (PlaylistID) references Playlist(PlaylistID);

alter table Build add constraint FK_Creat_User
     foreign key (Username) references User(Username);

alter table Build add constraint FK_Creat_Playlist
     foreign key (PlaylistID) references Playlist(PlaylistID);

alter table Follow add constraint FK_Follow_User
     foreign key (Username) references User(Username);

alter table Follow add constraint REF_Follow_Playlist
     foreign key (PlaylistID) references Playlist(PlaylistID);

alter table Has_a add constraint FK_Has_a_SongTrack
     foreign key (TrackID) references SongTrack(TrackID);

alter table Has_a add constraint FK_Has_a_Genre
     foreign key (GenreName) references Genre(GenreName);

alter table Listen_Download_Interaction add constraint FK_Listen_Download_Interaction_SongTrack_FK
     foreign key (TrackID) references SongTrack(TrackID);

alter table Listen_Download_Interaction add constraint FK_Listen_Download_Interaction_User
     foreign key (Username) references User(Username);

alter table Payment add constraint FK_Payment_User
     foreign key (Username) references User(Username);

alter table Singer add constraint FK_Singer_Artist
     foreign key (ArtistID) references Artist(ArtistID);

alter table SongTrack add constraint FK_SongTrack_Artist
     foreign key (ArtistID) references Artist(ArtistID);

alter table SongTrack add constraint FK_SongTrack_Album_Single
     foreign key (AlbumID) references Album_Single(AlbumID);

alter table Style add constraint FK_Style_Genre
     foreign key (GenreName) references Genre(GenreName);

alter table Style add constraint FK_Style_Artist
     foreign key (ArtistID) references Artist(ArtistID);

# ---------------------------------------------------------------------- #
# Index Section                                                          #
# ---------------------------------------------------------------------- #

create index AdvID
     on Advertisement (AdvID);

create index Datetime
     on AdvWatching (Datetime);

create index Username
     on AdvWatching (Username);

create index AdvID
     on AdvWatching (AdvID);

create index AlbumID
     on Album_Single (AlbumID);

create index ArtistID
     on Album_Single (ArtistID);

create index ArtistID
     on Artist (ArtistID);

create index ArtistID
     on Band (ArtistID);

create index BandID
     on Composition (BandID);

create index SingerID
     on Composition (SingerID);

create index PlaylistID
     on Contain (PlaylistID);

create index TrackID
     on Contain (TrackID);

create index PlaylistID
     on Build (PlaylistID);

create index Username
     on Build (Username);

create index PlaylistID
     on Follow (PlaylistID);

create index Username
     on Follow (Username);

create index TrackID
     on Has_a (TrackID);
     
create index GenreName
     on Has_a (GenreName);     

create index Username
     on Listen_Download_Interaction (Username);

create index Datetime
     on Listen_Download_Interaction (Datetime);

create index TrackID
     on Listen_Download_Interaction (TrackID);

create index PaymentID
     on Payment (PaymentID);

create index Username
     on Payment (Username);

create index PlaylistID
     on Playlist (PlaylistID);

create index ArtistID
     on Singer (ArtistID);

create index TrackID
     on SongTrack (TrackID);

create index ArtistID
     on SongTrack (ArtistID);

create index AlbumID
     on SongTrack (AlbumID);

create index GenreName
     on Style (GenreName);

create index ArtistID
     on Style (ArtistID);
     
# ---------------------------------------------------------------------- #
# Add info into "User"                                                   #
# ---------------------------------------------------------------------- #

INSERT INTO User VALUES ('Moh_Ata','mohammad.atabaki@studio.unibo.it','15121314','2000-01-11','Iranian','Cesena 47521','Mohammad','Atabaki','2023-12-31','2024-12-31','premium');
INSERT INTO User VALUES ('David6','david.66@gmail.com','12345678','1998-05-03','American','Newyork','David','Jackson',null,null,'free');
INSERT INTO User VALUES ('Giulia_Rizzo','giulia.rizzo@studio.unibo.it','g@R888','2001-08-15','Italian','Lecce','Guilia','Rizzo','2024-01-01','2025-01-01','premium');
INSERT INTO User VALUES ('Farideh_tvkl','farideh.tavakoli@studio.unibo.it','fff_ttt','1996-11-05','Iranian','Cesena 47522','Farideh','Tavakoli','2024-01-03','2025-01-03','premium');
INSERT INTO User VALUES ('sara_rossi','sara.rossi@yahoo.com','784512369','1990-03-17','German','Berlin','Sara','Rossi',null,null,'free');

# ---------------------------------------------------------------------- #
# Add info into "Artist"                                                 #
# ---------------------------------------------------------------------- #

INSERT INTO Artist VALUES (null,'Eminem','eminem');
INSERT INTO Artist VALUES (null,'The weekend','theweekend');
INSERT INTO Artist VALUES (null,'Maneskin','maneskinofficial');
INSERT INTO Artist VALUES (null,'Enrique Iglesias','enriqueiglesias');
INSERT INTO Artist VALUES (null,'Linkin park','linkinpark');
INSERT INTO Artist VALUES (null,'Chester Bennington','chesterbe');
INSERT INTO Artist VALUES (null,'Damiano David','damianodavid');

# ---------------------------------------------------------------------- #
# Add info into "Singer"                                                 #
# ---------------------------------------------------------------------- #

INSERT INTO Singer VALUES (1,'Marshall Bruce','Mathers','1972-10-17','American');
INSERT INTO Singer VALUES (2,'Abel','Makkonen','1990-02-16','Canadian');
INSERT INTO Singer VALUES (4,'Enrique','Iglesias','1975-05-08','Spanish');
INSERT INTO Singer VALUES (6,'Chester','Bennington','1976-03-20','American');
INSERT INTO Singer VALUES (7,'Damiano','David','1999-01-08','Italian');

# ---------------------------------------------------------------------- #
# Add info into "Band"                                                   #
# ---------------------------------------------------------------------- #

INSERT INTO Band VALUES (3,'2016-01-01',null);
INSERT INTO Band VALUES (5,'1996-01-01','2017-07-20');

# ---------------------------------------------------------------------- #
# Add info into "Composition"                                            #
# ---------------------------------------------------------------------- #

INSERT INTO Composition VALUES (6,5,'1996-01-01','2017-07-20');
INSERT INTO Composition VALUES (7,3,'2016-01-01',null);

# ---------------------------------------------------------------------- #
# Add info into "Album/Single"                                           #
# ---------------------------------------------------------------------- #

INSERT INTO Album_Single VALUES (null, 'Hybrid Theory','2000-10-24',5);
INSERT INTO Album_Single VALUES (null, 'Meteora','2003-03-25',5);
INSERT INTO Album_Single VALUES (null, "Teatro d'ira :vol.I",'2021-03-19',3);

# ---------------------------------------------------------------------- #
# Add info into "SongTrack"                                              #
# ---------------------------------------------------------------------- #

INSERT INTO SongTrack VALUES (null,'For Your Love','00:3:51',3,3);
INSERT INTO SongTrack VALUES (null,'Lose Yourself','00:5:26',1,null);
INSERT INTO SongTrack VALUES (null,'Creepin','00:3:42',2,null);
INSERT INTO SongTrack VALUES (null,'In the End','00:3:36',5,1);
INSERT INTO SongTrack VALUES (null,'One Step Closer','00:2:35',5,1);
INSERT INTO SongTrack VALUES (null,'Numb','00:3:06',5,2);
INSERT INTO SongTrack VALUES (null,'Breaking The Habit','00:3:16',5,2);
INSERT INTO SongTrack VALUES (null,'Ring My Bells','00:3:56',4,null);

# ---------------------------------------------------------------------- #
# Add info into "Genre"                                                  #
# ---------------------------------------------------------------------- #

INSERT INTO Genre VALUES ('Rock','Rock is a broad genre of popular music that originated as "rock and roll" in the United States in the late 1940s and early 1950s, developing into a range of different styles from the mid-1960s, particularly in the United States and the United Kingdom.');
INSERT INTO Genre VALUES ('Pop','Pop music is a genre of popular music that originated in its modern form during the mid-1950s in the United States and the United Kingdom.During the 1950s and 1960s, pop music encompassed rock and roll and the youth-oriented styles it influenced.');
INSERT INTO Genre VALUES ('Latin Pop','Latin pop (in Spanish and in Portuguese: Pop latino) is a pop music subgenre that is a fusion of US–style music production with Latin music genres from anywhere in Latin America and Spain.');
INSERT INTO Genre VALUES ('Metal','Heavy metal (or simply metal) is a genre of rock music that developed in the late 1960s and early 1970s, largely in the United Kingdom and United States. With roots in blues rock, psychedelic rock and acid rock, heavy metal bands developed a thick, monumental sound characterized by distorted guitars, extended guitar solos, emphatic beats and loudness.');
INSERT INTO Genre VALUES ('Rap','Rapping (also rhyming, flowing, spitting,emceeing or MCing) is an artistic form of vocal delivery and emotive expression that incorporates "rhyme, rhythmic speech, and [commonly] street vernacular". It is usually performed over a backing beat or musical accompaniment. The components of rap include "content" (what is being said, e.g., lyrics), "flow" (rhythm, rhyme), and "delivery" (cadence, tone). Rap differs from spoken-word poetry in that it is usually performed off-time to musical accompaniment.');

# ---------------------------------------------------------------------- #
# Add info into "Style"                                                  #
# ---------------------------------------------------------------------- #

INSERT INTO Style VALUES (1,'Rap');
INSERT INTO Style VALUES (2,'Pop');
INSERT INTO Style VALUES (3,'Rock');
INSERT INTO Style VALUES (4,'Latin Pop');
INSERT INTO Style VALUES (5,'Metal');
INSERT INTO Style VALUES (6,'Metal');
INSERT INTO Style VALUES (7,'Rock');

# ---------------------------------------------------------------------- #
# Add info into "Has_a"                                                  #
# ---------------------------------------------------------------------- #

INSERT INTO Has_a VALUES ('Rock',1);
INSERT INTO Has_a VALUES ('Rap',2);
INSERT INTO Has_a VALUES ('Pop',3);
INSERT INTO Has_a VALUES ('Metal',4);
INSERT INTO Has_a VALUES ('Metal',5);
INSERT INTO Has_a VALUES ('Metal',6);
INSERT INTO Has_a VALUES ('Metal',7);
INSERT INTO Has_a VALUES ('Latin Pop',8);

# ---------------------------------------------------------------------- #
# Add info into "Listen/Download/Interaction"                            #
# ---------------------------------------------------------------------- #

INSERT INTO Listen_Download_Interaction VALUES ('Moh_Ata','2024-01-01 13:57:21.000','Yes',4);
INSERT INTO Listen_Download_Interaction VALUES ('Moh_Ata','2024-01-01 18:21:03.000','Yes',6);
INSERT INTO Listen_Download_Interaction VALUES ('David6','2024-0-03 09:43:56.000','No',2);
INSERT INTO Listen_Download_Interaction VALUES ('Giulia_Rizzo','2024-0-03 09:43:56.000','Yes',1);
INSERT INTO Listen_Download_Interaction VALUES ('Farideh_tvkl','2024-01-05 12:37:12.000','Yes',3);

# ---------------------------------------------------------------------- #
# Add info into "Playlist"                                               #
# ---------------------------------------------------------------------- #

INSERT INTO Playlist VALUES (null,'Metal Mix','00:12:33','2024-01-05');
INSERT INTO Playlist VALUES (null,'Favourite','00:16:55','2024-01-03');

# ---------------------------------------------------------------------- #
# Add info into "Contain"                                                #
# ---------------------------------------------------------------------- #

INSERT INTO Contain VALUES (1,4);
INSERT INTO Contain VALUES (1,5);
INSERT INTO Contain VALUES (1,6);
INSERT INTO Contain VALUES (1,7);
INSERT INTO Contain VALUES (2,1);
INSERT INTO Contain VALUES (2,2);
INSERT INTO Contain VALUES (2,3);
INSERT INTO Contain VALUES (2,8);

# ---------------------------------------------------------------------- #
# Add info into "Build"                                                 #
# ---------------------------------------------------------------------- #

INSERT INTO Build VALUES (1,'Moh_Ata');
INSERT INTO Build VALUES (2,'Giulia_Rizzo');

# ---------------------------------------------------------------------- #
# Add info into "Follow"                                                 #
# ---------------------------------------------------------------------- #

INSERT INTO Follow VALUES (1,'Moh_Ata');
INSERT INTO Follow VALUES (2,'Giulia_Rizzo');
INSERT INTO Follow VALUES (1,'David6');
INSERT INTO Follow VALUES (2,'David6');
INSERT INTO Follow VALUES (1,'Farideh_tvkl');
INSERT INTO Follow VALUES (2,'Moh_Ata');

# ---------------------------------------------------------------------- #
# Add info into "Payment"                                                #
# ---------------------------------------------------------------------- #

INSERT INTO Payment VALUES (null,'Moh_Ata',13.99,'2023-12-31 13:01:16.000','Google Pay');
INSERT INTO Payment VALUES (null,'Giulia_Rizzo',13.99,'2024-01-01 11:24:33.000','Paypal');
INSERT INTO Payment VALUES (null,'Farideh_tvkl',13.99,'2024-01-03 22:38:59.000','Apple Pay');

# ---------------------------------------------------------------------- #
# Add info into "Advertisement"                                          #
# ---------------------------------------------------------------------- #

INSERT INTO Advertisement VALUES (null,'Apple');
INSERT INTO Advertisement VALUES (null,'Grammarly');

# ---------------------------------------------------------------------- #
# Add info into "AdvWatching"                                            #
# ---------------------------------------------------------------------- #

INSERT INTO AdvWatching VALUES ('2024-01-01 13:26:31.000','David6',1);
INSERT INTO AdvWatching VALUES ('2024-01-01 13:41:31.000','David6',2);
INSERT INTO AdvWatching VALUES ('2024-01-03 09:32:47.000','sara_rossi',1);
INSERT INTO AdvWatching VALUES ('2024-01-04 18:23:03.000','sara_rossi',2);



