create table STATUS
(STATUS_ID   NUMBER(4),
 NAME        VARCHAR2(30),
 CREATED_AT  DATE default sysdate,
 UPDATED_AT  DATE,
 UPDATED_BY  VARCHAR2(30),
 constraint PK_STATUS primary key (STATUS_ID) using index);
--
COMMENT ON TABLE STATUS       IS 'Catalog Candidates status';
COMMENT ON COLUMN STATUS.STATUS_ID   IS 'Status unique identifier';
COMMENT ON COLUMN STATUS.NAME IS 'Name of Status';
COMMENT ON COLUMN STATUS.CREATED_AT  IS 'Creation date of the record';
COMMENT ON COLUMN STATUS.UPDATED_AT  IS 'Updated date of the record';
COMMENT ON COLUMN STATUS.UPDATED_BY  IS 'User who updated the record';
--
create table CONTACT_SOURCES
(CONTACT_SOURCES_ID NUMBER(4),
 NAME               VARCHAR2(30),
 CREATED_AT         DATE default sysdate,
 UPDATED_AT         DATE,
 UPDATED_BY         VARCHAR2(30),
 constraint PK_CONTACT_SOURCES_ID primary key (CONTACT_SOURCES_ID) using index);
--
COMMENT ON TABLE CONTACT_SOURCES                     IS 'Catalog Source Contacts';
COMMENT ON COLUMN CONTACT_SOURCES.CONTACT_SOURCES_ID IS 'Contact source unique identifier';
COMMENT ON COLUMN CONTACT_SOURCES.NAME               IS 'Name of the Contact Source';
COMMENT ON COLUMN CONTACT_SOURCES.CREATED_AT         IS 'Creation date of the record';
COMMENT ON COLUMN CONTACT_SOURCES.UPDATED_AT         IS 'Updated date of the record';
COMMENT ON COLUMN CONTACT_SOURCES.UPDATED_BY         IS 'User who updated the record';
--
create table TECHNOLOGIES
(TECHNOLOGY_ID   NUMBER(4),
 NAME            VARCHAR2(30),
 CREATED_AT      DATE default sysdate,
 UPDATED_AT      DATE,
 UPDATED_BY      VARCHAR2(30),
 constraint PK_TECHNOLOGIES primary key (TECHNOLOGY_ID) using index);
--
COMMENT ON TABLE  TECHNOLOGIES               IS 'Catalog of technologies';
COMMENT ON COLUMN TECHNOLOGIES.TECHNOLOGY_ID IS 'Technology unique identifier';
COMMENT ON COLUMN TECHNOLOGIES.NAME          IS 'Technology name';
COMMENT ON COLUMN TECHNOLOGIES.CREATED_AT    IS 'Creation date of the record';
COMMENT ON COLUMN TECHNOLOGIES.UPDATED_AT    IS 'Updated date of the record';
COMMENT ON COLUMN TECHNOLOGIES.UPDATED_BY    IS 'User who updated the record';
--
create table CANDIDATES
(CANDIDATES_ID        NUMBER(8),
 STATUS_ID            NUMBER(4),
 ARCHIVE_REASON       VARCHAR2(100),
 TECHNOLOGY_ID        NUMBER(4),
 EXPERTISE_LEVEL      VARCHAR2(1) check (EXPERTISE_LEVEL in ('A','B','I','J','S')),
 NAME                 VARCHAR2(50),
 CONTACT_SOURCE_ID    NUMBER(4),
 REFERED_BY           VARCHAR2(50),
 LAST_DATE_CONTACTED  DATE,
 GENDER               VARCHAR2(1) check (GENDER in ('F','M')),
 MARITAL_STATUS       NUMBER(1) check (MARITAL_STATUS in (1,2,3,4)),
 PROPERTY             VARCHAR2(50),
 BIRTHDATE            DATE,
 PLACE_OF_BIRTH       VARCHAR2(50),
 PLACE_OF_RESIDENCE   VARCHAR2(50),
 ADDRESS              VARCHAR2(100),
 EMAIL                VARCHAR2(50),
 PHONE                VARCHAR2(20),
 MOBILE               VARCHAR2(20),
 OFFICE_TELEPHONE     VARCHAR2(20),
 CITIZENSHIP          VARCHAR2(20),
 HAS_VISA             VARCHAR2(1) check (HAS_VISA in ('Y','N','E','X')),
 VISA_EXPIR_YEAR      NUMBER(4),
 HAS_PASSPORT         VARCHAR2(1) check (HAS_PASSPORT in ('Y','N')),
 PASSPORT_EXPIR_YEAR  NUMBER(4),
 WILLING_TO_TRAVEL    VARCHAR2(1) check (WILLING_TO_TRAVEL in ('Y','N','U','X')),
 TRAVEL_PREFERENCES   NUMBER(1) check (TRAVEL_PREFERENCES in (1,2,3,4,5,6)),
 WILLING_TO_RELOCATE  VARCHAR2(1) check (WILLING_TO_RELOCATE in ('Y','N','U','X')),
 RELOCATE_PREFERENCES NUMBER(1) check (RELOCATE_PREFERENCES in (1,2,3,4,5,6)),
 AVAILABILITY_START   VARCHAR2(50),
 CURRENTLY_EMPLOYED   VARCHAR2(1) check (CURRENTLY_EMPLOYED in ('Y','N')),
 COMPANY              VARCHAR2(50),
 TIME_THERE           VARCHAR2(50),
 POSITION             VARCHAR2(50),
 RELATIONSHIP         VARCHAR2(50),
 CONTRACT_TYPE        VARCHAR2(50),
 SALARY_EXPECTANCY    NUMBER(12,2),
 CURRENT_SALARY       NUMBER(12,2),
 COMMENTS             VARCHAR2(2000),
 FIRST_NAME           VARCHAR2(20),
 MIDDLE_NAME          VARCHAR2(20),
 FIRST_LAST_NAME      VARCHAR2(20),
 SECOND_LAST_NAME     VARCHAR2(20),
 ADDRESS1             VARCHAR2(50),
 NEIGHBORHOOD         VARCHAR2(50),
 CITY                 VARCHAR2(50),
 COUNTRY              VARCHAR2(50),
 ZIPCODE              VARCHAR2(20),
 HOME_PHONE           VARCHAR2(20),
 CELL_PHONE           VARCHAR2(20),
 OFFICE_PHONE         VARCHAR2(20),
 ENCRYPTED_PASSWORD   VARCHAR2(30),
 SALT                 VARCHAR2(20),
 PASSWORD_CONFIRMA    VARCHAR2(30),
 CHANGE_PASSWORD_FLAG VARCHAR2(1) check (CHANGE_PASSWORD_FLAG in ('Y','N')),
 ADMIN_FLAG           VARCHAR2(1) check (ADMIN_FLAG in ('Y','N')),
 AVATAR_FILE_NAME     VARCHAR2(30),
 AVATAR_CONTENT_TYPE  VARCHAR2(30),
 AVATAR_FILE_SIZE     VARCHAR2(30),
 AVATAR_UPDATE_AT     DATE,
 CREATED_AT           DATE default sysdate,
 UPDATED_AT           DATE,
 UPDATED_BY           VARCHAR2(30),
 constraint PK_CANDIDATES primary key (CANDIDATES_ID) USING INDEX);

