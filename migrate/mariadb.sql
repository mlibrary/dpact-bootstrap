-- All tables, keys, indexes, and constraints for authz_umichlib in MariaDB.
CREATE TABLE aa_user(
	userid		 		VARCHAR(64)	NOT NULL,
	personalTitle			VARCHAR(32),
	givenName			VARCHAR(32)	NOT NULL,
	initials			VARCHAR(32),
	surname				VARCHAR(32)	NOT NULL,
	rfc822Mailbox			VARCHAR(64),
	organizationalUnitName		VARCHAR(128),
	postalAddress                   VARCHAR(128),
	localityName			VARCHAR(32),
	stateOrProvinceName             VARCHAR(32),
	postalCode			VARCHAR(9),
	countryName			VARCHAR(32),
	telephoneNumber			VARCHAR(32),
	organizationalStatus		VARCHAR(8),
	dlpsCourse			VARCHAR(8),
	dlpsKey				VARCHAR(32)	NOT NULL,
	userPassword			VARCHAR(32)	NOT NULL,
	manager				INT,
	description			VARCHAR(2048),
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
	dlpsExpiryTime  		DATETIME,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (userid)
);

CREATE TABLE aa_user_grp(
	uniqueIdentifier		INT	NOT NULL,
	commonName			VARCHAR(128)	NOT NULL,
	manager				INT,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (uniqueIdentifier)
);

CREATE TABLE aa_inst(
	uniqueIdentifier		INT	NOT NULL,
	organizationName		VARCHAR(128)	NOT NULL,
	manager				INT,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (uniqueIdentifier)
);

CREATE TABLE aa_is_member_of_inst(
	userid				VARCHAR(64)	NOT NULL,
	inst				INT	NOT NULL,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (userid, inst)
);

CREATE TABLE aa_is_member_of_grp(
	userid				VARCHAR(64),
	user_grp			INT	NOT NULL,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (userid, user_grp)
);

CREATE TABLE aa_coll(
	uniqueIdentifier		VARCHAR(32)	NOT NULL,
	commonName			VARCHAR(128)	NOT NULL,
	description			VARCHAR(128)	NOT NULL,
	dlpsClass			VARCHAR(10),
	dlpsSource			VARCHAR(128)  	NOT NULL,
	dlpsAuthenMethod		VARCHAR(3)	NOT NULL,
	dlpsAuthzType			CHAR(1)    	NOT NULL,
        dlpsPartlyPublic		CHAR(1)         NOT NULL,
	manager				INT,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (uniqueIdentifier)
);

CREATE TABLE aa_coll_obj(
	dlpsServer			VARCHAR(128)	NOT NULL,
	dlpsPath			VARCHAR(128)	NOT NULL,
	coll				VARCHAR(32)	NOT NULL,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (dlpsServer, dlpsPath, coll)
);

CREATE TABLE aa_network(
	uniqueIdentifier		INT	NOT NULL,
	dlpsDNSName			VARCHAR(128),
	dlpsCIDRAddress			VARCHAR(18),
	dlpsAddressStart		INT UNSIGNED,
	dlpsAddressEnd  		INT UNSIGNED,
	dlpsAccessSwitch		VARCHAR(5)	NOT NULL,
	coll				VARCHAR(32),
	inst				INT,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (uniqueIdentifier)
);

CREATE TABLE aa_may_access(
	uniqueIdentifier		INT	NOT NULL,
	userid				VARCHAR(64),
	user_grp			INT,
	inst				INT,
	coll				VARCHAR(32)	NOT NULL,
	lastModifiedTime		TIMESTAMP	NOT NULL,
	lastModifiedBy			VARCHAR(64)	NOT NULL,
	dlpsExpiryTime  		TIMESTAMP,
        dlpsDeleted                     CHAR(1)         NOT NULL,
	PRIMARY KEY (uniqueIdentifier)
);


ALTER TABLE aa_user ADD FOREIGN KEY
  user_manager (manager)
  REFERENCES aa_user_grp (uniqueIdentifier);

ALTER TABLE aa_user ADD FOREIGN KEY
  user_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_user_grp ADD FOREIGN KEY
  user_grp_manager (manager)
  REFERENCES aa_user_grp (uniqueIdentifier);

