-- DB update 2018_04_09_00 -> 2018_05_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_04_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_04_09_00 2018_05_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1525438412721008951'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1525438412721008951');

UPDATE `creature_template` SET `scriptname` = 'npc_the_etymidian' WHERE `entry` = 28092;
UPDATE `creature_template` SET `scriptname` = '' WHERE `entry` = 28033;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