COMMENT ON TABLE  CANDIDATES                      IS 'Candidates general data';
COMMENT ON COLUMN CANDIDATES.CANDIDATES_ID        IS 'Candidate unique identifier';
COMMENT ON COLUMN CANDIDATES.STATUS_ID            IS 'Identifier status of the of candidate in catalog of status';
COMMENT ON COLUMN CANDIDATES.ARCHIVE_REASON       IS 'Reason to archive candidate file';
COMMENT ON COLUMN CANDIDATES.TECHNOLOGY_ID        IS 'Identifier of technological knowledge of candidate';
COMMENT ON COLUMN CANDIDATES.EXPERTISE_LEVEL      IS 'Candidate expertise, A-Architect, B-Beginner, I-Intermediate, J-Junior, S-Senior';
COMMENT ON COLUMN CANDIDATES.NAME                 IS 'Candidate name';
COMMENT ON COLUMN CANDIDATES.CONTACT_SOURCE_ID    IS 'Identifier of source in catalog of contacts';
COMMENT ON COLUMN CANDIDATES.LAST_DATE_CONTACTED  IS 'Date of last contact';
COMMENT ON COLUMN CANDIDATES.REFERED_BY           IS 'Person who refered the candidate';
COMMENT ON COLUMN CANDIDATES.GENDER               IS 'Candidate gender, F-Female - M-Male';
COMMENT ON COLUMN CANDIDATES.MARITAL_STATUS       IS 'Candidate marital status, 1-Single, 2-Married, 3-Divorced, 4-Common Law Marriage';
COMMENT ON COLUMN CANDIDATES.PROPERTY             IS 'Candidate propertu';
COMMENT ON COLUMN CANDIDATES.BIRTHDATE            IS 'Candidate birthdate';
COMMENT ON COLUMN CANDIDATES.PLACE_OF_BIRTH       IS 'Place of birthdate of candidate';
COMMENT ON COLUMN CANDIDATES.PLACE_OF_RESIDENCE   IS 'Place of residence of candidate';
COMMENT ON COLUMN CANDIDATES.ADDRESS              IS 'Candidate address';
COMMENT ON COLUMN CANDIDATES.EMAIL                IS 'Candidate Email';
COMMENT ON COLUMN CANDIDATES.PHONE                IS 'Candidate phone';
COMMENT ON COLUMN CANDIDATES.MOBILE               IS 'Candidate mobile';
COMMENT ON COLUMN CANDIDATES.OFFICE_TELEPHONE     IS 'Candidate office phone';
COMMENT ON COLUMN CANDIDATES.CITIZENSHIP          IS 'Candidate citizenship';
COMMENT ON COLUMN CANDIDATES.HAS_VISA             IS 'The candidate has visa, Y-Yes, N-No, E-Expired, X-No apply';
COMMENT ON COLUMN CANDIDATES.VISA_EXPIR_YEAR      IS 'Year of visa expiration';
COMMENT ON COLUMN CANDIDATES.HAS_PASSPORT         IS 'The candidate has Passport, Y-Yes, N-No';
COMMENT ON COLUMN CANDIDATES.PASSPORT_EXPIR_YEAR  IS 'Year of Passport expiration';
COMMENT ON COLUMN CANDIDATES.WILLING_TO_TRAVEL    IS 'Is the candidate willing to travel, Y-Yes, N-No, U-Undecided';
COMMENT ON COLUMN CANDIDATES.TRAVEL_PREFERENCES   IS 'Travel preferences: 1-Mérida 2-Colima 3-D.F. 4-La Paz 5-USA 6-Other';
COMMENT ON COLUMN CANDIDATES.WILLING_TO_RELOCATE  IS 'Is the candidate willing to relocate, Y-Yes, N-No U-Undecided, X-No apply';
COMMENT ON COLUMN CANDIDATES.RELOCATE_PREFERENCES IS 'Relocate preferences: 1-Mérida 2-Colima 3-D.F. 4-La Paz 5-USA 6-Other';
COMMENT ON COLUMN CANDIDATES.AVAILABILITY_START   IS 'Comments about availability to start to work';
COMMENT ON COLUMN CANDIDATES.CURRENTLY_EMPLOYED   IS 'Is the candidate currently employed, Y-Yes, N-No';
COMMENT ON COLUMN CANDIDATES.COMPANY              IS 'Candidate current company';
COMMENT ON COLUMN CANDIDATES.TIME_THERE           IS 'Comments about time of working in current company of candidate';
COMMENT ON COLUMN CANDIDATES.POSITION             IS 'Comments about actual position of candidate in the current company';
COMMENT ON COLUMN CANDIDATES.RELATIONSHIP         IS 'Comments about relatioship type of candidate in the current company';
COMMENT ON COLUMN CANDIDATES.CONTRACT_TYPE        IS 'Candidate type of contract';
COMMENT ON COLUMN CANDIDATES.SALARY_EXPECTANCY    IS 'Amount of salary expected for the candidate';
COMMENT ON COLUMN CANDIDATES.CURRENT_SALARY       IS 'Amount of candidate actual salary';
COMMENT ON COLUMN CANDIDATES.COMMENTS             IS 'Comments about the candidate';
COMMENT ON COLUMN CANDIDATES.FIRST_NAME           IS 'Candidate first name';
COMMENT ON COLUMN CANDIDATES.MIDDLE_NAME          IS 'Candidate middle name';
COMMENT ON COLUMN CANDIDATES.FIRST_LAST_NAME      IS 'Candidate first last name';
COMMENT ON COLUMN CANDIDATES.SECOND_LAST_NAME     IS 'Candidate second last name';
COMMENT ON COLUMN CANDIDATES.ADDRESS1             IS 'Candidate address';
COMMENT ON COLUMN CANDIDATES.NEIGHBORHOOD         IS 'Candidate neighborhood';
COMMENT ON COLUMN CANDIDATES.CITY                 IS 'Candidate city';
COMMENT ON COLUMN CANDIDATES.COUNTRY              IS 'Candidate country';
COMMENT ON COLUMN CANDIDATES.ZIPCODE              IS 'Candidate zip code';
COMMENT ON COLUMN CANDIDATES.HOME_PHONE           IS 'Candidate home phone number';
COMMENT ON COLUMN CANDIDATES.CELL_PHONE           IS 'Candidate cell phone number';
COMMENT ON COLUMN CANDIDATES.OFFICE_PHONE         IS 'Candidate office phone number';
COMMENT ON COLUMN CANDIDATES.ENCRYPTED_PASSWORD   IS 'Password encrypted';
COMMENT ON COLUMN CANDIDATES.SALT                 IS 'Candidate salt';
COMMENT ON COLUMN CANDIDATES.PASSWORD_CONFIRMA    IS 'Password confirmation';
COMMENT ON COLUMN CANDIDATES.CHANGE_PASSWORD_FLAG IS 'Flag for change password, Y-Yes, N-No';
COMMENT ON COLUMN CANDIDATES.ADMIN_FLAG           IS 'Flag for admin, Y-Yes, N-No';
COMMENT ON COLUMN CANDIDATES.AVATAR_FILE_NAME     IS 'File name of the avatar';
COMMENT ON COLUMN CANDIDATES.AVATAR_CONTENT_TYPE  IS 'Content type of the avatar';
COMMENT ON COLUMN CANDIDATES.AVATAR_FILE_SIZE     IS 'File size of the avatar file';
COMMENT ON COLUMN CANDIDATES.AVATAR_UPDATE_AT     IS 'Updated date of the avatar';
COMMENT ON COLUMN CANDIDATES.CREATED_AT           IS 'Creation date of the record';
COMMENT ON COLUMN CANDIDATES.UPDATED_AT           IS 'Updated date of the record';
COMMENT ON COLUMN CANDIDATES.UPDATED_BY           IS 'User who updated the record';