ALTER TABLE aa_user_grp ADD FOREIGN KEY
  user_grp_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_inst ADD FOREIGN KEY
  inst_manager (manager)
  REFERENCES aa_user_grp (uniqueIdentifier);

ALTER TABLE aa_inst ADD FOREIGN KEY
  inst_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_is_member_of_inst ADD FOREIGN KEY
  is_member_of_inst_user (userid)
  REFERENCES aa_user (userid)
  ON DELETE CASCADE;

ALTER TABLE aa_is_member_of_inst ADD FOREIGN KEY
  is_member_of_inst_inst (inst)
  REFERENCES aa_inst (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_is_member_of_inst ADD FOREIGN KEY
  is_mem_inst_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_is_member_of_grp ADD FOREIGN KEY
  is_member_of_grp_user (userid)
  REFERENCES aa_user (userid)
  ON DELETE CASCADE;

ALTER TABLE aa_is_member_of_grp ADD FOREIGN KEY
  is_member_of_grp_user_grp (user_grp)
  REFERENCES aa_user_grp (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_is_member_of_grp ADD FOREIGN KEY
  is_mem_grp_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_coll ADD FOREIGN KEY
  coll_manager (manager)
  REFERENCES aa_user_grp (uniqueIdentifier);

ALTER TABLE aa_coll ADD FOREIGN KEY
  coll_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_coll_obj ADD FOREIGN KEY
  coll_obj_coll (coll)
  REFERENCES aa_coll (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_coll_obj ADD FOREIGN KEY
  coll_obj_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_network ADD FOREIGN KEY
  network_coll (coll)
  REFERENCES aa_coll (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_network ADD FOREIGN KEY
  network_inst (inst)
  REFERENCES aa_inst (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_network ADD FOREIGN KEY
  network_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid);

ALTER TABLE aa_may_access ADD FOREIGN KEY
  may_access_user (userid)
  REFERENCES aa_user (userid)
  ON DELETE CASCADE;

ALTER TABLE aa_may_access ADD FOREIGN KEY
  may_access_user_grp (user_grp)
  REFERENCES aa_user_grp (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_may_access ADD FOREIGN KEY
  may_access_inst (inst)
  REFERENCES aa_inst (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_may_access ADD FOREIGN KEY
  may_access_coll (coll)
  REFERENCES aa_coll (uniqueIdentifier)
  ON DELETE CASCADE;

ALTER TABLE aa_may_access ADD FOREIGN KEY
  may_access_lastModifiedBy (lastModifiedBy)
  REFERENCES aa_user (userid)
  ON DELETE CASCADE;

-- additional indexes:

ALTER TABLE aa_network ADD INDEX (dlpsAddressStart);
ALTER TABLE aa_network ADD INDEX (dlpsAddressEnd);
ALTER TABLE aa_coll_obj ADD INDEX (dlpsPath);

-- additional constraints
ALTER TABLE aa_user ADD CONSTRAINT user_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_user_grp ADD CONSTRAINT user_grp_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_inst ADD CONSTRAINT inst_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_is_member_of_inst ADD CONSTRAINT is_member_of_inst_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_is_member_of_grp ADD CONSTRAINT is_member_of_grp_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_coll ADD CONSTRAINT coll_dlpsAuthenMethod
  CHECK (dlpsAuthenMethod IN ('any', 'ip', 'pw'));

ALTER TABLE aa_coll ADD CONSTRAINT coll_dlpsAuthzType
  CHECK (dlpsAuthzType IN ('n', 'd', 'm'));

ALTER TABLE aa_coll ADD CONSTRAINT coll_dlpsPartlyPublic
  CHECK (dlpsPartlyPublic IN ('t', 'f'));

ALTER TABLE aa_coll ADD CONSTRAINT coll_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_coll_obj ADD CONSTRAINT coll_obj_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_network ADD CONSTRAINT network_dlpsAccessSwitch
  CHECK (dlpsAccessSwitch IN ('allow', 'deny'));

ALTER TABLE aa_network ADD CONSTRAINT network_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));

ALTER TABLE aa_may_access ADD CONSTRAINT may_access_dlpsDeleted
  CHECK (dlpsDeleted IN ('t', 'f'));


-------- for new database, root user/gropu is needed; for migrated, skip.
-- INSERT
--   INTO aa_user
--        (userid, givenName, surname, rfc822Mailbox,
-- 	dlpsKey, userPassword, manager,
-- 	lastModifiedTime, lastModifiedBy, dlpsDeleted)
--   VALUES('root', 'Super', 'User', 'lit-cs-sysadmin@umich.edu',
-- 	 '!none', '!none', 0,
-- 	 SYSDATE, 'root', 'f');
-- 
-- PROMPT . --> adding root user group
-- INSERT INTO aa_user_grp VALUES(
-- 	0, 'root', 0, SYSDATE, 'root', 'f');
-- 
-- PROMPT . --> adding root user to root user group
-- INSERT INTO aa_is_member_of_grp VALUES(
-- 	'root', 0, sysdate, 'root', 'f');

/*
constraints:

aa_user
  user_manager			| manager -> aa_user_grp.uniqueIdentifier
  user_lastModifiedBy		| lastModifiedBy -> aa_user.userid
  user_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_user_grp
  user_grp_manager		| manager -> aa_user_grp.uniqueIdentifier
  user_grp_lastModifiedBy	| lastModifiedBy -> aa_user.userid
  user_grp_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_inst
  inst_manager			| manager -> aa_user_grp.uniqueIdentifier
  inst_lastModifiedBy		| lastModifiedBy -> aa_user.userid
  inst_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_is_member_of_inst
  is_member_of_inst_user	| userid -> aa_user.userid [DELETE CASCADE]
  is_member_of_inst_inst	| inst -> aa_inst.uniqueIdentifier [DELETE CASCADE]
  is_mem_inst_lastModifiedBy	| lastModifiedBy -> aa_user.userid
  is_member_of_inst_dlpsDeleted	| dlpsDeleted IN 't', 'f'
aa_is_member_of_grp
  is_member_of_grp_user		| userid -> aa_user.userid [DELETE CASCADE]
  is_member_of_grp_user_grp	| user_grp -> aa_user_grp.uniqueIdentifier [DELETE CASCADE]
  is_mem_grp_lastModifiedBy	| lastModifiedBy -> aa_user.userid
  is_member_of_grp_dlpsDeleted	| dlpsDeleted IN 't', 'f'
aa_coll
  coll_dlpsAuthenMethod		| dlpsAuthenMethod IN any, 'ip', 'pw'
  coll_dlpsAuthzType		| dlpsAuthzType IN 'n', 'd', 'm'
  coll_dlpsPartlyPublic		| dlpsPartlyPublic IN 't', 'f'
  coll_manager			| manager -> aa_user_grp.uniqueIdentifier
  coll_lastModifiedBy		| lastModifiedBy -> aa_user.userid
  coll_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_coll_obj
  coll_obj_coll			| coll -> aa_coll.uniqueIdentifier [DELETE CASCADE]
  coll_obj_lastModifiedBy	| lastModifiedBy -> aa_user.userid
  coll_obj_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_network
  network_dlpsAccessSwitch	| dlpsAccessSwitch IN 'allow', 'deny'
  network_coll			| coll -> aa_coll.uniqueIdentifier [DELETE CASCADE]
  network_inst			| inst -> aa_inst.uniqueIdentifier [DELETE CASCADE]
  network_lastModifiedBy	| lastModifiedBy -> aa_user.userid
  network_dlpsDeleted		| dlpsDeleted IN 't', 'f'
aa_may_access
  may_access_user		| userid -> aa_user.userid [DELETE CASCADE]
  may_access_user_grp		| user_grp -> aa_user_grp.uniqueIdentifier [DELETE CASCADE]
  may_access_inst		| inst -> aa_inst.uniqueIdentifier [DELETE CASCADE]
  may_access_coll		| coll -> aa_coll.uniqueIdentifier [DELETE CASCADE]
  may_access_lastModifiedBy	| lastModifiedBy -> aa_user.userid [DELETE CASCADE]
  dlpsDeleted			| dlpsDeleted IN 't', 'f'
*/
  