ALTER TABLE CANDIDATES ADD (
  CONSTRAINT FK_STATUS_CANDIDATES 
  FOREIGN KEY (STATUS_ID) 
  REFERENCES STATUS(STATUS_ID));
 
ALTER TABLE CANDIDATES ADD (
  CONSTRAINT FK_CONTACTS_CANDIDATES 
  FOREIGN KEY (CONTACT_SOURCE_ID) 
  REFERENCES CONTACT_SOURCES(CONTACT_SOURCES_ID));

ALTER TABLE CANDIDATES ADD (
  CONSTRAINT FK_TECHNOLOGIES_CANDIDATES 
  FOREIGN KEY (TECHNOLOGY_ID) 
  REFERENCES TECHNOLOGIES(TECHNOLOGY_ID));
--
 create table CAND_PROF_SUMMARY
(SUMMARY_ID    number(4),
 CANDIDATES_ID number(8), 
 PROF_SUMMARY  varchar2(4000),
 CREATED_AT    date default sysdate,
 UPDATED_AT    date,
 UPDATED_BY    VARCHAR2(30),
 constraint PK_CANDPROFSUMM primary key (SUMMARY_ID, CANDIDATES_ID) using index);
--
 ALTER TABLE CAND_PROF_SUMMARY ADD (
  CONSTRAINT FK_CAND_CANDPROFSUMM
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));

COMMENT ON TABLE CAND_PROF_SUMMARY                IS 'Summary of Candidate profesional data';
COMMENT ON COLUMN CAND_PROF_SUMMARY.SUMMARY_ID    IS 'Summary unique identifier';
COMMENT ON COLUMN CAND_PROF_SUMMARY.CANDIDATES_ID IS 'Candidate unique identifier';
COMMENT ON COLUMN CAND_PROF_SUMMARY.PROF_SUMMARY  IS 'Profesional Summary';
COMMENT ON COLUMN CAND_PROF_SUMMARY.CREATED_AT    IS 'Record creation date';
COMMENT ON COLUMN CAND_PROF_SUMMARY.UPDATED_AT    IS 'Record update date';
COMMENT ON COLUMN CAND_PROF_SUMMARY.UPDATED_BY    IS 'User who updated the record';
--
create table INTERVIEWERS
(INTERVIEWER_ID     NUMBER(4),
 NAME               VARCHAR2(30),
 CREATED_AT         DATE default sysdate,
 UPDATED_AT         DATE,
 UPDATED_BY         VARCHAR2(30),
 constraint PK_INTERVIEWERS primary key (INTERVIEWER_ID) using index);
--
COMMENT ON TABLE INTERVIEWERS                 IS 'Catalog Interviewers';
COMMENT ON COLUMN INTERVIEWERS.INTERVIEWER_ID IS 'Interviewer unique identifier';
COMMENT ON COLUMN INTERVIEWERS.NAME           IS 'Name of the Interviewer';
COMMENT ON COLUMN INTERVIEWERS.CREATED_AT     IS 'Creation date of the record';
COMMENT ON COLUMN INTERVIEWERS.UPDATED_AT     IS 'Updated date of the record';
COMMENT ON COLUMN INTERVIEWERS.UPDATED_BY     IS 'User who updated the record';
--
create table INTERVIEW_TYPES
(INTERVIEW_TYPE_ID  NUMBER(4),
 NAME               VARCHAR2(30),
 CREATED_AT         DATE default sysdate,
 UPDATED_AT         DATE,
 UPDATED_BY         VARCHAR2(30),
 constraint PK_INTERVIEW_TYPES primary key (INTERVIEW_TYPE_ID) using index);
--
COMMENT ON TABLE INTERVIEW_TYPES                    IS 'Catalog Types of Interviews';
COMMENT ON COLUMN INTERVIEW_TYPES.INTERVIEW_TYPE_ID IS 'Interview type unique identifier';
COMMENT ON COLUMN INTERVIEW_TYPES.NAME              IS 'Name of Type of Interview';
COMMENT ON COLUMN INTERVIEW_TYPES.CREATED_AT        IS 'Creation date of the record';
COMMENT ON COLUMN INTERVIEW_TYPES.UPDATED_AT        IS 'Updated date of the record';
COMMENT ON COLUMN INTERVIEW_TYPES.UPDATED_BY        IS 'User who updated the record';
--
create table CANDIDATES_INTERVIEWS
(ID                NUMBER(4),
 CANDIDATES_ID     NUMBER(8),
 RESULT            VARCHAR2(100),
 INTERVIEW_TYPE_ID NUMBER(4),
 INTERVIEWER_ID    NUMBER(4),
 COMMENTS          VARCHAR2(2000),
 CREATED_AT        DATE default sysdate,
 UPDATED_AT        DATE,
 UPDATED_BY        VARCHAR2(30),
 constraint PK_CANDINTVIEW primary key (ID,CANDIDATES_ID) using index);
--
ALTER TABLE CANDIDATES_INTERVIEWS ADD (
  CONSTRAINT FK_CANDINTVIEW
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
ALTER TABLE CANDIDATES_INTERVIEWS ADD (
  CONSTRAINT FK_CANDINTVIEWTYPE
  FOREIGN KEY (INTERVIEW_TYPE_ID) 
  REFERENCES INTERVIEW_TYPES(INTERVIEW_TYPE_ID));
--
ALTER TABLE CANDIDATES_INTERVIEWS ADD (
  CONSTRAINT FK_CANDINT_INTVIEWERS
  FOREIGN KEY (INTERVIEWER_ID) 
  REFERENCES INTERVIEWERS(INTERVIEWER_ID));
--
COMMENT ON TABLE CANDIDATES_INTERVIEWS IS 'Interviews of candidates';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.ID                IS 'Interview candidate unique identifier';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.CANDIDATES_ID     IS 'Candidate unique identifier';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.RESULT            IS 'Result of interview';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.INTERVIEW_TYPE_ID IS 'Interview Type unique identifier';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.INTERVIEWER_ID    IS 'Interviewer unique identifier';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.COMMENTS          IS 'Comments about interview';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.CREATED_AT        IS 'Creation date of the record';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.UPDATED_AT        IS 'Updated date of the record';
COMMENT ON COLUMN CANDIDATES_INTERVIEWS.UPDATED_BY        IS 'User who updated the record';
--
create table SEC_ROLES
(SEC_ROLES_ID     NUMBER(4),
 DESCRIPTION      VARCHAR2(100),
 GRANT_ALL_RIGHTS VARCHAR2(1) check (GRANT_ALL_RIGHTS in ('Y','N')),
 CREATED_AT       DATE default sysdate,
 UPDATED_AT       DATE,
 UPDATED_BY       VARCHAR2(30),
 constraint PK_SEC_ROLES primary key (SEC_ROLES_ID) using index);
--
COMMENT ON TABLE SEC_ROLES                   IS 'Table Security Roles';
COMMENT ON COLUMN SEC_ROLES.SEC_ROLES_ID     IS 'Security Role unique identifier';
COMMENT ON COLUMN SEC_ROLES.DESCRIPTION      IS 'Description of Security Role';
COMMENT ON COLUMN SEC_ROLES.GRANT_ALL_RIGHTS IS 'Flag for grant all rights, Y-Yes, N-No';
COMMENT ON COLUMN SEC_ROLES.CREATED_AT       IS 'Creation date of the record';
COMMENT ON COLUMN SEC_ROLES.UPDATED_AT       IS 'Updated date of the record';
COMMENT ON COLUMN SEC_ROLES.UPDATED_BY       IS 'User who updated the record';
--
create table USERS
(USERS_ID         NUMBER(8),
 SEC_ROLES_ID     NUMBER(4),
 LOGIN_NAME       VARCHAR2(30),
 LAST_LOGIN       DATE,
 PASSWORD_EXPIRES VARCHAR2(1) check (PASSWORD_EXPIRES in ('Y','N')),
 EXPIRATION_DATE  DATE,
 USER_LOCKED      VARCHAR2(1) check (USER_LOCKED in ('Y','N')),
 USER_PASSWORD    VARCHAR2(8),
 CREATED_AT       DATE default sysdate,
 UPDATED_AT       DATE,
 UPDATED_BY       VARCHAR2(30),
 constraint PK_USERS primary key (USERS_ID) using index);
--
ALTER TABLE USERS ADD (
  CONSTRAINT FK_USERS_SEC_ROLES
  FOREIGN KEY (SEC_ROLES_ID) 
  REFERENCES SEC_ROLES(SEC_ROLES_ID));
--
COMMENT ON TABLE USERS                   IS 'Table Users';
COMMENT ON COLUMN USERS.USERS_ID         IS 'User unique identifier';
COMMENT ON COLUMN USERS.SEC_ROLES_ID     IS 'Security Role unique identifier';
COMMENT ON COLUMN USERS.LOGIN_NAME       IS 'User login name';
COMMENT ON COLUMN USERS.LAST_LOGIN       IS 'Date of last login';
COMMENT ON COLUMN USERS.PASSWORD_EXPIRES IS 'The password expires? Y-Yes, N-No';
COMMENT ON COLUMN USERS.EXPIRATION_DATE  IS 'Date of password expiration';
COMMENT ON COLUMN USERS.USER_LOCKED      IS 'Is the user locked? Y-Yes, N-No';
COMMENT ON COLUMN USERS.USER_PASSWORD    IS 'User password';
COMMENT ON COLUMN USERS.CREATED_AT       IS 'Creation date of the record';
COMMENT ON COLUMN USERS.UPDATED_AT       IS 'Updated date of the record';
COMMENT ON COLUMN USERS.UPDATED_BY       IS 'User who updated the record';
--
create table USERS_SEC_ROLES
(USERS_ID         NUMBER(8),
 SEC_ROLES_ID     NUMBER(4),
 CREATED_AT       DATE default sysdate,
 UPDATED_AT       DATE,
 UPDATED_BY       VARCHAR2(30),
 constraint PK_USERS_SECROL primary key (USERS_ID, SEC_ROLES_ID) using index);
--
ALTER TABLE USERS_SEC_ROLES ADD (
  CONSTRAINT FK_USERSSECROL
  FOREIGN KEY (SEC_ROLES_ID) 
  REFERENCES SEC_ROLES(SEC_ROLES_ID));
--
--ALTER TABLE USERS_SEC_ROLES ADD (
--  CONSTRAINT FK_USERSSECROL1
--  FOREIGN KEY (LOGIN_NAME) 
--  REFERENCES USERS(LOGIN_NAME));
--
COMMENT ON TABLE USERS_SEC_ROLES               IS 'Relation security roles/users';
COMMENT ON COLUMN USERS_SEC_ROLES.USERS_ID     IS 'User ID unique identifier';
COMMENT ON COLUMN USERS_SEC_ROLES.SEC_ROLES_ID IS 'Security Role unique identifier';
COMMENT ON COLUMN USERS_SEC_ROLES.CREATED_AT   IS 'Creation date of the record';
COMMENT ON COLUMN USERS_SEC_ROLES.UPDATED_AT   IS 'Updated date of the record';
COMMENT ON COLUMN USERS_SEC_ROLES.UPDATED_BY   IS 'User who updated the record';
--
create table PROFILES
(PROFILES_ID   number(4),
 NAME          varchar2(30), 
 DESCRIP       varchar2(50),     
 APPROVED_FLAG varchar2(1) check (APPROVED_FLAG in ('Y','N')),
 APPROVED_BY   varchar2(30),
 CREATED_AT    date default sysdate,
 UPDATED_AT    date,
 UPDATED_BY    VARCHAR2(30),
 constraint PK_PROFILES primary key (PROFILES_ID) using index);

COMMENT ON TABLE PROFILES                IS 'Candidates profiles';
COMMENT ON COLUMN PROFILES.PROFILES_ID   IS 'Profile unique identifier';
COMMENT ON COLUMN PROFILES.NAME          IS 'Profile name';
COMMENT ON COLUMN PROFILES.DESCRIP       IS 'Profile description';
COMMENT ON COLUMN PROFILES.APPROVED_FLAG IS 'Flag of approval, Y-Yes, N-No';
COMMENT ON COLUMN PROFILES.APPROVED_BY   IS 'Person who approved';
COMMENT ON COLUMN PROFILES.CREATED_AT    IS 'Record creation date';
COMMENT ON COLUMN PROFILES.UPDATED_AT    IS 'Record update date';
COMMENT ON COLUMN PROFILES.UPDATED_BY    IS 'User who updated the record';
--
create table CANDIDATES_PROFILES
(CANDIDATES_PROFILES_ID number(4),
 CANDIDATES_ID          number(8),
 PROFILES_ID            number(4), 
 SUMMARY                varchar2(2000),   
 CREATED_AT             date default sysdate,
 UPDATED_AT             date,
 UPDATED_BY             VARCHAR2(30),
 constraint PK_CANDPROF primary key (CANDIDATES_PROFILES_ID, CANDIDATES_ID) using index);
--
ALTER TABLE CANDIDATES_PROFILES ADD (
  CONSTRAINT FK_CANDPROFCAND
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
ALTER TABLE CANDIDATES_PROFILES ADD (
  CONSTRAINT FK_CANDPROF_PROF
  FOREIGN KEY (PROFILES_ID) 
  REFERENCES PROFILES(PROFILES_ID));
--
COMMENT ON TABLE CANDIDATES_PROFILES                         IS 'Relation Candidates and Profiles';
COMMENT ON COLUMN CANDIDATES_PROFILES.CANDIDATES_PROFILES_ID IS 'Candidate/Profile unique identifier';
COMMENT ON COLUMN CANDIDATES_PROFILES.CANDIDATES_ID          IS 'Candidate unique identifier';
COMMENT ON COLUMN CANDIDATES_PROFILES.PROFILES_ID            IS 'Profile unique identifier';
COMMENT ON COLUMN CANDIDATES_PROFILES.SUMMARY                IS 'Candidate/Profile Summary';
COMMENT ON COLUMN CANDIDATES_PROFILES.CREATED_AT             IS 'Record creation date';
COMMENT ON COLUMN CANDIDATES_PROFILES.UPDATED_AT             IS 'Record update date';
COMMENT ON COLUMN CANDIDATES_PROFILES.UPDATED_BY             IS 'User who updated the record';
--
create table PROJECTS
(PROJECTS_ID   number(4),
 CANDIDATES_ID number(8),
 NAME          varchar2(100),  
 SUMMARY       varchar2(2000),
 COMPANY_NAME  varchar2(50),
 CREATED_AT    date default sysdate,
 UPDATED_AT    date,
 UPDATED_BY    VARCHAR2(30),
 constraint PK_PROJECTS primary key (PROJECTS_ID) using index);
--
ALTER TABLE PROJECTS ADD (
  CONSTRAINT FK_CANDPROJS
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));

COMMENT ON TABLE PROJECTS                IS 'Candidates Projects';
COMMENT ON COLUMN PROJECTS.PROJECTS_ID   IS 'Projects unique identifier';
COMMENT ON COLUMN PROJECTS.CANDIDATES_ID IS 'Candidate unique identifier';
COMMENT ON COLUMN PROJECTS.NAME          IS 'Project name';
COMMENT ON COLUMN PROJECTS.SUMMARY       IS 'Project Summary';
COMMENT ON COLUMN PROJECTS.COMPANY_NAME  IS 'Company Name';
COMMENT ON COLUMN PROJECTS.CREATED_AT    IS 'Record creation date';
COMMENT ON COLUMN PROJECTS.UPDATED_AT    IS 'Record update date';
COMMENT ON COLUMN PROJECTS.UPDATED_BY    IS 'User who updated the record';
--
create table ROLES
(ROLES_ID      number(4),
 NAME          varchar2(50), 
 DESCRIP       varchar2(500),
 APPROVED_FLAG varchar2(1) check (APPROVED_FLAG in ('Y','N')),
 APPROVED_BY   varchar2(30),
 CREATED_AT    date default sysdate,
 UPDATED_AT    date,
 UPDATED_BY    VARCHAR2(30),
 constraint PK_ROLES primary key (ROLES_ID) using index);
--
COMMENT ON TABLE ROLES                IS 'Roles catalog';
COMMENT ON COLUMN ROLES.ROLES_ID      IS 'Roles unique identifier';
COMMENT ON COLUMN ROLES.NAME          IS 'Role Name';
COMMENT ON COLUMN ROLES.DESCRIP       IS 'Description of Role';
COMMENT ON COLUMN ROLES.APPROVED_FLAG IS 'Flag of approval, Y-Yes, N-No';
COMMENT ON COLUMN ROLES.APPROVED_BY   IS 'Person who approved';
COMMENT ON COLUMN ROLES.CREATED_AT    IS 'Record creation date';
COMMENT ON COLUMN ROLES.UPDATED_AT    IS 'Record update date';
COMMENT ON COLUMN ROLES.UPDATED_BY    IS 'User who updated the record';
--
create table PROJECTS_ROLES
(PROJROLES_ID number(4),
 PROJECTS_ID  number(4),
 ROLES_ID     number(4),
 DATE_IN      date,
 DATE_OUT     date,
 CREATED_AT   date default sysdate,
 UPDATED_AT   date,
 UPDATED_BY   varchar2(30),
 constraint PK_PROJROLES primary key (PROJROLES_ID) using index);
--
ALTER TABLE PROJECTS_ROLES ADD (
  CONSTRAINT FK_PROJROLES_PROJS
  FOREIGN KEY (PROJECTS_ID) 
  REFERENCES PROJECTS(PROJECTS_ID));
--
ALTER TABLE PROJECTS_ROLES ADD (
  CONSTRAINT FK_PROJROLES_ROLES
  FOREIGN KEY (ROLES_ID) 
  REFERENCES ROLES(ROLES_ID));
--
COMMENT ON TABLE PROJECTS_ROLES IS 'Relation Projects and Roles';
COMMENT ON COLUMN PROJECTS_ROLES.PROJROLES_ID IS 'Projects/Roles unique identifier';
COMMENT ON COLUMN PROJECTS_ROLES.PROJECTS_ID  IS 'Projects unique identifier';
COMMENT ON COLUMN PROJECTS_ROLES.ROLES_ID     IS 'Roles unique identifier';
COMMENT ON COLUMN PROJECTS_ROLES.DATE_IN      IS 'Date In';
COMMENT ON COLUMN PROJECTS_ROLES.DATE_OUT     IS 'Date Out';
COMMENT ON COLUMN PROJECTS_ROLES.CREATED_AT   IS 'Record creation date';
COMMENT ON COLUMN PROJECTS_ROLES.UPDATED_AT   IS 'Record update date';
COMMENT ON COLUMN PROJECTS_ROLES.UPDATED_BY   IS 'User who updated the record';
--
create table TAGS
(TAGS_ID      number(4),
 TAG_TYPE     number(1) check (TAG_TYPE in (1, 2, 3)),
 NAME         varchar2(50),
 DESCRIP      varchar2(500),
 CREATED_AT   date default sysdate,
 UPDATED_AT   date,
 UPDATED_BY   varchar2(30),
 constraint PK_TAGS primary key (TAGS_ID) using index);
--
COMMENT ON TABLE TAGS             IS 'Tags catalog';
COMMENT ON COLUMN TAGS.TAGS_ID    IS 'Tag unique identifier';
COMMENT ON COLUMN TAGS.TAG_TYPE   IS 'Type of Tag: 1-TOOL 2-KNOWLEDGE 3-TECHNOLOGY';
COMMENT ON COLUMN TAGS.NAME       IS 'Tag name';
COMMENT ON COLUMN TAGS.DESCRIP    IS 'Tag description';
COMMENT ON COLUMN TAGS.CREATED_AT IS 'Record creation date';
COMMENT ON COLUMN TAGS.UPDATED_AT IS 'Record update date';
COMMENT ON COLUMN TAGS.UPDATED_BY IS 'User who updated the record';
--
create table PROJECTS_TAGS	
(PROJROLES_ID number(4),
 TAGS_ID      number(4),
 DESCRIP      varchar2(500),
 DATE_IN      date,
 DATE_OUT     date,
 CREATED_AT   date default sysdate,
 UPDATED_AT   date,
 UPDATED_BY   varchar2(30),
 constraint PK_PROJSTAGS primary key (PROJROLES_ID, TAGS_ID) using index);
--
ALTER TABLE PROJECTS_TAGS ADD (
  CONSTRAINT FK_PROJTAGS_PROGROLES
  FOREIGN KEY (PROJROLES_ID) 
  REFERENCES PROJECTS_ROLES(PROJROLES_ID));
--
ALTER TABLE PROJECTS_TAGS ADD (
  CONSTRAINT FK_PROJTAGS_TAGS
  FOREIGN KEY (TAGS_ID) 
  REFERENCES TAGS(TAGS_ID));
--
COMMENT ON TABLE PROJECTS_TAGS               IS 'Relation of Projects and Tags';
COMMENT ON COLUMN PROJECTS_TAGS.PROJROLES_ID IS 'Projects/Roles unique identifier';
COMMENT ON COLUMN PROJECTS_TAGS.TAGS_ID      IS 'Tag unique identifier';
COMMENT ON COLUMN PROJECTS_TAGS.DESCRIP      IS 'Description';
COMMENT ON COLUMN PROJECTS_TAGS.DATE_IN      IS 'Date In';
COMMENT ON COLUMN PROJECTS_TAGS.DATE_OUT     IS 'Date Out';
COMMENT ON COLUMN PROJECTS_TAGS.CREATED_AT   IS 'Record creation date';
COMMENT ON COLUMN PROJECTS_TAGS.UPDATED_AT   IS 'Record update date';
COMMENT ON COLUMN PROJECTS_TAGS.UPDATED_BY   IS 'User who updated the record';
--
create table ROLES_REPONSABILITES	
(ROLES_REPONSABILITES_ID number(4),
 ROLES_ID        number(4),
 DESCRIP         varchar2(500),
 CREATED_AT      date default sysdate,
 UPDATED_AT      date,
 UPDATED_BY      varchar2(30),
 constraint PK_ROLESRESPS primary key (ROLES_REPONSABILITES_ID) using index);
 --
 ALTER TABLE ROLES_REPONSABILITES ADD (
  CONSTRAINT FK_ROLESREPONS_ROLES
  FOREIGN KEY (ROLES_ID) 
  REFERENCES ROLES(ROLES_ID));
--
COMMENT ON TABLE ROLES_REPONSABILITES                          IS 'Description of Responsabilities in Roles';
COMMENT ON COLUMN ROLES_REPONSABILITES.ROLES_REPONSABILITES_ID IS 'Responsabilities/Roles unique identifier';
COMMENT ON COLUMN ROLES_REPONSABILITES.ROLES_ID                IS 'Roles unique identifier';
COMMENT ON COLUMN ROLES_REPONSABILITES.DESCRIP                 IS 'Description';
COMMENT ON COLUMN ROLES_REPONSABILITES.CREATED_AT              IS 'Record creation date';
COMMENT ON COLUMN ROLES_REPONSABILITES.UPDATED_AT              IS 'Record update date';
COMMENT ON COLUMN ROLES_REPONSABILITES.UPDATED_BY              IS 'User who updated the record';
--
create table CANDIDATES_TRAININGS	
(CANDIDATES_TRAININGS_ID number(4),
 CANDIDATES_ID           number(8),
 NAME                    varchar2(50),
 DESCRIP                 varchar2(500),
 YEAR_TRAINING           date,
 CREATED_AT              date default sysdate,
 UPDATED_AT              date,
 UPDATED_BY              varchar2(30),
 constraint PK_CANDTRAIN primary key (CANDIDATES_TRAININGS_ID, CANDIDATES_ID) using index);
 --
 ALTER TABLE CANDIDATES_TRAININGS ADD (
  CONSTRAINT FK_CANDTRAIN
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
COMMENT ON TABLE CANDIDATES_TRAININGS                          IS 'Candidates trainings description';
COMMENT ON COLUMN CANDIDATES_TRAININGS.CANDIDATES_TRAININGS_ID IS 'Candidates/Trainings unique identifier';
COMMENT ON COLUMN CANDIDATES_TRAININGS.CANDIDATES_ID           IS 'Candidates unique identifier';
COMMENT ON COLUMN CANDIDATES_TRAININGS.NAME                    IS 'Name';
COMMENT ON COLUMN CANDIDATES_TRAININGS.DESCRIP                 IS 'Description';
COMMENT ON COLUMN CANDIDATES_TRAININGS.YEAR_TRAINING           IS 'Training Year';
COMMENT ON COLUMN CANDIDATES_TRAININGS.CREATED_AT              IS 'Record creation date';
COMMENT ON COLUMN CANDIDATES_TRAININGS.UPDATED_AT              IS 'Record update date';
COMMENT ON COLUMN CANDIDATES_TRAININGS.UPDATED_BY              IS 'User who updated the record';
--
create table CERTIFICATIONS	
(CERTIFICATIONS_ID number(4),
 NAME              varchar2(50),
 DESCRIP           varchar2(500),
 APPROVED_FLAG     varchar2(1) check (APPROVED_FLAG in ('Y','N')),
 APPROVED_BY       varchar2(30),
 CREATED_AT        date default sysdate,
 UPDATED_AT        date,
 UPDATED_BY        varchar2(30),
 constraint PK_CERTIFICATIONS primary key (CERTIFICATIONS_ID) using index);
--
COMMENT ON TABLE CERTIFICATIONS                    IS 'Certifications catalog';
COMMENT ON COLUMN CERTIFICATIONS.CERTIFICATIONS_ID IS 'Certifications unique identifier';
COMMENT ON COLUMN CERTIFICATIONS.NAME              IS 'Certification name';
COMMENT ON COLUMN CERTIFICATIONS.DESCRIP           IS 'Certification description';
COMMENT ON COLUMN CERTIFICATIONS.APPROVED_FLAG     IS 'Flag of approval, Y-Yes, N-No';
COMMENT ON COLUMN CERTIFICATIONS.APPROVED_BY       IS 'Person who approved';
COMMENT ON COLUMN CERTIFICATIONS.CREATED_AT        IS 'Record creation date';
COMMENT ON COLUMN CERTIFICATIONS.UPDATED_AT        IS 'Record update date';
COMMENT ON COLUMN CERTIFICATIONS.UPDATED_BY        IS 'User who updated the record';
--
create table CANDIDATES_CERTIFICATIONS	
(CERTIFICATIONS_ID       number(4),
 CANDIDATES_ID           number(8),
 YEAR_CERTIFICATION      date,
 CREATED_AT              date default sysdate,
 UPDATED_AT              date,
 UPDATED_BY              varchar2(30),
 constraint PK_CANDCERTS primary key (CERTIFICATIONS_ID, CANDIDATES_ID) using index);
 --
 ALTER TABLE CANDIDATES_CERTIFICATIONS ADD (
  CONSTRAINT FK_CANDCERTIF
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
ALTER TABLE CANDIDATES_CERTIFICATIONS ADD (
  CONSTRAINT FK_CANDCERTF_CERTIFICATIONS
  FOREIGN KEY (CERTIFICATIONS_ID) 
  REFERENCES CERTIFICATIONS(CERTIFICATIONS_ID));
--
COMMENT ON TABLE CANDIDATES_CERTIFICATIONS                          IS 'Table of Trainings in Candidates';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.CANDIDATES_TRAININGS_ID IS 'Candidates/Trainings unique identifier';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.CANDIDATES_ID           IS 'Candidates unique identifier';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.YEAR_CERTIFICATION      IS 'Description';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.CREATED_AT              IS 'Record creation date';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.UPDATED_AT              IS 'Record update date';
COMMENT ON COLUMN CANDIDATES_CERTIFICATIONS.UPDATED_BY              IS 'User who updated the record';
--
create table LANGUAGES	
(LANGUAGES_ID      number(4),
 NAME              varchar2(50),
 DESCRIP           varchar2(500),
 APPROVED_FLAG     varchar2(1) check (APPROVED_FLAG in ('Y','N')),
 APPROVED_BY       varchar2(30),
 CREATED_AT        date default sysdate,
 UPDATED_AT        date,
 UPDATED_BY        varchar2(30),
 constraint PK_LANGUAGES primary key (LANGUAGES_ID) using index);
--
COMMENT ON TABLE LANGUAGES                    IS 'Languages catalog';
COMMENT ON COLUMN LANGUAGES.LANGUAGES_ID      IS 'Languages unique identifier';
COMMENT ON COLUMN LANGUAGES.NAME              IS 'Language name';
COMMENT ON COLUMN LANGUAGES.DESCRIP           IS 'Language description';
COMMENT ON COLUMN LANGUAGES.APPROVED_FLAG     IS 'Flag of approval, Y-Yes, N-No';
COMMENT ON COLUMN LANGUAGES.APPROVED_BY       IS 'Person who approved';
COMMENT ON COLUMN LANGUAGES.CREATED_AT        IS 'Record creation date';
COMMENT ON COLUMN LANGUAGES.UPDATED_AT        IS 'Record update date';
COMMENT ON COLUMN LANGUAGES.UPDATED_BY        IS 'User who updated the record';
--
create table CANDIDATES_LANGUAGES	
(LANGUAGES_ID            number(4),
 CANDIDATES_ID           number(8),
 LEVEL_ID                number(1) check (LEVEL_ID in (1, 2, 3, 4, 5, 6)),
 NAME                    varchar2(50),
 CREATED_AT              date default sysdate,
 UPDATED_AT              date,
 UPDATED_BY              varchar2(30),
 constraint PK_CANDLANGS primary key (LANGUAGES_ID, CANDIDATES_ID) using index);
 --
 ALTER TABLE CANDIDATES_LANGUAGES ADD (
  CONSTRAINT FK_CANDLANGS
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
ALTER TABLE CANDIDATES_LANGUAGES ADD (
  CONSTRAINT FK_CANDLANG_LANGUAGES
  FOREIGN KEY (LANGUAGES_ID) 
  REFERENCES LANGUAGES(LANGUAGES_ID));
--
COMMENT ON TABLE CANDIDATES_LANGUAGES                IS 'Table of Languages in Candidates';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.LANGUAGES_ID  IS 'Languages unique identifier';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.CANDIDATES_ID IS 'Candidates unique identifier';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.LEVEL_ID      IS 'Level: 1-Advanced, 2-Upper intermediate, 3-Intermediate, 4-PreIntermediate, 5-Elementary, 6-PreElementary';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.NAME          IS 'Name';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.CREATED_AT    IS 'Record creation date';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.UPDATED_AT    IS 'Record update date';
COMMENT ON COLUMN CANDIDATES_LANGUAGES.UPDATED_BY    IS 'User who updated the record';
--
create table EDUCATION_DEGREES	
(EDUC_DEGREES_ID   number(4),
 NAME              varchar2(50),
 DESCRIP           varchar2(500),
 APPROVED_FLAG     varchar2(1) check (APPROVED_FLAG in ('Y','N')),
 APPROVED_BY       varchar2(30),
 CREATED_AT        date default sysdate,
 UPDATED_AT        date,
 UPDATED_BY        varchar2(30),
 constraint PK_EDUC_DEGREES primary key (EDUC_DEGREES_ID) using index);
--
COMMENT ON TABLE EDUCATION_DEGREES                   IS 'Education degrees catalog';
COMMENT ON COLUMN EDUCATION_DEGREES.EDUC_DEGREES_ID  IS 'Education degrees unique identifier';
COMMENT ON COLUMN EDUCATION_DEGREES.NAME             IS 'Degrees name';
COMMENT ON COLUMN EDUCATION_DEGREES.DESCRIP          IS 'Degrees description';
COMMENT ON COLUMN EDUCATION_DEGREES.APPROVED_FLAG    IS 'Flag of approval, Y-Yes, N-No';
COMMENT ON COLUMN EDUCATION_DEGREES.APPROVED_BY      IS 'Person who approved';
COMMENT ON COLUMN EDUCATION_DEGREES.CREATED_AT       IS 'Record creation date';
COMMENT ON COLUMN EDUCATION_DEGREES.UPDATED_AT       IS 'Record update date';
COMMENT ON COLUMN EDUCATION_DEGREES.UPDATED_BY       IS 'User who updated the record';
--
create table CAND_EDUC_DEGREES	
(EDUC_DEGREES_ID number(4),
 CANDIDATES_ID   number(8),
 UNIVERSITY      varchar2(50),
 TITLE           varchar2(50),
 DEGREE          varchar2(50),
 GRADUATION_YEAR number(4),
 DATE_IN         date,
 DATE_OUT        date,
 CREATED_AT      date default sysdate,
 UPDATED_AT      date,
 UPDATED_BY      varchar2(30),
 constraint PK_CANDEDUCDEG primary key (EDUC_DEGREES_ID, CANDIDATES_ID) using index);
 --
 ALTER TABLE CAND_EDUC_DEGREES ADD (
  CONSTRAINT FK_CANDEDUCDEG
  FOREIGN KEY (CANDIDATES_ID) 
  REFERENCES CANDIDATES(CANDIDATES_ID));
--
ALTER TABLE CAND_EDUC_DEGREES ADD (
  CONSTRAINT FK_CANDEDUC_EDUCDEGREES
  FOREIGN KEY (EDUC_DEGREES_ID) 
  REFERENCES EDUCATION_DEGREES(EDUC_DEGREES_ID));
--
COMMENT ON TABLE CAND_EDUC_DEGREES                       IS 'Description of Educations in Candidates';
COMMENT ON COLUMN CAND_EDUC_DEGREES.EDUCATIONS_DEGREE_ID IS 'Education degrees unique identifier';
COMMENT ON COLUMN CAND_EDUC_DEGREES.CANDIDATES_ID        IS 'Candidates unique identifier';
COMMENT ON COLUMN CAND_EDUC_DEGREES.UNIVERSITY           IS 'University Name';
COMMENT ON COLUMN CAND_EDUC_DEGREES.TITLE                IS 'Title';
COMMENT ON COLUMN CAND_EDUC_DEGREES.DEGREE               IS 'Degree';
COMMENT ON COLUMN CAND_EDUC_DEGREES.GRADUATION_YEAR      IS 'Year';
COMMENT ON COLUMN CAND_EDUC_DEGREES.DATE_IN              IS 'Date In';
COMMENT ON COLUMN CAND_EDUC_DEGREES.DATE_OUT             IS 'Date Out';
COMMENT ON COLUMN CAND_EDUC_DEGREES.CREATED_AT           IS 'Record creation date';
COMMENT ON COLUMN CAND_EDUC_DEGREES.UPDATED_AT           IS 'Record update date';
COMMENT ON COLUMN CAND_EDUC_DEGREES.UPDATED_BY           IS 'User who updated the record';
---------**********************************************